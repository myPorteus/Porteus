/* Porteus Related Stuff - jssouza@porteus.org */
const Applet = imports.ui.applet;
const GLib = imports.gi.GLib;
const Gio = imports.gi.Gio;
const Lang = imports.lang;
const St = imports.gi.St;
const Main = imports.ui.main;
const PopupMenu = imports.ui.popupMenu;
const UUID = 'porteus@porteus.org';

function ConfirmDialog(){
  this._init();
}

function MyApplet(orientation, panelHeight, instanceId) {
  this._init(orientation, panelHeight, instanceId);
}


MyApplet.prototype = {
  __proto__: Applet.IconApplet.prototype,

  _init: function(orientation, panelHeight, instanceId) {
    Applet.IconApplet.prototype._init.call(this, orientation, panelHeight, instanceId);

    try {
      this.set_applet_icon_name("porteus-white");
      this.set_applet_tooltip("Porteus stuff");

      this.menuManager = new PopupMenu.PopupMenuManager(this);
      this.menu = new Applet.AppletPopupMenu(this, orientation);
      this.menuManager.addMenu(this.menu);

      this._contentSection = new PopupMenu.PopupMenuSection();
      this.menu.addMenuItem(this._contentSection);

      let item = new PopupMenu.PopupIconMenuItem("Porteus Directory (PORTDIR)", "emblem-favorite", St.IconType.FULLCOLOR);

      item.connect('activate', Lang.bind(this, function() {
					   Main.Util.spawnCommandLine("xdg-open-portdir");
					 }));
      this.menu.addMenuItem(item);

      item = new PopupMenu.PopupIconMenuItem("Porteus Booted Drive (BOOTDEV)", "drive-harddisk", St.IconType.FULLCOLOR);

      item.connect('activate', Lang.bind(this, function() {
					   Main.Util.spawnCommandLine('xdg-open-bootdev');
					 }));
      this.menu.addMenuItem(item);

      this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());

      item = new PopupMenu.PopupIconMenuItem("Porteus Modules", "cdr", St.IconType.FULLCOLOR);

      item.connect('activate', Lang.bind(this, function() {
					   Main.Util.spawnCommandLine("/usr/bin/pauth dbus-launch --exit-with-session /usr/local/bin/lsmodules");
					 }));
      this.menu.addMenuItem(item);

      this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());

      item = new PopupMenu.PopupIconMenuItem("Visit Porteus Forum", "porteus-white", St.IconType.FULLCOLOR);

      item.connect('activate', Lang.bind(this, function() {
					   Main.Util.spawnCommandLine("xdg-open https://forum.porteus.org");
					 }));
      this.menu.addMenuItem(item);

      this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());

      this.swItem = new PopupMenu.PopupSwitchIconMenuItem("Night Mode", false, "weather-clear-night", St.IconType.SYMBOLIC);
      this.swItem.connect('activate', Lang.bind(this, this.onNightModeChanged));
      this.menu.addMenuItem(this.swItem);

/*
      this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());

      item = new PopupMenu.PopupIconMenuItem("Update Cinnamon", "system-software-install", St.IconType.FULLCOLOR);

      item.connect('activate', Lang.bind(this, function() {
					   Main.Util.spawnCommandLine("update-de");
					 }));
      this.menu.addMenuItem(item);
*/
	  let file = Gio.File.new_for_path("/tmp/.cinnamon-" + GLib.get_user_name() + "/nightmode");
      this.swItem.setToggleState(file.query_exists(null));
    }
    catch (e) {
      global.logError(e);
    }
  },

  on_applet_clicked: function(event) {
    this.menu.toggle();
  },

  onNightModeChanged: function(actor, event) {
	  if(this.swItem.state) {
		Main.Util.spawnCommandLine("/usr/local/bin/nightmode");
	  }
	  else {
		Main.Util.spawnCommandLine("/usr/local/bin/nightmode off");
	  }
  }
};

function main(metadata, orientation, panelHeight, instanceId) {
  let myApplet = new MyApplet(orientation, panelHeight, instanceId);
  return myApplet;
}
