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

		$this->addOption( "bootstrap", "bs", InputOption::VALUE_OPTIONAL, "PHP Boostrap File. If you need your own project specific bootrap." );

		/* File Filters */
		$this->addOption( "fileSuffix", "fs", InputOption::VALUE_OPTIONAL, "Files filter suffixes for given src, default all and not dot files.",
			"*.php" );
		$this->addOption( "ignoreDotFiles", "df", InputOption::VALUE_OPTIONAL, "Files filter ignore DOT files.", true );
		$this->addOption( "followLinks", "fl", InputOption::VALUE_OPTIONAL, "Files filter follows links.", false );
		$this->addOption( "exclude", "ed", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY,
			"Files filter excludes directory(ies) from given source" );
		$this->addOption( "--date", "dt", InputOption::VALUE_OPTIONAL,
			"The date must be something that strtotime() is able to parse: 'since yesterday', 'until 2 days ago', '> now - 2 hours', '>= 2005-10-15'" );

		/* Class Filters */
		$this->addOption( "className", "cn", InputOption::VALUE_OPTIONAL,
			"Classes filter name, e.g. '^myPrefix|mySuffix$', regular expression allowed.", NULL );
		$this->addOption( "parentClass", "pc", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY,
			"Classes filter parent Class Name, e.g 'My\Class'" );
		$this->addOption( "isInterface", "ii", InputOption::VALUE_REQUIRED, "Classes filter reflects interfaces objects only, (1|0)." );
		$this->addOption( "isTrait", "it", InputOption::VALUE_REQUIRED, "Classes filter reflects traits objects only, (1|0)." );
		$this->addOption( "isAbstractClass", "ib", InputOption::VALUE_REQUIRED, "Classes filter reflect abstract classes only, (1|0)." );
		$this->addOption( "isFinal", "if", InputOption::VALUE_REQUIRED, "Classes filter reflect Final Classes Only, (1|0)." );
		$this->addOption( "implementsInterface", "imi", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY,
			"Classes filter reflect abstract classes only." );

		/* Attribute Filters */
		$this->addOption( "attributeName", "an", InputOption::VALUE_OPTIONAL,
			"Attributes filter name, e.g. '^myPrefix|mySuffix$', regular expression allowed." );

		/* Operation Filters */
		$this->addOption( "operationName", "on", InputOption::VALUE_OPTIONAL,
			"Operations filter name, e.g. '^myPrefix|mySuffix$', regular expression allowed.", NULL );
		$this->addOption( "isAbstractOperation", "ia", InputOption::VALUE_REQUIRED,
			"Operations filter reflect abstract Operation Only, possible values are (1|0)." );

		/* Parameter Filters */
		$this->addOption( "parameterName", "pn", InputOption::VALUE_OPTIONAL,
			"Parameters filter parameter name, e.g. '^myPrefix|mySuffix$', regular expression allowed.", NULL );
		$this->addOption( "parameterRequired", "pr", InputOption::VALUE_OPTIONAL, "Parameters filter parameter is required or optional, .", NULL );

		/* Attributes and Operations Filters */
		$this->addOption( "isPrivate", "ip", InputOption::VALUE_REQUIRED,
			"Attributes and Operations filter reflects private only or exclude it, (1|0)." );
		$this->addOption( "isProtected", "id", InputOption::VALUE_REQUIRED,
			"Attributes and Operations filter reflects protected only or exclude it, (1|0)." );
		$this->addOption( "isPublic", "ic", InputOption::VALUE_REQUIRED,
			"Attributes and Operations filter reflects public only or exclude it, (1|0)." );
		$this->addOption( "isStatic", "is", InputOption::VALUE_REQUIRED,
			"Attributes and Operations filter reflects static only or exclude it, (1|0)." );

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

		$this->writeTable( 120 );
	}

	/**
	 *
	 * @return Reflection
	 * @todo parametrize reflection settings
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
			$reflectionSettings = Settings::getInstance();

			foreach( $this->getInput()->getArguments() as $name => $value )
			{
				if( NULL !== $value )
				{
					$setter = sprintf( "set%s", ucfirst( $name ) );

					if( method_exists( $reflectionSettings, $setter ) )
					{
						call_user_func( array(
							$reflectionSettings,
							$setter
						), $value );
					}
				}
			}

			foreach( $this->getInput()->getOptions() as $name => $value )
			{
				if( NULL !== $value )
				{
					$setter = sprintf( "set%s", ucfirst( $name ) );

					if( method_exists( $reflectionSettings, $setter ) )
					{
						call_user_func( array(
							$reflectionSettings,
							$setter
						), $value );
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
}