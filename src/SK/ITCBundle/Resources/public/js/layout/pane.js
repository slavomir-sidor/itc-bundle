$.widget("ui.layout_pane", {

		options: {
			layout: null
		},

		tabMenu: null,

		accordion: [],

		accordionOption: {
			active: 0,
			collapsible: true,
			fillSpace: false
		},

		tabPanels: null,

		uiTabs: null,

		buttonSet: null,

		tables:null,
		
		tablesOptions:{
			pagging:false,
			searching: false
		},

		_create: function() {

			var self = this;

			$(window).bind('resize', function(event) {
					self.resize();
				});

			var accordions = this.getAccordions();
			if (accordions.length > 0) {

				$.each(accordions, function(position, accordion) {
						self.createAccordion(accordion);
					});
			}
			
			this.buttonSet = this.element.find('.ui-buttonset');
			if(this.element.hasClass('ui-tabs')){
				this.element.tabs({});
			}
			this.tables=this.element.find('table');
			this.tables.DataTable(this.tablesOptions);
		},

		createTabMenu: function(element) {
			var tabMenu = this.getTabMenu();
			var self = this;
			var tabs = tabMenu.find('li');
		},

		getAccordions: function() {
			return this.element.find('.accordion');
		},

		createAccordion: function(element) {
			var accordion = $(element);
			var self = this;

			accordion.bind('click', function(event) {
					event.preventDefault();
					event.stopPropagation();
				});

			accordion.accordion(this.accordionOption);
			accordion.find('ul a').bind('mouseover', function(event) {
					$(event.target).addClass('ui-state-hover');
				});

			accordion.find('ul a').bind('mouseout', function(event) {
					$(event.target).removeClass('ui-state-hover');
				});

			accordion.find('ul a').bind('click', function(event) {
					self.onAccordionMenuItemClick(event);
				});

			accordion.find('ul a').bind('blur', function(event) {
					self.onAccordionMenuItemClick(event);
				});
			return accordion;
		},

		onAccordionMenuItemClick: function(event) {
			event.preventDefault();
			event.stopPropagation();

			var item = $(event.target);
			var name = item.text();
			var url = item.attr('href');

			if (url.length == 0) {
				return;
			}

			if (item.hasClass('newWindow')) {
				window.open(pageUrl);
			} else {
				var center = this.element.parent().find('.ui-layout-center');
				var tab = center.layout_pane("getTab", name, url);
			}
		},

		resize: function() {
			if (this.getTabMenu()) {

				var height = Math.round(this.element.outerHeight());

				var menuHeight = Math.round(this.getTabMenu().outerHeight());
				var paneHeight = Math.floor(height - menuHeight) - 5;
				var tabPanel = this.element.find('iframe');

				tabPanel.height(paneHeight);
			}
		},

		createTab: function(tab) {
			console.log(tab);
		},

		addTab: function(name, url) {

			var self = this;

			var tab = $('<li class="ui-state-default ui-corner-top"></li>');
			var tabLink = $('<a href="#' + url + '" title="' + url + '" class="ui-tabs-anchor">' + name + '</a>');
			var iconDocument = $('<span class="ui-icon ui-icon-loading">Document</span>');
			var iconClose = $('<span class="ui-icon ui-icon-close">Close</span>');

			var tabPanel = $('<iframe scrolling="no" />');

			tabPanel.attr('name', name);
			tabPanel.attr('src', url);

			tabPanel.ready(function(event) {
				tabPanel.addClass('ui-tabs-panel ui-widget-content loading');
			});

			tabPanel.bind('load', function(event) {
					iconDocument.removeClass('ui-icon-loading');
					iconDocument.addClass('ui-icon-document');

					tabPanel.removeClass('loading');

				});

			tabPanel.error(function(event) {
				alert('error');
			});

			tab.bind('mouseover', function(event) {
					tab.addClass('ui-state-hover');
				});

			tab.bind('mouseout', function(event) {
					tab.removeClass('ui-state-hover');
				});

			tab.bind('click', function(event) {
					self.showTabPanel(tabPanel);

					if (tab.hasClass('ui-tabs-selected ui-state-active')) {
						iconDocument.addClass('ui-icon-loading');
						tabPanel.attr('src', tabPanel.attr('src'));
					}
					self.element.find('.ui-tabs-selected.ui-state-active').removeClass('ui-tabs-selected ui-state-active');
					tab.addClass('ui-tabs-selected ui-state-active');
				});

			tabPanel.bind('error', function(event) {
					iconDocument.removeClass('ui-icon-loading');
					iconDocument.addClass('ui-icon-document');
					tab.addClass('ui-state-error');
					tabPanel.removeClass('loading');
				});

			tabPanel.bind('onabort', function(event) {
					iconDocument.removeClass('ui-icon-loading');
					iconDocument.addClass('ui-icon-document');
					tabPanel.removeClass('loading');
				});

			iconDocument.bind('click', function(event) { });
			iconDocument.bind('mouseover', function(event) {
					iconDocument.addClass('ui-state-hover');
				});

			iconDocument.bind('mouseover', function(event) {
					iconDocument.removeClass('ui-state-hover');
				});

			iconClose.bind('click', function(event) {

					$(tabPanel).remove();
					$(tab).remove();

					self.getTabMenu().find('li:last').trigger('click');

				});

			tab.append(iconDocument);
			tab.append(tabLink);
			tab.append(iconClose);

			this.getTabMenu(true).append(tab);
			this.element.append(tabPanel);
			tab.trigger('click');
			this.resize();
			return tab;

		},

		showTab: function(name, url) {
			var tab = this.getTab(name, url);
			tab.trigger('click');
		},

		getTab: function(name, url) {
			var tab = this.element.find('a[href="#' + url + '"]').parent('li');
			if (tab.length == 0) {
				tab = this.addTab(name, url);
			}
			return tab;
		},

		showTabPanel: function(panel) {
			this.element.find('iframe').hide();
			panel.show();
		},

		getTabs: function() {
			return this.element.find('ul');
		},

		getTabMenu: function(create) {
			if (null === this.tabMenu && true === create) {

				this.tabMenu = this.element.find('>ul');

				if (this.tabMenu.length == 0) {
					this.tabMenu = $('<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all"></ul>');
					this.element.append(this.tabMenu);
				}
				this.element.addClass('ui-tabs ui-widget ui-widget-content ui-corner-all');

				this.tabMenu.sortable({
					containment: 'parent',
					scroll: false
				});
			}

			return this.tabMenu;
		},

		getTabPanel: function(tab, name, url) {

			var panel = this.element.find('iframe[src="#' + url + '"]');

			if (panel.length == 0) {

				panel = this.addTabPanel(tab, name, url);
			}

			return panel;
		},

		destroy: function() {

			$.Widget.prototype.destroy.apply(this, arguments);

		}
	});
