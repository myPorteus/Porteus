#!/usr/bin/python

import gi
from subprocess import run
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

class LogoutDialog(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, type = 1, decorated = 0, skip_taskbar_hint = 1, window_position = 1, border_width = 20, default_height = 300, default_width = 140,)
        self.set_border_width(20)

        hbox = Gtk.Box(spacing=10, orientation = Gtk.Orientation.VERTICAL, homogeneous = False)
        self.add(hbox)

        image = Gtk.Image.new_from_icon_name("system-shutdown-symbolic", 5)
        hbox.pack_start(image, True, True, 0)

        button = Gtk.Button.new_with_label("Shutdown")
        button.connect("clicked", self.on_Shutdown_clicked)
        hbox.pack_start(button, True, True, 0)

        button = Gtk.Button.new_with_label("Reboot")
        button.connect("clicked", self.on_Reboot_clicked)
        hbox.pack_start(button, True, True, 0)

        button = Gtk.Button.new_with_label("Suspend")
        button.connect("clicked", self.on_Suspend_clicked)
        hbox.pack_start(button, True, True, 0)

        button = Gtk.Button.new_with_label("Logout")
        button.connect("clicked", self.on_Logout_clicked)
        hbox.pack_start(button, True, True, 0)

        button = Gtk.Button.new_with_label("Cancel")
        button.connect("clicked", self.on_Cancel_clicked)
        hbox.pack_start(button, True, True, 0)

    def on_Shutdown_clicked(self, button):
        run(['loginctl', 'poweroff'])

    def on_Reboot_clicked(self, button):
        run(['loginctl', 'reboot'])

    def on_Suspend_clicked(self, button):
        run(['loginctl', 'suspend'])

    def on_Logout_clicked(self, button):
        run(['openbox', '--exit'])

    def on_Cancel_clicked(self, button):
        Gtk.main_quit()

win = LogoutDialog()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()
