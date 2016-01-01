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
use Symfony\Component\Console\Input\InputOption;
use Assetic\Exception\Exception;
use Monolog\Logger;
use SK\ITCBundle\Code\Reflection\Reflection;
use SK\ITCBundle\Command\TableCommand;
use Symfony\Component\Console\Input\InputInterface;

class ReflectionCommand extends TableCommand
{

	/**
	 *
	 * @var Reflection $reflection
	 */
	protected $reflection;

	protected static function getAccessibility( $reflection )
	{
		return $reflection->isPrivate() ? "Private" : ($reflection->isProtected() ? "Protected" : "Public");
	}

	protected static function getStatic( $reflection )
	{
		return $reflection->isStatic() ? "Yes" : "No";
	}

	protected static function getAbstract( $reflection )
	{
		return $reflection->isAbstract() ? "Yes" : "No";
	}

	protected static function getObjectType( $reflection )
	{
		return $reflection->isTrait() ? "Trait" : ($reflection->isInterface() ? "Interface" : "Class");
	}

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
		$this->addOption( "operationAttributeName", "oa", InputOption::VALUE_OPTIONAL,
			"Operations Attributes name, e.g. '^myPrefix|mySuffix$', regular expression allowed." );

		$this->addOption( "accessibility", "ac", InputOption::VALUE_OPTIONAL, "Operations and attributes accessibility: protected, public, private." );
		$this->addOption( "parentClass", "pc", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY, "Parent Class Name, e.g 'My\Class'" );
		$this->addOption( "fileSuffix", "fs", InputOption::VALUE_OPTIONAL, "File suffixes for given src, default all and not dot files.", "*.php" );
		$this->addOption( "followLinks", "fl", InputOption::VALUE_OPTIONAL, "Follows links.", false );

		$this->addOption( "is-interface", "ii", InputOption::VALUE_REQUIRED, "Reflect Interfaces Objects Only, possible values are (true|false)." );
		$this->addOption( "is-trait", "it", InputOption::VALUE_REQUIRED, "Reflect Traits Objects Only, possible values are (true|false)." );
		$this->addOption( "is-abstract-class", "ib", InputOption::VALUE_REQUIRED, "Reflect Abstract Classes Only, possible values are (true|false)." );
		$this->addOption( "is-final", "if", InputOption::VALUE_REQUIRED, "Reflect Final Classes Only, possible values are (true|false)." );
		$this->addOption( "is-abstract", "ia", InputOption::VALUE_REQUIRED, "Reflect Abstract Classes Only, possible values are (true|false)." );
		$this->addOption( "is-private", "ip", InputOption::VALUE_REQUIRED,
			"Reflect Private Operations or Attributes, possible values are (true|false)." );
		$this->addOption( "is-protected", "id", InputOption::VALUE_REQUIRED,
			"Reflect Protected Operations or Attributes, possible values are (true|false)." );
		$this->addOption( "is-public", "ic", InputOption::VALUE_REQUIRED,
			"Reflect Public Operations or Attributes, possible values are (true|false)." );
		$this->addOption( "is-static", "is", InputOption::VALUE_REQUIRED,
			"Reflect Static Operations or Attributes, possible values are (true|false)." );
		$this->addOption( "implements-interface", "imi", InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY, "Reflect Abstract Classes Only." );
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

		$src = $this->getInput()
			->getArgument( "src" );

		$this->writeInfo( sprintf( "Searching files in '%s' sources.", implode( "', '", $src ) ) );

		$finder = $this->getReflection()
			->getFinder();

		/**
		 * Finder has to have at minimum one file.
		 */
		$canContinue = false;

		foreach( $src as $source )
		{
			try
			{
				if( ! file_exists( $source ) )
				{
					$this->writeNotice( sprintf( "Finder Source '%s' not Exists.", $source ), OutputInterface::VERBOSITY_VERBOSE );
				}

				if( is_dir( $source ) )
				{
					$canContinue = true;
					$finder->in( $source );
					$this->writeInfo( sprintf( "Finder Adding directory '%s'.", $source ), OutputInterface::VERBOSITY_VERY_VERBOSE );
				}

				if( is_file( $source ) )
				{
					$canContinue = true;
					$finder->append( array(
						$source
					) );

					$this->writeInfo( sprintf( "Finder Adding file '%s'.", $source ), OutputInterface::VERBOSITY_VERY_VERBOSE );
				}
			}
			catch( \Exception $e )
			{
				$this->writeException( $e );
			}
		}

		if( $this->getInput()
			->hasOption( "bootstrap" ) )
		{
			$bootstrap = $this->getInput()
				->getOption( "bootstrap" );

			try
			{
				if( NULL === $bootstrap )
				{
					$this->writeInfo( sprintf( "Finder Boostrap not set.", $bootstrap ), OutputInterface::VERBOSITY_VERY_VERBOSE );
				}
				elseif( file_exists( $bootstrap ) )
				{
					@require_once $bootstrap;

					$finder->append( array(
						$bootstrap
					) );
					$this->writeInfo( sprintf( "Finder Adding Boostrap'%s'", $bootstrap ), OutputInterface::VERBOSITY_VERY_VERBOSE );
				}
				else
				{
					$this->writeInfo( sprintf( "Finder Boostrap '%s' not exists.", $bootstrap ), OutputInterface::VERBOSITY_VERY_VERBOSE );
				}
			}
			catch( \Exception $e )
			{
				$this->writeException( $e );
			}
		}

		if( $this->getInput()
			->hasOption( "followLinks" ) )
		{
			try
			{
				$followLinks = $this->getInput()
					->getOption( "followLinks" );

				if( true === $followLinks )
				{
					$finder->followLinks();
				}

				$this->writeInfo( sprintf( "Finder following links '%s'.", $followLinks ? 'yes' : 'no' ), OutputInterface::VERBOSITY_VERY_VERBOSE );
			}
			catch( \Exception $e )
			{
				$this->writeException( $e );
			}
		}

		if( $this->getInput()
			->hasOption( "ignoreDotFiles" ) )
		{
			try
			{
				$ignoreDotFiles = $this->getInput()
					->getOption( "ignoreDotFiles" );

				$finder->ignoreDotFiles( $ignoreDotFiles );

				$this->writeInfo( sprintf( "Finder ignoring dot files '%s'.", $ignoreDotFiles ? 'yes' : 'no' ),
					OutputInterface::VERBOSITY_VERY_VERBOSE );
			}
			catch( \Exception $e )
			{
				$this->writeException( $e );
			}
		}

		if( $this->getInput()
			->hasOption( "fileSuffix" ) )
		{
			try
			{
				$fileSuffix = $this->getInput()
					->getOption( "fileSuffix" );
				$finder->name( $fileSuffix );

				$this->writeInfo( sprintf( "Finder applying file suffix '%s'.", $fileSuffix ), OutputInterface::VERBOSITY_VERY_VERBOSE );
			}
			catch( \Exception $e )
			{
				$this->writeException( $e );
			}
		}

		$exclude = $this->getInput()
			->getOption( "exclude" );

		if( $this->getInput()
			->hasOption( "exclude" ) && $exclude )
		{
			try
			{
				$finder->exclude( $this->getInput()
					->getOption( "exclude" ) );

				$this->writeInfo( sprintf( "Finder applying exclude '%s'.", implode( ",", $exclude ) ), OutputInterface::VERBOSITY_VERY_VERBOSE );
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
		return $this->reflection;
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
}