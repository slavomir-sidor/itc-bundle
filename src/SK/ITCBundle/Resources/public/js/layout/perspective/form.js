$.widget("ui.perspective_form", {

	options : {

	},

	folders : null,

	/**
	 * 
	 */
	fieldsets : null,

	_create : function()
	{
		var self = this;
		this.toolbar = this.element.find('.toolbar');
		this.toolbarButtons = this.toolbar.find('.ui-button');
		this.fieldsets = this.element.find('fieldset').perspective_form_fieldset();

		this.toolbarButtons.bind('click', function(event)
		{
			self.onButtonSetClick(event);
		});
	},

	onButtonSetClick : function(event)
	{
		event.stopPropagation();
		event.preventDefault();

		var anchor = $(event.target).parent();
		var action = anchor.attr('href');

		console.log('ui.perspective_form.onButtonSetClick::' + action);

		this.element.attr('action', action);
		this.element.submit();
	},

	destroy : function()
	{
		$.Widget.prototype.destroy.apply(this, arguments);
	}
});