$.widget("ui.welcome", {

	options : {
		selector : '.welcome'
	},

	_create : function()
	{
		var self = this;
	},

	destroy : function()
	{
		$.Widget.prototype.destroy.apply(this, arguments);
	}
});