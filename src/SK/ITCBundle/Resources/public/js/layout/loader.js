/**
 * 
 */
$.widget("ui.ui_widget_loader", {

	options : {
		layout : null,
		message : "Loading ..."
	},

	loader : null,

	_create : function()
	{
		var self = this;

	},

	getElement : function()
	{
		if (this.loader) {

		}
		return this.loader;
	},

	createElement : function()
	{
		var element = $('<div class=""></div>')
	},

	start : function()
	{

	},

	stop : function()
	{

	},

	destroy : function()
	{
		$.Widget.prototype.destroy.apply(this, arguments);
	}
});