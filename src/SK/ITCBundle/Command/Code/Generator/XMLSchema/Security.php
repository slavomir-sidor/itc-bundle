<?php
/**
 * SK ITCBundle Generator XML Schema Security
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Code\Generator\XMLSchema;

use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Helper\ProgressBar;
use Symfony\Component\Console\Helper\ProgressHelper;
use Zend\Code\Generator\ClassGenerator;

class Security extends AbstractGenerator
{

	/**
	 * (non-PHPdoc)
	 *
	 * @see \SK\ITCBundle\Code\Generator\XMLSchema\AbstractGenerator::configure()
	 */
	protected function configure()
	{
		parent::configure();
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute(InputInterface $input, OutputInterface $output)
	{
		$xsd = $this->getDocument($input->getArgument('xsd'));
		$xsdSchema = $xsd->getSchema();
	}
}