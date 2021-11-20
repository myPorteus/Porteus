import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib
import subprocess
import platform

class LevelBarWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, type = 0, title="Audio-Level", decorated = 0, skip_taskbar_hint = 1, window_position = 1, width_request = 300)
        self.set_border_width(10)

        self.add_timeout = GLib.timeout_add(4000, Gtk.main_quit, None)
        self.box = Gtk.Box(spacing=5, orientation = Gtk.Orientation.VERTICAL)
        self.add(self.box)

        self.vol_icon()
        self.box.pack_start(self.icon, True, True, 0)
        self.levelbar = Gtk.LevelBar()

        Gtk.LevelBar.set_max_value(self.levelbar, 100)
        self.level = Gtk.LevelBar.set_value(self.levelbar, int(self.get_info("r")))
        self.box.pack_start(self.levelbar, True, True, 0)

    def get_info(self, section):
        outfile = "/tmp/.pxf-volume"
        with open(outfile, "r") as fd:
            return fd.read()

    def vol_icon(self):
        icon_status = (self.get_mute("r"))
        if int(icon_status) == 1:
            self.icon = Gtk.Image.new_from_icon_name("audio-volume-muted-symbolic", 5)
        else:
            self.icon = Gtk.Image.new_from_icon_name("audio-volume-high-symbolic", 5)

    def get_mute(self, section):
        outfile = "/tmp/.pxf-status"
        with open(outfile, "r") as fd:
            return fd.read()

win = LevelBarWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()
