$.widget("ui.perspective_filesystem_folder", {

	options : {

	},

	header : null,

	content : null,

	footer : null,

	_create : function()
	{
		var self = this;

		this.header = this.element.find('>.ui-widget-header');
		this.content = this.element.find('>.ui-widget-content');
		this.footer = this.element.find('>.ui-widget-footer');

		$(window).bind('resize', function(event)
		{
			//self.onResize(event);
		});

		this.element.bind('mouseout', function(event)
		{
			self.onMouseOut(event);
		});

		this.element.bind('mouseover', function(event)
		{
			self.onMouseOver(event);
		});

		this.element.bind('click', function(event)
		{
			// self.onClick(event);
		});
	},

	resize : function()
	{
		var height = this.element.innerHeight();
		var headerHeight = this.header.outerHeight(true);
		var contentHeight = height - headerHeight;

		this.content.height(contentHeight);
	},

	onResize : function(event)
	{
		this.resize();
	},

	onClick : function(event)
	{
		event.stopPropagation();
		event.preventDefault();
		this.element.toggleClass('ui-state-selected');
	},

	onMouseOver : function(event)
	{
		event.stopPropagation();
		event.preventDefault();
		this.element.addClass('ui-state-active');
	},

	onMouseOut : function(event)
	{
		event.stopPropagation();
		event.preventDefault();
		this.element.removeClass('ui-state-active');
	},

	destroy : function()
	{
		$.Widget.prototype.destroy.apply(this, arguments);
	}
});