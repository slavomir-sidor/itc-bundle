<?php

/**
 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\PHPUnit;

use Exception as E;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Formatter\OutputFormatter;
use Symfony\Component\Console\Helper\ProgressBar;
use Zend\Stdlib\ArrayObject;
use Zend\Code\Reflection\ClassReflection;
use Zend\Code\Scanner\AggregateDirectoryScanner;
use Zend\Code\Scanner\ClassScanner;
use Zend\Code\Scanner\DirectoryScanner;
use Zend\Code\Scanner\FileScanner;
use Zend\Code\Reflection\FileReflection;
use Zend\Code\Generator\ParameterGenerator;
use SK\ITCBundle\Command\Code\Generator\GeneratorCommand;

abstract class PHPUnitGenerator extends GeneratorCommand
{
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Config
	 *
	 * @var ArrayHash
	 */
	protected $config;
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator PHPUnit File
	 *
	 * @var string
	 */
	protected $phpunit;
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Permutation Data Count
	 *
	 * @var int
	 */
	protected $dataCount;
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Tests Classes
	 *
	 * @var array
	 */
	protected $testClasses;
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Tests Config
	 *
	 * @var Config
	 */
	protected $testConfig;
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Config File Name
	 *
	 * @var string
	 */
	protected $testConfigFilename = 'phpunit.ini';
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Option OPTION_REMOVED_ORPHANED_NO
	 *
	 * @var string
	 */
	const OPTION_REMOVED_ORPHANED_YES = 'yes';
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Option OPTION_REMOVED_ORPHANED_NO
	 *
	 * @var string
	 */
	const OPTION_REMOVED_ORPHANED_NO = 'no';
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Option OPTION_OVERRIDE_OUTPUT_NO
	 *
	 * @var string
	 */
	const OPTION_OVERRIDE_OUTPUT_NO = 'no';
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Option OPTION_OVERRIDE_OUTPUT_YES
	 *
	 * @var string
	 */
	const OPTION_OVERRIDE_OUTPUT_YES = 'yes';
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Option OPTION_VERBOSE_OUTPUT_NO
	 *
	 * @var string
	 */
	const OPTION_VERBOSE_OUTPUT_NO = 'no';
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::configure()
	 */
	protected function configure()
	{
		$this->addArgument( 'dest', InputArgument::OPTIONAL, 'Destination tests directory', "tests" );
		$this->addArgument( 'dataCount', InputArgument::OPTIONAL, 'Dataset permutation count (1) default', 1 );
		parent::configure();
		$this->addOption( "override", "o", InputOption::VALUE_OPTIONAL, "Override outputs yes/no, default no", self::OPTION_OVERRIDE_OUTPUT_NO );
		$this->addOption( "remove-orphaned", "ro", InputOption::VALUE_OPTIONAL, "Remove orphaned yes/no, default no", self::OPTION_REMOVED_ORPHANED_NO );
		$this->addOption( "verbose-output", "vo", InputOption::VALUE_OPTIONAL, "Verbose output yes/no,  default no", self::OPTION_VERBOSE_OUTPUT_NO );
	}
	
	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute( InputInterface $input, OutputInterface $output )
	{
		parent::execute( $input, $output );
		$this->setDest( $input->getArgument( 'dest' ) );
		$this->setDataCount( $input->getArgument( 'dataCount' ) );
	}
	
	/**
	 *
	 * @param OutputInterface $output        	
	 * @param string $testSrc        	
	 */
	public function generatePhpUnit( InputInterface $input, OutputInterface $output )
	{
		$this->writeNotice( $output, sprintf( "Generating PHPUnit" ) );
		
		$dest = $this->getDest();
		
		$phpunit = $this->getPhpunit();
		$phpunitDom = new \DOMDocument();
		
		if( file_exists( $phpunit ) )
		{
			@$phpunitDom->load( $phpunit );
		}
		
		$phpunitConfig = $this->getConfig()->phpunit;
		
		$phpunitXpath = new \DOMXPath( $phpunitDom );
		$phpunitDomElement = $phpunitXpath->query( "/phpunit" )->item( 0 );
		
		if( NULL === $phpunitDomElement )
		{
			$phpunitDomElement = $phpunitDom->createElement( "phpunit" );
			$phpunitDom->appendChild( $phpunitDomElement );
		}
		
		if( $phpunitConfig->offsetExists( 'settings' ) )
		{
			foreach( $phpunitConfig->offsetGet( 'settings' ) as $phpunitAttributeName => $phpunitAttributeValue )
			{
				if( strlen( $phpunitAttributeValue ) > 0 )
				{
					$phpunitAttributeName = str_replace( "_", ":", $phpunitAttributeName );
					$phpunitDomElement->setAttribute( $phpunitAttributeName, $phpunitAttributeValue );
				}
			}
		}
		
		if( $phpunitConfig->offsetExists( 'logging' ) )
		{
			$loggingDomElement = $phpunitXpath->query( "logging", $phpunitDomElement )->item( 0 );
			
			if( NULL === $loggingDomElement )
			{
				$loggingDomElement = $phpunitDom->createElement( "logging" );
				$phpunitDomElement->appendChild( $loggingDomElement );
			}
			
			foreach( $phpunitConfig->offsetGet( 'logging' ) as $log )
			{
				$logDomElement = $phpunitXpath->query( "log[@type='" . $log->type . "']", $loggingDomElement )->item( 0 );
				
				if( NULL == $logDomElement )
				{
					$logDomElement = $phpunitDom->createElement( "log" );
					$loggingDomElement->appendChild( $logDomElement );
				}
				
				foreach( $log as $logAttributeName => $logAttributeValue )
				{
					if( strlen( $logAttributeValue ) > 0 )
					{
						$logDomElement->setAttribute( $logAttributeName, $logAttributeValue );
					}
				}
			}
		}
		
		$testsuitesDomElements = $phpunitXpath->query( "testsuites", $phpunitDomElement );
		$testsuitesDomElement = $testsuitesDomElements->item( 0 );
		
		if( NULL === $testsuitesDomElement )
		{
			$testsuitesDomElement = $phpunitDom->createElement( "testsuites" );
			$phpunitDomElement->appendChild( $testsuitesDomElement );
		}
		
		$cache = new FileStorage( $this->getCacheDirectory() );
		$robotLoader = new RobotLoader();
		$robotLoader->autoRebuild = TRUE;
		$robotLoader->setCacheStorage( $cache );
		$robotLoader->addDirectory( $dest );
		$robotLoader->rebuild();
		$robotLoader->register();
		
		$reflecions = array();
		
		foreach( $robotLoader->getIndexedClasses() as $classType => $class )
		{
			$reflecions[ $classType ] = ReflectionClassType::from( $classType );
		}
		
		foreach( $reflecions as $namespaceName => $reflection )
		{
			$classFilename = sprintf( "%s/%s.%s", $dest, str_replace( "\\", "/", $namespaceName ), "php" );
			
			$testsuitesTestsuiteElement = $phpunitXpath->query( "testsuite[@name='" . $reflection->getNamespaceName() . "']", $testsuitesDomElement )->item( 0 );
			
			if( NULL == $testsuitesTestsuiteElement )
			{
				$testsuitesTestsuiteElement = $phpunitDom->createElement( "testsuite" );
				$testsuitesTestsuiteElement->setAttribute( "name", $reflection->getNamespaceName() );
				$testsuitesDomElement->appendChild( $testsuitesTestsuiteElement );
			}
			
			$testCaseDirectory = sprintf( "%s/%s", $dest, str_replace( "\\", "/", $reflection->getNamespaceName() ) );
			
			$testCaseDirectoryElement = $phpunitXpath->query( "directory[text()='" . $testCaseDirectory . "']", $testsuitesTestsuiteElement )->item( 0 );
			
			if( NULL == $testCaseDirectoryElement )
			{
				$testCaseDirectoryElement = $phpunitDom->createElement( "directory", $testCaseDirectory );
				$testsuitesTestsuiteElement->appendChild( $testCaseDirectoryElement );
			}
			$testCaseDirectoryElement->setAttribute( 'suffix', "Test.php" );
			
			$classTestFileElement = $phpunitXpath->query( "file[text()='" . $classFilename . "']", $testsuitesTestsuiteElement )->item( 0 );
			
			if( NULL == $classTestFileElement )
			{
				$classTestFileElement = $phpunitDom->createElement( "file", $classFilename );
				$testsuitesTestsuiteElement->appendChild( $classTestFileElement );
			}
		}
		
		/*
		 * if (self::REMOVED_ORHNAED_YES ===
		 * $input->getOption('remove-orphaned')) { $testsuitesSuitesDomElement =
		 * $phpunitXpath->query( "testsuites/testsuite", $phpunitDomElement);
		 * foreach ($testsuitesSuitesDomElement as
		 * $testsuitesSuiteDomElement) { $testsuitesSuitesFileElements =
		 * $phpunitXpath->query("file",
		 * $testsuitesSuiteDomElement); foreach ($testsuitesSuitesFileElements
		 * as $fileElements) { if
		 * (!file_exists($fileElements->nodeValue)) {
		 * $testsuitesSuiteDomElement->removeChild($fileElements); } } if
		 * ($testsuitesSuiteDomElement->childNodes->length == 0) {
		 * $testsuitesDomElement->removeChild(
		 * $testsuitesSuiteDomElement); } }
		 */
		
		$phpunitDom->formatOutput = TRUE;
		$phpunitDom->save( $phpunit );
	}
	
	/**
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	public function generateClassCase( InputInterface $input, OutputInterface $output )
	{
		$src = $this->getSrc();
		$dest = $this->getDest();
		
		$configNeon = $this->getNeonData( $dest );
		
		$config = Arrays::get( $configNeon, 'tests', array() );
		$configServices = Arrays::get( $config, 'services', array() );
		$configData = Arrays::get( $config, 'case', array() );
		$configCount = count( $configData );
		
		if( $configCount == 0 )
		{
			return;
		}
		
		$this->writeNotice( $output, "Generating Class Specific Tests: " . $configCount );
		
		$robotLoader = new RobotLoader();
		$robotLoader->autoRebuild = TRUE;
		$robotLoader->setCacheStorage( new FileStorage( $this->getCacheDirectory() ) );
		
		$robotLoader->addDirectory( $dest );
		$robotLoader->rebuild();
		$robotLoader->register();
		
		$autoloaderClasses = $robotLoader->getIndexedClasses();
		$classReflections = array();
		
		foreach( $autoloaderClasses as $class )
		{
			$classReflections[] = $class;
		}
		
		foreach( $configServices as $configName => $configClass )
		{
			$classPrototype = Arrays::get( $configClass, 'class' );
			
			$classType = $classPrototype . "Test";
			
			$classFilename = Arrays::get( $autoloaderClasses, $classType, NULL );
			
			$classGeneratorProperties = array();
			$classGeneratorMethods = array();
			$classGeneratorConst = array();
			$classGeneratorImplements = array();
			$classDependencies = array();
			
			if( NULL === $classFilename )
			{
				$classPrototypeReflection = ReflectionClassType::from( $classPrototype );
				$classParent = "\\" . $classPrototypeReflection->getName() . "Base";
				$classPrototypeName = $classPrototypeReflection->getName();
				
				$classPrototypeGenerator = PhpGeneratorClassType::from( $classPrototypeReflection );
				
				$className = $classPrototypeGenerator->getName() . "Test";
				
				$classReflection = $classPrototypeReflection;
				$classGenerator = new PhpGeneratorClassType( $classReflection );
				$classGenerator->setName( $className );
				$classGenerator->setExtends( $classParent );
				$classGenerator->setImplements( $classGeneratorImplements );
				$classGenerator->setProperties( $classGeneratorProperties );
				$classGenerator->setMethods( $classGeneratorMethods );
				$classGenerator->setConsts( $classGeneratorConst );
				$classGenerator->addProperty( "className", "\\" . $configName );
				
				$classFilename = dirname( str_replace( $this->getRootDir(), $this->getDest(), $classReflection->getFileName() ) ) . DIRECTORY_SEPARATOR . $classGenerator->getName() . ".php";
			} else
			{
				$classReflection = ReflectionClassType::from( $classType );
				$classGenerator = PhpGeneratorClassType::from( $classReflection );
				$classGeneratorConst = $classGenerator->getConsts();
				$classGeneratorProperties = $classGenerator->getProperties();
				$classGeneratorImplements = $classGenerator->getImplements();
				$classGeneratorMethods = $classGenerator->getMethods();
			}
			
			if( 'interface' == $classGenerator->getType() || $classGenerator->isAbstract() )
			{
				continue;
			}
			
			$classGeneratorAnnotation = $classReflection->getAnnotations();
			$classAnnotationsSwitch = Arrays::get( $classGeneratorAnnotation, 'no-test', FALSE );
			
			if( FALSE !== $classAnnotationsSwitch )
			{
				continue;
			}
			
			try
			{
				$instanceProvider = $classReflection->getMethod( "getInstance" );
			} catch( \Exception $e )
			{
				$instanceProvider = $classGenerator->addMethod( "getInstance" );
				$instanceProvider->setBody( 'return parent::getInstance();' );
				$instanceProvider->setDocuments( array( 
						'return' => "@return \\" . $classPrototype 
				) );
			}
			
			$classDependency = "";
			
			foreach( $classDependencies as $dependency => $dependencyClass )
			{
				$classDependency .= "\nuse " . $dependency;
				if( '' == $dependencyClass )
				{
					$classDependency .= " as " . $dependencyClass;
				}
				$classDependency .= ";";
			}
			
			$classCode = sprintf( "<?php\nnamespace %s;\n%s\n%s", $classReflection->getNamespaceName(), $classDependency, $classGenerator );
			
			$this->saveClass( $classCode, new \SplFileInfo( $classFilename ) );
		}
	}
	
	/**
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	public function generateClassFunctionalCase( InputInterface $input, OutputInterface $output )
	{
		$dest = $this->getDest();
		
		$config = Arrays::get( $configNeon, 'tests', array() );
		$configServices = Arrays::get( $config, 'services', array() );
		$configCase = Arrays::get( $config, 'case', array() );
		$configCount = count( $configCase );
		
		$this->writeNotice( $output, "Generating Class Tests Funcional Case: " . $configCount );
		
		if( $configCount == 0 )
		{
			return;
		}
		
		foreach( $configCase as $configName => $configClass )
		{
			$classService = Arrays::get( $configServices, $configName );
			$classType = Arrays::get( $classService, 'class' );
			$classReflection = ReflectionClassType::from( $classType );
			$classGenerator = PhpGeneratorClassType::from( $classType );
			$classAnnotations = $classReflection->getAnnotations();
			$classAnnotationsSwitch = Arrays::get( $classAnnotations, 'no-test', FALSE );
			
			if( FALSE !== $classAnnotationsSwitch )
			{
				continue;
			}
			
			$className = $classGenerator->getName() . "FunctionalTest";
			
			if( 'interface' == $classGenerator->getType() || $classGenerator->isAbstract() )
			{
				continue;
			}
			$classParent = "\\" . $classReflection->getName() . "Base";
			$dependencies = array();
			
			$classGenerator->setName( $className );
			$classGenerator->setExtends( $classParent );
			$classGenerator->setImplements( array() );
			$classGenerator->setProperties( array() );
			$classGenerator->setMethods( array() );
			$classGenerator->setConsts( array() );
			$classNameProperty = $classGenerator->addProperty( "className", $configName );
			$classNameProperty->setVisibility( 'protected' );
			// $classGenerator->addDocument("@runInSeparateProcess");
			
			$classProviderData = array();
			
			foreach( $configClass as $configClassMethod => $paramametersConfig )
			{
				
				$methodReflection = $classReflection->getMethod( $configClassMethod );
				$methodGenerator = Method::from( $methodReflection );
				$methodAnnotations = $methodReflection->getAnnotations();
				$methodAnnotationsReturn = Arrays::get( $methodAnnotations, 'return', NULL );
				$methodAnnotationsSwitch = Arrays::get( $methodAnnotations, 'no-test', FALSE );
				
				if( FALSE !== $methodAnnotationsSwitch )
				{
					continue;
				}
				
				if( $methodReflection->isAbstract() )
				{
					continue;
				}
				
				if( '__construct' == $methodReflection->getName() )
				{
					continue;
				}
				
				if( ! is_callable( array( 
						
						$classReflection->getName(),
						$methodReflection->getName() 
				) ) )
				{
					continue;
				}
				
				$providerName = $methodReflection->getName() . "Provider";
				
				$test = $classGenerator->addMethod( "test_" . $methodReflection->getName() );
				
				$parameters = array();
				$parametersReflections = $methodReflection->getParameters();
				
				if( count( $parametersReflections ) )
				{
					$test->addDocument( "@dataProvider " . $providerName );
					
					$parametersGenerators = array();
					$parametersAnnotations = Arrays::get( $methodAnnotations, 'param', array() );
					
					foreach( $parametersReflections as $parameterId => $parameterReflection )
					{
						
						$parameterGenerator = Parameter::from( $parameterReflection );
						$parameterType = $parameterGenerator->getTypeHint();
						
						if( $parameterType == '' )
						{
							$parameterAnnotation = Arrays::get( $parametersAnnotations, $parameterId, "" );
							
							$parameterAnnotations = explode( " ", $parameterAnnotation );
							$parameterType = Arrays::get( $parameterAnnotations, 0, 'mixed' );
						}
						
						if( $parameterType != '' && $parameterType != 'array' )
						{
							$parameters[] = '$' . $parameterReflection->getName();
						}
						
						$test->addDocument( "@param " . $parameterType . " " . $parameterReflection->getName() );
						
						$parametersGenerators[] = $parameterGenerator;
					}
					
					$test->setParameters( $parametersGenerators );
				}
				
				$body = '';
				$body .= "\n" . '$this->callTest("' . $classGenerator->getName() . '","' . $methodGenerator->getName() . '",' . ($methodGenerator->isStatic() ? 'TRUE' : 'FALSE') . ', func_get_args());';
				$test->setBody( $body );
			}
			
			$classInfo = new \SplFileInfo( dirname( str_replace( $this->getRootDir(), $this->getDest(), $classReflection->getFileName() ) ) . DIRECTORY_SEPARATOR . $classGenerator->getName() . ".php" );
			
			$classDependency = "";
			
			foreach( $dependencies as $dependency => $dependencyClass )
			{
				$classDependency .= "\nuse " . $dependency;
				if( '' == $dependencyClass )
				{
					$classDependency .= " as " . $dependencyClass;
				}
				$classDependency .= ";";
			}
			
			$classCode = sprintf( "<?php\nnamespace %s;\n%s\n%s", $classReflection->getNamespaceName(), $classDependency, $classGenerator );
			
			$this->saveClass( $classCode, $classInfo );
		}
	}
	
	/**
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	public function generateClassPerformanceCase( InputInterface $input, OutputInterface $output )
	{
		$dest = $this->getDest();
		
		$config = Arrays::get( $configNeon, 'tests', array() );
		$configServices = Arrays::get( $config, 'services', array() );
		$configCase = Arrays::get( $config, 'case', array() );
		$configCount = count( $configCase );
		
		$this->writeNotice( $output, "Generating Class Tests Performance Case: " . $configCount );
		
		if( $configCount == 0 )
		{
			return;
		}
		
		foreach( $configCase as $configName => $configClass )
		{
			$classService = Arrays::get( $configServices, $configName );
			$classType = Arrays::get( $classService, 'class' );
			$classReflection = ReflectionClassType::from( $classType );
			$classGenerator = PhpGeneratorClassType::from( $classType );
			$classAnnotations = $classReflection->getAnnotations();
			$classAnnotationsSwitch = Arrays::get( $classAnnotations, 'no-test', FALSE );
			
			if( FALSE !== $classAnnotationsSwitch )
			{
				continue;
			}
			
			$className = $classGenerator->getName() . "PerformanceTest";
			
			if( 'interface' == $classGenerator->getType() || $classGenerator->isAbstract() )
			{
				continue;
			}
			$classParent = "\\" . $classReflection->getName() . "Base";
			$dependencies = array( 
					'BaseCase' => 'BaseCase' 
			);
			
			$classGenerator->setName( $className );
			$classGenerator->setExtends( $classParent );
			$classGenerator->setImplements( array() );
			$classGenerator->setProperties( array() );
			$classGenerator->setMethods( array() );
			$classGenerator->setConsts( array() );
			$classNameProperty = $classGenerator->addProperty( "className", $configName );
			$classNameProperty->setVisibility( 'protected' );
			// $classGenerator->addDocument("@runInSeparateProcess");
			
			$classProviderData = array();
			
			foreach( $configClass as $configClassMethod => $paramametersConfig )
			{
				
				$methodReflection = $classReflection->getMethod( $configClassMethod );
				$methodGenerator = Method::from( $methodReflection );
				$methodAnnotations = $methodReflection->getAnnotations();
				$methodAnnotationsReturn = Arrays::get( $methodAnnotations, 'return', NULL );
				$methodAnnotationsSwitch = Arrays::get( $methodAnnotations, 'no-test', FALSE );
				
				if( FALSE !== $methodAnnotationsSwitch )
				{
					continue;
				}
				
				if( $methodReflection->isAbstract() )
				{
					continue;
				}
				
				if( '__construct' == $methodReflection->getName() )
				{
					continue;
				}
				
				if( ! is_callable( array( 
						
						$classReflection->getName(),
						$methodReflection->getName() 
				) ) )
				{
					continue;
				}
				
				$providerName = $methodReflection->getName() . "Provider";
				
				$test = $classGenerator->addMethod( "test_" . $methodReflection->getName() );
				
				$parameters = array();
				$parametersReflections = $methodReflection->getParameters();
				
				if( count( $parametersReflections ) )
				{
					$test->addDocument( "@dataProvider " . $providerName );
					
					$parametersGenerators = array();
					$parametersAnnotations = Arrays::get( $methodAnnotations, 'param', array() );
					
					foreach( $parametersReflections as $parameterId => $parameterReflection )
					{
						
						$parameterGenerator = Parameter::from( $parameterReflection );
						$parameterType = $parameterGenerator->getTypeHint();
						
						if( $parameterType == '' )
						{
							$parameterAnnotation = Arrays::get( $parametersAnnotations, $parameterId, "" );
							
							$parameterAnnotations = explode( " ", $parameterAnnotation );
							$parameterType = Arrays::get( $parameterAnnotations, 0, 'mixed' );
						}
						
						if( $parameterType != '' && $parameterType != 'array' )
						{
							$parameters[] = '$' . $parameterReflection->getName();
						}
						
						$test->addDocument( "@param " . $parameterType . " " . $parameterReflection->getName() );
						
						$parametersGenerators[] = $parameterGenerator;
					}
					
					$test->setParameters( $parametersGenerators );
				}
				
				$body = '';
				$body .= "\n" . '$this->callPerformanceTest("' . $classGenerator->getName() . '","' . $methodGenerator->getName() . '",' . ($methodGenerator->isStatic() ? 'TRUE' : 'FALSE') . ', func_get_args());';
				$test->setBody( $body );
			}
			
			$classInfo = new \SplFileInfo( dirname( str_replace( $this->getRootDir(), $this->getDest(), $classReflection->getFileName() ) ) . DIRECTORY_SEPARATOR . $classGenerator->getName() . ".php" );
			
			$classDependency = "";
			
			foreach( $dependencies as $dependency => $dependencyClass )
			{
				$classDependency .= "\nuse " . $dependency;
				if( '' == $dependencyClass )
				{
					$classDependency .= " as " . $dependencyClass;
				}
				$classDependency .= ";";
			}
			
			$classCode = sprintf( "<?php\nnamespace %s;\n%s\n%s", $classReflection->getNamespaceName(), $classDependency, $classGenerator );
			
			$this->saveClass( $classCode, $classInfo );
		}
	}
	
	/**
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	public function generateClassEqualCase( InputInterface $input, OutputInterface $output )
	{
		$dest = $this->getDest();
		
		$configNeon = $this->getNeonData( $dest );
		$config = Arrays::get( $configNeon, 'tests', array() );
		$configServices = Arrays::get( $config, 'services', array() );
		$configCase = Arrays::get( $config, 'case', array() );
		$configCount = count( $configCase );
		
		$this->writeNotice( $output, "Generating Class Tests Equal Case: " . $configCount );
		
		if( $configCount == 0 )
		{
			return;
		}
		
		foreach( $configCase as $configName => $configClass )
		{
			$classService = Arrays::get( $configServices, $configName );
			$classType = Arrays::get( $classService, 'class' );
			$classReflection = ReflectionClassType::from( $classType );
			$classGenerator = PhpGeneratorClassType::from( $classType );
			$classAnnotations = $classReflection->getAnnotations();
			$classAnnotationsSwitch = Arrays::get( $classAnnotations, 'no-test', FALSE );
			
			if( FALSE !== $classAnnotationsSwitch )
			{
				continue;
			}
			$className = $classGenerator->getName() . "EqualTest";
			
			if( 'interface' == $classGenerator->getType() || $classGenerator->isAbstract() )
			{
				continue;
			}
			$classParent = "\\" . $classReflection->getName() . "Base";
			$dependencies = array();
			
			$classGenerator->setName( $className );
			$classGenerator->setExtends( $classParent );
			$classGenerator->setImplements( array() );
			$classGenerator->setProperties( array() );
			$classGenerator->setMethods( array() );
			$classGenerator->setConsts( array() );
			$classNameProperty = $classGenerator->addProperty( "className", $configName );
			$classNameProperty->setVisibility( 'protected' );
			// $classGenerator->addDocument("@runInSeparateProcess");
			
			$classProviderData = array();
			
			foreach( $configClass as $configClassMethod => $paramametersConfig )
			{
				
				$methodReflection = $classReflection->getMethod( $configClassMethod );
				$methodGenerator = Method::from( $methodReflection );
				$methodAnnotations = $methodReflection->getAnnotations();
				$methodAnnotationsReturn = Arrays::get( $methodAnnotations, 'return', NULL );
				$methodAnnotationsSwitch = Arrays::get( $methodAnnotations, 'no-test', FALSE );
				
				if( FALSE !== $methodAnnotationsSwitch )
				{
					continue;
				}
				
				if( $methodReflection->isAbstract() )
				{
					continue;
				}
				
				if( '__construct' == $methodReflection->getName() )
				{
					continue;
				}
				
				if( ! is_callable( array( 
						
						$classReflection->getName(),
						$methodReflection->getName() 
				) ) )
				{
					continue;
				}
				
				$providerName = $methodReflection->getName() . "Provider";
				
				$test = $classGenerator->addMethod( "test_" . $methodReflection->getName() );
				$parameters = array();
				$parametersReflections = $methodReflection->getParameters();
				
				if( count( $parametersReflections ) )
				{
					$test->addDocument( "@dataProvider " . $providerName );
					
					$parametersGenerators = array();
					$parametersAnnotations = Arrays::get( $methodAnnotations, 'param', array() );
					
					foreach( $parametersReflections as $parameterId => $parameterReflection )
					{
						
						$parameterGenerator = Parameter::from( $parameterReflection );
						$parameterType = $parameterGenerator->getTypeHint();
						
						if( $parameterType == '' )
						{
							$parameterAnnotation = Arrays::get( $parametersAnnotations, $parameterId, "" );
							
							$parameterAnnotations = explode( " ", $parameterAnnotation );
							$parameterType = Arrays::get( $parameterAnnotations, 0, 'mixed' );
						}
						
						if( $parameterType != '' && $parameterType != 'array' )
						{
							$parameters[] = '$' . $parameterReflection->getName();
						}
						
						$test->addDocument( "@param " . $parameterType . " " . $parameterReflection->getName() );
						
						$parametersGenerators[] = $parameterGenerator;
					}
					
					$test->setParameters( $parametersGenerators );
				}
				
				$body = '';
				$body .= "\n" . '$this->callEqualTest("' . $classGenerator->getName() . '","' . $methodGenerator->getName() . '",' . ($methodGenerator->isStatic() ? 'TRUE' : 'FALSE') . ', func_get_args());';
				$test->setBody( $body );
			}
			
			$classInfo = new \SplFileInfo( dirname( str_replace( $this->getRootDir(), $this->getDest(), $classReflection->getFileName() ) ) . DIRECTORY_SEPARATOR . $classGenerator->getName() . ".php" );
			
			$classDependency = "";
			
			foreach( $dependencies as $dependency => $dependencyClass )
			{
				$classDependency .= "\nuse " . $dependency;
				if( '' == $dependencyClass )
				{
					$classDependency .= " as " . $dependencyClass;
				}
				$classDependency .= ";";
			}
			
			$classCode = sprintf( "<?php\nnamespace %s;\n%s\n%s", $classReflection->getNamespaceName(), $classDependency, $classGenerator );
			
			$this->saveClass( $classCode, $classInfo );
		}
	}
	
	/**
	 * Generates SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Class Base Case
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	public function generateClassBaseCase( InputInterface $input, OutputInterface $output )
	{
		$cases = $this->getTestConfig()->getTestsCase();
		$this->writeNotice( "Generating Class Tests Base Case: " . count( $cases ) );
		foreach( $cases as $configName => $configClass )
		{
			print $configName . "\n";
		}
		
		return;
		
		foreach( $configCase as $configName => $configClass )
		{
			
			$classService = Arrays::get( $configServices, $configName );
			$classType = Arrays::get( $classService, 'class' );
			$classReflection = ReflectionClassType::from( $classType );
			$classGenerator = PhpGeneratorClassType::from( $classType );
			$classAnnotations = $classReflection->getAnnotations();
			$classAnnotationsSwitch = Arrays::get( $classAnnotations, 'no-test', FALSE );
			
			if( FALSE !== $classAnnotationsSwitch )
			{
				continue;
			}
			
			$className = $classGenerator->getName() . "Base";
			
			if( 'interface' == $classGenerator->getType() || $classGenerator->isAbstract() )
			{
				continue;
			}
			$classParent = "BaseCase";
			$dependencies = array( 
					
					'\ITC\Tests\BaseCase' => 'BaseCase' 
			);
			
			$classGenerator->setName( $className );
			$classGenerator->setExtends( $classParent );
			$classGenerator->setImplements( array() );
			$classGenerator->setProperties( array() );
			$classGenerator->setMethods( array() );
			$classGenerator->setConsts( array() );
			$classNameProperty = $classGenerator->addProperty( "className", $configName );
			$classNameProperty->setVisibility( 'protected' );
			// $classGenerator->addDocument("@runInSeparateProcess");
			
			$classProviderData = array();
			
			foreach( $configClass as $configClassMethod => $paramametersConfig )
			{
				
				$methodReflection = $classReflection->getMethod( $configClassMethod );
				$methodGenerator = Method::from( $methodReflection );
				$methodAnnotations = $methodReflection->getAnnotations();
				$methodAnnotationsReturn = Arrays::get( $methodAnnotations, 'return', NULL );
				$methodAnnotationsSwitch = Arrays::get( $methodAnnotations, 'no-test', FALSE );
				
				if( FALSE !== $methodAnnotationsSwitch )
				{
					continue;
				}
				
				if( $methodReflection->isAbstract() )
				{
					continue;
				}
				
				if( '__construct' == $methodReflection->getName() )
				{
					continue;
				}
				
				if( ! is_callable( array( 
						
						$classReflection->getName(),
						$methodReflection->getName() 
				) ) )
				{
					continue;
				}
				
				$providerName = $methodReflection->getName() . "Provider";
				$provider = $classGenerator->addMethod( $providerName );
				
				$permutationOffset = array();
				$parametersPermutations = new Permutation( $paramametersConfig );
				
				foreach( $parametersPermutations as $permutation )
				{
					$permutationOffset[] = $permutation;
				}
				
				$classProviderData[ $methodReflection->getName() ] = $permutationOffset;
				
				$provider->setBody( sprintf( 'return $this->getProviderData("%s");', $methodReflection->getName() ) );
			}
			
			$providerData = $classGenerator->addProperty( "providerData", $classProviderData );
			$providerData->setVisibility( 'protected' );
			
			$classInfo = new \SplFileInfo( dirname( str_replace( $this->getRootDir(), $this->getDest(), $classReflection->getFileName() ) ) . DIRECTORY_SEPARATOR . $classGenerator->getName() . ".php" );
			
			$classDependency = "";
			
			foreach( $dependencies as $dependency => $dependencyClass )
			{
				$classDependency .= "\nuse " . $dependency;
				if( '' == $dependencyClass )
				{
					$classDependency .= " as " . $dependencyClass;
				}
				$classDependency .= ";";
			}
			
			$classCode = sprintf( "<?php\nnamespace %s;\n%s\n%s", $classReflection->getNamespaceName(), $classDependency, $classGenerator );
			
			$this->saveClass( $classCode, $classInfo );
		}
	}
	
	/**
	 *
	 * @param string $code        	
	 * @param \SplFileInfo $filename        	
	 */
	protected function saveClass( $code, \SplFileInfo $filename )
	{
		@mkdir( $filename->getPath(), 0777, TRUE );
		return file_put_contents( $filename->__toString(), $code );
	}
	
	/**
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	public function generateConfigServices( InputInterface $input, OutputInterface $output )
	{
		$classReflections = $this->getClassReflections();
		$classReflectionsCount = count( $classReflections );
		
		$this->writeNotice( sprintf( "Generating Config Services: %d", $classReflectionsCount ) );
		
		$progressBar = new ProgressBar( $output, $classReflectionsCount );
		$progressBar->setFormat( 'verbose' );
		
		$testConfig = $this->getTestConfig();
		
		/* @var $class ClassReflection */
		foreach( $classReflections as $class )
		{
			
			if( $class->isAbstract() || $class->isInterface() )
			{
				continue;
			}
			
			$testConfig->generateService( $class );
			$progressBar->advance();
		}
		
		$progressBar->finish();
		$testConfig->save();
	}
	
	/**
	 * SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generates Config Case
	 *
	 * @param InputInterface $input        	
	 * @param OutputInterface $output        	
	 */
	public function generateConfigCase( InputInterface $input, OutputInterface $output )
	{
		$classReflections = $this->getClassReflections();
		$classReflectionsCount = count( $classReflections );
		
		$this->writeNotice( sprintf( "Generating Config Cases for %d classes.", $classReflectionsCount ) );
		
		$progressBar = new ProgressBar( $output, $classReflectionsCount );
		$progressBar->setFormat( 'verbose' );
		
		$testConfig = $this->getTestConfig();
		
		/* @var $class ClassReflection */
		foreach( $classReflections as $class )
		{
			
			/*
			 * Skipping tests
			 * $docBlock = $classReflection->getDocBlock();
			 * if(FALSE !== $docBlock) {
			 * $testSwitch =
			 * $this->getClassDocBlockTagValue($docBlock->getTags(),
			 * '@no-test');
			 * if(count($testSwitch) > 0) {
			 * continue;
			 * }
			 * }
			 */
			
			if( $class->isAbstract() || $class->isInterface() )
			{
				continue;
			}
			
			/*
			 * Walks thrue methods
			 */
			foreach( $class->getMethods() as $method )
			{
				
				$parameters = $method->getParameters();
				
				foreach( $parameters as $parameter )
				{
					
					$testConfig->setTestsCaseMethodParameter( 

					Config::generatePermutations( $parameter, 

					$testConfig->getTestsCaseMethodParameter( $class->getName(), $method->getName(), $parameter->getName() ), $this->getDataCount(), $input->getOption( "override" ) ), $class->getName(), $method->getName(), $parameter->getName() );
				}
			}
			
			$progressBar->advance();
		}
		
		$progressBar->finish();
		$testConfig->save();
	}
	
	/**
	 *
	 * @return string
	 */
	public function getPhpunit()
	{
		if( NULL === $this->phpunit )
		{
			$this->phpunit = $this->getRootDir() . "/phpunit.xml";
		}
		return $this->phpunit;
	}
	
	/**
	 *
	 * @param string $phpunit        	
	 */
	public function setPhpunit( $phpunit )
	{
		$this->phpunit = $phpunit;
		return $this;
	}
	
	/**
	 * Sets Gets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Config Array Hash
	 *
	 * @param ArrayHash $config        	
	 */
	public function setConfig( ArrayHash $config )
	{
		$this->config = $config;
		return $this;
	}
	
	/**
	 *
	 * @return array
	 */
	public function getTestClasses()
	{
		return $this->testClasses;
	}
	
	/**
	 *
	 * @param array $testClasses        	
	 */
	public function setTestClasses( array $testClasses )
	{
		$this->testClasses = $testClasses;
		return $this;
	}
	
	/**
	 *
	 * @return int
	 */
	public function getDataCount()
	{
		return $this->dataCount;
	}
	
	/**
	 *
	 * @param int $dataCount        	
	 * @return \SK\ITCBundle\Command\Tests\AbstractGenerator
	 */
	public function setDataCount( $dataCount )
	{
		$this->dataCount = $dataCount;
		return $this;
	}
	
	/**
	 * Gets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Class Doc Block Values By Name
	 *
	 * @param array $tags        	
	 * @param string $name        	
	 * @return array
	 */
	public function getClassDocBlockTagValue( array $tags, $name )
	{
		$v = array_filter( $tags, function ( $value ) use($name )
		{
			return (Arrays::get( $value, 'name', NULL ) == $name) ? $value : FALSE;
		} );
		$values = array();
		foreach( $v as $value )
		{
			$values[] = Arrays::get( $value, 'value', NULL );
		}
		return $values;
	}
	
	/**
	 * Gets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Test Config
	 *
	 * @return Config
	 */
	public function getTestConfig()
	{
		if( NULL === $this->testConfig )
		{
			$testConfig = Config::fromFile( $this->getTestConfigFilename() );
			$this->setTestConfig( $testConfig );
		}
		return $this->testConfig;
	}
	
	/**
	 * Gets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Generator Test Config
	 *
	 * @param Config $testConfig        	
	 * @return \SK\ITCBundle\Command\Tests\AbstractGenerator
	 */
	public function setTestConfig( Config $testConfig )
	{
		$this->testConfig = $testConfig;
		return $this;
	}
	
	/**
	 * Gets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Config File Name
	 *
	 * @return string
	 */
	public function getTestConfigFilename()
	{
		return sprintf( "%s/resource/config/%s", rtrim( $this->getDest() ), $this->testConfigFilename );
	}
	
	/**
	 * Sets SK ITCBundle Command Code Generator PHPUnit Abstract Generator Config File Name
	 *
	 * @param unknown $testConfigFilename        	
	 * @return \SK\ITCBundle\Command\Tests\AbstractGenerator
	 */
	public function setTestConfigFilename( $testConfigFilename )
	{
		$this->testConfigFilename = $testConfigFilename;
		return $this;
	}
}