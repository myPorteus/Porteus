#!/usr/bin/python

import gi
import argparse
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib

class ProgressDialog(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, type = 0, decorated = 1, skip_taskbar_hint = 1, window_position = 1, border_width = 20, default_width = 250, title = w)

        self.set_border_width(20)
        self.progress = 0.0

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        self.header = Gtk.Label()
        self.header.set_markup("<span size=\"medium\" weight=\"bold\">" + m + "</span>")
        vbox.pack_start(self.header, True, True, 0) 

        timeout_id = GLib.timeout_add(50, self.on_timeout, None)
        self.progressbar = Gtk.ProgressBar()
        self.progressbar.set_text(t)
        self.progressbar.set_show_text("show_text")
        vbox.pack_start(self.progressbar, True, True, 0)

    def on_timeout(self, user_data):
        self.progressbar.pulse()
        return True

    # ~ def on_timeout(self, user_data):
        # ~ if self.progress == 2.0:
            # ~ Gtk.main_quit()
        # ~ self.progressbar.set_fraction(self.progress)
        # ~ if self.progress == 1.0:
            # ~ self.progress = 2.0
        # ~ return True

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-w", "--window_title", help = "Window Title")
    parser.add_argument("-m", "--header_text", help = "Primary text")
    parser.add_argument("-t", "--text", help = "Progess text")
    args = parser.parse_args()

    if args.window_title:
        w = args.window_title
    else:
        w = "Porteus Message"

    if args.text:
        t = args.text
    else:
        t = None
        
    if args.header_text:
        m = args.header_text
    else:
        m = None
        
    win = ProgressDialog()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
