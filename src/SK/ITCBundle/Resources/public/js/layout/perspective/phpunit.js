$.widget("ui.perspective.phpunit", {

	options : {

	},

	folders : null,
	
	

	_create : function()
	{
		var self = this;
		this.filesystem = this.element.find('.ui-widget-phpunit');
		this.filesystem.perspective_filesystem_folder();
	},

	destroy : function()
	{
		$.Widget.prototype.destroy.apply(this, arguments);
	}
});