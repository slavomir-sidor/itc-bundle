<?php
/**
 * SK ITCBundle Translation Translator
 *
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
namespace SK\ITCBundle\Command\Translation;

use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Translation\MessageCatalogue;
use Symfony\Component\Translation\Translator as SymfonyTranslator;
use SK\ITCBundle\Command\AbstractCommand;

class Translator extends AbstractCommand
{

	protected $translator;

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::configure()
	 */
	protected function configure()
	{
		$this->setDefinition(
			array(
				new InputArgument('locale', InputArgument::REQUIRED, 'The locale'),
				new InputArgument('bundle', InputArgument::OPTIONAL, 'The bundle where to load the messages, defaults to app/Resources folder', null),
				new InputOption('prefix', null, InputOption::VALUE_OPTIONAL, 'Override the default prefix', '__'),
				new InputOption('format', null, InputOption::VALUE_OPTIONAL, 'Override the default output format',  'xlf'),
				new InputOption('force', null, InputOption::VALUE_NONE, 'Should the update be done'),
				new InputOption('no-backup', null, InputOption::VALUE_NONE, 'Should backup be disabled'),
				new InputOption('clean', null, InputOption::VALUE_NONE, 'Should clean not found messages')
			));
	}

	/**
	 * (non-PHPdoc)
	 *
	 * @see \Symfony\Component\Console\Command\Command::execute()
	 */
	public function execute(InputInterface $input, OutputInterface $output)
	{
		$translator = $this->getContainer()->get('sk.itcbundle.google.translator');
		
		$locale = $input->getArgument('locale');
		$domain = $input->getOption('domain');
		$bundle = $this->getContainer()
			->get('kernel')
			->getBundle($input->getArgument('bundle'));
		$loader = $this->getContainer()->get('translation.loader');
		
		// Extract used messages
		$extractedCatalogue = new MessageCatalogue($locale);
		$this->getContainer()
			->get('translation.extractor')
			->extract($bundle->getPath() . '/Resources/views', $extractedCatalogue);
		
		// Load defined messages
		$currentCatalogue = new MessageCatalogue($locale);
		if (is_dir($bundle->getPath() . '/Resources/translations'))
		{
			$loader->loadMessages($bundle->getPath() . '/Resources/translations', $currentCatalogue);
		}
	}
}