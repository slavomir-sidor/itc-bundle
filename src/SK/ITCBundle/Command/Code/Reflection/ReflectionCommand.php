<?php

/**
 * SK ITCBundle Command Code Abstract Reflection
 *
 * @licence GNU GPL
 *
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Reflection;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Finder\Finder;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Assetic\Exception\Exception;
use Monolog\Logger;
use SK\ITCBundle\Code\Reflection;
use SK\ITCBundle\Command\TableCommand;
use SK\ITCBundle\Code\Reflection\Settings;
use TokenReflection\IReflection;

class ReflectionCommand extends TableCommand
{

	/**
	 *
	 * @var Reflection
	 */
	protected $reflection;

	/**
	 *
	 * @var Settings
	 */
	protected $reflectionSettings;

	/**
	 * Constructs SK ITCBundle Abstract Command
	 *
	 * @param string $name
	 *        	SK ITCBundle Abstract Command Name
	 * @param string $description
	 *        	SK ITCBundle Abstract Command Description
	 * @param Logger $logger
	 *        	SK ITCBundle Abstract Command Logger
	 * @param Reflection $reflection
	 *        	SK ITCBundle Abstract Command Reflection
	 */
	public function __construct( $name, $description, Logger $logger, Reflection $reflection )
	{
		parent::__construct( $name, $description, $logger );
		$this->setReflection( $reflection );
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::configure()
	 */
	protected function configure()
	{
		parent::configure();

		$this->addOption( "bootstrap", "bs", InputOption::VALUE_OPTIONAL, "PHP Boostrap File." );
		$this->addOption( "attributeName", "an", InputOption::VALUE_OPTIONAL,
			"Attributes name, e.g. '^myPrefix|mySuffix$', regular expression allowed." );
		$this->addOption( "ignoreDotFiles", "df", InputOption::VALUE_OPTIONAL, "Ignore DOT files.", true );
		$this->addOption( "operationName", "on", InputOption::VALUE_OPTIONAL,
			"Operations name, e.g. '^myPrefix|mySuffix$', regular expression allowed.", NULL );
		$this->addOption( "className", "cn", InputOption::VALUE_OPTIONAL, "Class name, e.g. '^myPrefix|mySuffix$', regular expression allowed.",
			NULL );
		$this->addOption( "parameterName", "pn", InputOption::VALUE_OPTIONAL,
			"Class operation parameter name, e.g. '^myPrefix|mySuffix$', regular expression allowed.", NULL );
		$this->addOption( "accessibility", "ac", InputOption::VALUE_OPTIONAL, "Operations and attributes accessibility: protected, public, private." );
		$this->addOption( "parentClass", "pc", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY, "Parent Class Name, e.g 'My\Class'" );
		$this->addOption( "fileSuffix", "fs", InputOption::VALUE_OPTIONAL, "File suffixes for given src, default all and not dot files.", "*.php" );
		$this->addOption( "followLinks", "fl", InputOption::VALUE_OPTIONAL, "Follows links.", false );
		$this->addOption( "isInterface", "ii", InputOption::VALUE_REQUIRED, "Reflect Interfaces Objects Only, possible values are (true|false)." );
		$this->addOption( "isTrait", "it", InputOption::VALUE_REQUIRED, "Reflect Traits Objects Only, possible values are (true|false)." );
		$this->addOption( "isAbstractClass", "ib", InputOption::VALUE_REQUIRED, "Reflect Abstract Classes Only, possible values are (true|false)." );
		$this->addOption( "isFinal", "if", InputOption::VALUE_REQUIRED, "Reflect Final Classes Only, possible values are (true|false)." );
		$this->addOption( "isAbstractOperation", "ia", InputOption::VALUE_REQUIRED,
			"Reflect Abstract Operation Only, possible values are (true|false)." );
		$this->addOption( "isPrivate", "ip", InputOption::VALUE_REQUIRED,
			"Reflect Private Operations or Attributes, possible values are (true|false)." );
		$this->addOption( "isProtected", "id", InputOption::VALUE_REQUIRED,
			"Reflect Protected Operations or Attributes, possible values are (true|false)." );
		$this->addOption( "isPublic", "ic", InputOption::VALUE_REQUIRED,
			"Reflect Public Operations or Attributes, possible values are (true|false)." );
		$this->addOption( "isStatic", "is", InputOption::VALUE_REQUIRED,
			"Reflect Static Operations or Attributes, possible values are (true|false)." );
		$this->addOption( "implementsInterface", "imi", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY, "Reflect Abstract Classes Only." );
		$this->addOption( "exclude", "ed", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY, "Exclude Directory from source" );

		$this->addArgument( 'src', InputArgument::IS_ARRAY, 'PHP Source directory', array(
			"src/",
			"app/",
			"tests/"
		) );
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\PHPUnit\AbstractGenerator::execute($input, $output)
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		parent::execute( $input, $output );

		$src = $this->getInput()->getArgument( "src" );
		$this->writeInfo( sprintf( "Searching files in '%s' sources.", implode( "', '", $src ) ) );

		$canContinue = false;
		foreach( $src as $source )
		{
			if( file_exists( $source ) || is_dir( $source ) )
			{
				$canContinue = true;
			}
		}

		if( ! $canContinue )
		{
			$this->writeInfo( sprintf( "Sources '%s' doesn't exists.", implode( "', '", $src ) ) );
			return;
		}

		if( $this->getInput()->hasOption( "bootstrap" ) )
		{
			$bootstrap = $this->getInput()->getOption( "bootstrap" );

			try
			{
				if( file_exists( $bootstrap ) )
				{
					@require_once $bootstrap;
					$this->writeInfo( sprintf( "Finder Adding Boostrap'%s'", $bootstrap ), OutputInterface::VERBOSITY_VERY_VERBOSE );
				}
			}
			catch( \Exception $e )
			{
				$this->writeException( $e );
			}
		}

		$this->writeTable( 80 );
	}

	/**
	 *
	 * @return Reflection
	 */
	protected function getReflection()
	{
		return $this->reflection->setSettings( $this->getReflectionSettings() );
	}

	/**
	 *
	 * @param Reflection $reflection
	 */
	protected function setReflection( Reflection $reflection )
	{
		$this->reflection = $reflection;
		return $this;
	}

	/**
	 *
	 * @return Settings
	 */
	protected function getReflectionSettings()
	{
		if( NULL === $this->reflectionSettings )
		{
			$reflectionSettings = new Settings();

			foreach( $this->getInput()->getArguments() as $name => $value )
			{
				if( NULL !== $value )
				{
					switch( $name )
					{
						case "src":
							{
								$reflectionSettings->setSrc( $value );
								break;
							}
					}
				}
			}

			foreach( $this->getInput()->getOptions() as $name => $value )
			{
				if( NULL !== $value )
				{
					switch( $name )
					{
						case "attributeName":
							{
								$reflectionSettings->setAttributeName( $value );
								break;
							}
						case "ignoreDotFiles":
							{
								$reflectionSettings->setIgnoreDotFiles( $value );
								break;
							}
						case "className":
							{
								$reflectionSettings->setClassName( $value );
								break;
							}
						case "operationName":
							{
								$reflectionSettings->setOperationName( $value );
								break;
							}
						case "parameterName":
							{
								$reflectionSettings->setParameterName( $value );
								break;
							}
						case "accessibility":
							{
								$reflectionSettings->setAccessibility( $value );
								break;
							}
						case "parentClass":
							{
								$reflectionSettings->setParentClass( $value );
								break;
							}
						case "fileSuffix":
							{
								$reflectionSettings->setFileSuffix( $value );
								break;
							}
						case "followLinks":
							{
								$reflectionSettings->setFollowLinks( $value );
								break;
							}
						case "isInterface":
							{
								$reflectionSettings->setIsInterface( $value );
								break;
							}
						case "isTrait":
							{
								$reflectionSettings->setIsTrait( $value );
								break;
							}
						case "isAbstractClass":
							{
								$reflectionSettings->setIsAbstractClass( $value );
								break;
							}
						case "isFinal":
							{
								$reflectionSettings->setIsFinal( $value );
								break;
							}
						case "isAbstractOperation":
							{
								$reflectionSettings->setIsAbstractOperation( $value );
								break;
							}
						case "isPrivate":
							{
								$reflectionSettings->setIsPrivate( $value );
								break;
							}
						case "isProtected":
							{
								$reflectionSettings->setIsProtected( $value );
								break;
							}
						case "isPublic":
							{
								$reflectionSettings->setIsPublic( $value );
								break;
							}
						case "isStatic":
							{
								$reflectionSettings->setIsStatic( $value );
								break;
							}
						case "implementsInterface":
							{
								$reflectionSettings->setImplementsInterface( $value );
								break;
							}
						case "exclude":
							{
								$reflectionSettings->setExclude( $value );
								break;
							}
					}
				}
			}
			$this->setReflectionSettings( $reflectionSettings );
		}

		return $this->reflectionSettings;
	}

	/**
	 *
	 * @param Settings $reflectionSettings
	 */
	protected function setReflectionSettings( Settings $reflectionSettings )
	{
		$this->reflectionSettings = $reflectionSettings;
		return $this;
	}

	/**
	 *
	 * @param IReflection $reflection
	 * @return string
	 */
	protected static function getAccessibility( IReflection $reflection )
	{
		return $reflection->isPrivate() ? "Private" : ( $reflection->isProtected() ? "Protected" : "Public" );
	}

	/**
	 *
	 * @param IReflection $reflection
	 * @return string
	 */
	protected static function getStatic( IReflection $reflection )
	{
		return $reflection->isStatic() ? "Yes" : "No";
	}

	/**
	 *
	 * @param IReflection $reflection
	 * @return string
	 */
	protected static function getAbstract( IReflection $reflection )
	{
		return $reflection->isAbstract() ? "Yes" : "No";
	}

	/**
	 *
	 * @param unknown $reflection
	 * @return string
	 */
	protected static function getObjectType( $reflection )
	{
		return $reflection->isTrait() ? "Trait" : ( $reflection->isInterface() ? "Interface" : "Class" );
	}
}