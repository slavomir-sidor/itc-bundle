/**
 * SK ITCBundle Layout Perspective
 * 
 * @licence GNU GPL
 * @author Slavomir Kuzma <slavomir.kuzma@gmail.com>
 */
$.widget("ui.perspectives", $.ui.layout_template, {

	toolbar : null,

	toolbarButtonSet : null,

	toolbarButtons : null,

	activeButton : null,

	workbench : null,

	workbenchTabs : null,

	path : null,

	_create : function() {

		var self = this;

		this.toolbar = this.element.find('.toolbar');
		this.toolbarButtonSet = this.toolbar.find('.buttonset');
		this.toolbarButtons = this.toolbarButtonSet.find('a');

		this.workbench = this.element.find('.workbench');
		this.workbenchTabs = this.workbench.find('.ui-tabs');

		this.workbench.bind('load', function(event) {
			self.onWorkbenchLoad(event);
		});
		this.toolbarButtons.bind('click', function(event) {
			self.onButtonSetClick(event);
		});

		if (null !== this.options.activeButton) {
			var buttonSetActiveButton = this.toolbarButtons[this.options.activeButton];
			if (buttonSetActiveButton)
				buttonSetActiveButton.trigger('click');
		}
		this._super();
		this.log('perspective');
	},

	onWorkbenchLoad : function(event) {
		if (this.workbench) {
			this.workbench.removeClass('ui-state-loading');
		}
		this.element.removeClass('ui-state-loading');
	},

	onWorkbenchReady : function(event) {
		this.element.removeClass('ui-state-working');
	},

	onButtonSetClick : function(event) {

		event.preventDefault();

		var workbench = this.getWorkbench(event.currentTarget.target);
		workbench.addClass('ui-state-loading');
		workbench.attr('src', event.currentTarget.href);

		var activeButton = this.getActiveButton();

		if (null !== activeButton) {
			activeButton.removeClass('active');
		}

		activeButton = $(event.target);
		activeButton.addClass('active');

		this.activeButton = activeButton;
	},

	/**
	 * 
	 */
	getWorkbench : function(name) {
		return this.workbench;
		var self = this;
		var workbench = this.element.find("[name='" + name + "']");

		if (workbench.length == 0) {

			var workbench = $('<iframe class="ui-layout-center workbench" />');
			workbench.attr('name', name);

			workbench.bind('load', function(event) {
				self.onWorkbenchLoad(event);
			});

			workbench.bind('ready', function(event) {
				self.onWorkbenchReady(event);
			});

			if (this.workbench.length > 0) {
				this.workbench.hide();
				this.workbench.replaceWith(workbench);
			} else {
				this.element.append(workbench);
			}
			this.element.layout_template();
		}
		this.workbench = workbench;
		return this.workbench;
	},

	getActiveButton : function() {
		if (null === this.activeButton) {
			this.activeButton = this.toolbarButtons.find('.active');
		}
		return this.activeButton;
	},

	destroy : function() {
		$.Widget.prototype.destroy.apply(this, arguments);
	}
});