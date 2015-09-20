$.widget("ui.perspective_form_fieldset", {

	options : {

	},

	/**
	 * 
	 */
	legend : null,

	_create : function()
	{
		var self = this;
		this.legend = this.element.find('legend');
		this.legendIcon=$('<span class="ui-icon ui-icon-triangle-1-s"></span>');
		this.legend.prepend(this.legendIcon);
		this.legend.bind('click', function(event)
		{
			self.onLegendClick(event);
		});
	},

	onLegendClick : function(event)
	{
		event.stopPropagation();
		event.preventDefault();

		this.element.toggleClass('ui-state-collapsed');

		this.legendIcon.toggleClass('ui-icon-triangle-1-e');
		this.legendIcon.toggleClass('ui-icon-triangle-1-s');
	},

	destroy : function()
	{
		$.Widget.prototype.destroy.apply(this, arguments);
	}
});