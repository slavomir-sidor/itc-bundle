/**
 *  ITC User Interface
 * 
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
$.widget("itc.ui", {

	options : {
		environment : 'dev'
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
		this.log('Iframe Loading Error');
		this.element.addClass('.ui-state-error');
	},

	onLoadingSuccess : function()
	{
		this.log('Iframe Loading Error');
		this.element.addClass('.ui-state-default');
		this.element.removeClass('.ui-state-loading');
	},

	onLoading : function()
	{
		this.log('Iframe Loading...');
		this.element.addClass('.ui-state-loading');
	},

	log : function(message)
	{
		if ('dev' == this.options.environment) {
			console.log(message);
		}
	}
});