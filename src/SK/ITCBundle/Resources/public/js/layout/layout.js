$.widget("ui.layout_template", {

	options : {

		applyDefaultStyles : true,

		fxSpeed : "fast",

		initClosed : true,

		north : {
			fxName : "none",
			showOverflowOnHover : false,
			closable : false,
			resizable : false,
			slidable : false,
			initClosed : false,
			size : "auto",
			spacing_open : 6
		},

		west : {
			togglerLength_open : 50,
			togglerLength_closed : "100%",
			initClosed : false,
			size : "auto",
			spacing_open : 6,
			spacing_closed : 0
		},

		center : {
			spacing_open : 0,
			spacing_closed : 0
		},

		east : {
			initClosed : true,
			closable : true,
			size : "auto",
			spacing_open : 0,
			spacing_closed : 0
		},

		south : {
			initClosed : false,
			spacing_open : 0,
			spacing_closed : 0,
			closable : true,
			resizable : true
		},

		debug : true
	},

	panes : null,

	_create : function() {
		var self = this;
		this.log('layout construct:');
		this.log(this.options);
		this.element.layout(this.options);
		this.panes = this.element.find('.ui-layout-pane');
		this.panes.layout_pane({
			layout : self
		});

		$(window).bind('load', function(event) {
			self.onLoad(event);
		});
		$(window).bind('resize', function(event) {
			self.onResize(event);
		});
	},

	onLoad : function(event) {
		this.log('layout window load');
		this.element.removeClass('ui-state-loading');
	},

	onResize : function(event) {
		this.element.layout('resizeAll');
	},

	log : function(message) {
		if (this.options.debug) {
			console.log(message);
		}
	},

	destroy : function() {
		$.Widget.prototype.destroy.apply(this, arguments);
	}

});