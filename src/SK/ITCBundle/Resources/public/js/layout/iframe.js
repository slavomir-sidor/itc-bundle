$.widget("ui.iframe", {

	options : {
		selector : 'iframe'
	},

	_create : function()
	{
		var self = this;
	},

	destroy : function()
	{
		$.Widget.prototype.destroy.apply(this, arguments);
	},

	onLoadingError : function()
	{
		console.log('Iframe Loading Error');
		this.element.addClass('.ui-state-error');
	},

	onLoadingSuccess : function()
	{
		console.log('Iframe Loading Error');
		this.element.addClass('.ui-state-default');
		this.element.removeClass('.ui-state-loading');
	},

	onLoading : function()
	{
		console.log('Iframe Loading...');
		this.element.addClass('.ui-state-loading');
	}
});