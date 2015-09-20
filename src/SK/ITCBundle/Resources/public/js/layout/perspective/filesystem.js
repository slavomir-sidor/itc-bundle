$.widget("ui.perspective_filesystem", $.ui.perspectives, {

	options : {

	},

	folders : null,

	displayGridButton : null,
	displayTableButton : null,

	_create : function()
	{
		var self = this;
		this.workspace = this.element.find('.ui-layout-center');
		this.filesystem = this.element.find('.ui-widget-filesystem');
		this.filesystem.perspective_filesystem_folder();

		this.displayGridButton = this.element.find('.display.grid');
		this.displayGridButton.bind('click', function(event)
		{
			self.onDisplayGridButtonClick(event);
		});
		
		this.displayTableButton = this.element.find('.display.table');
		this.displayTableButton.bind('click', function(event)
		{
			self.onDisplayTableButtonClick(event);
		});
		//this.displayGridButton.find('span').trigger('click');
	},

	onDisplayGridButtonClick : function(event)
	{
		event.stopPropagation();
		event.preventDefault();
		this.workspace.removeClass('table', 0);
		this.filesystem.perspective_filesystem_folder('resize');
	},

	onDisplayTableButtonClick : function(event)
	{
		console.log(event);
		event.stopPropagation();
		event.preventDefault();

		this.workspace.addClass('table', 0);

		this.filesystem.perspective_filesystem_folder('resize');
	},

	destroy : function()
	{
		$.Widget.prototype.destroy.apply(this, arguments);
	}
});