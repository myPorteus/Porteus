#!/usr/bin/python
#
# Author: jssouza
#
# This is a script to create gtk download window from a bash script

import sys
import os
import argparse
import urllib.request
import threading
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib

class GtkDownload(Gtk.Window):
    def __init__(self, url = ""):
        Gtk.Window.__init__(self, title = "Download", icon_name = "gtk-go-down", border_width = 5, height_request = 50, width_request = 400)

        self.filename = os.path.basename(url)

        self.set_border_width(20)
        self.progress = 0.0

        self.vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(self.vbox)

        self.progressbar = Gtk.ProgressBar()
        self.vbox.pack_start(self.progressbar, True, True, 0)

        self.hb_bottom = Gtk.Box(spacing = 5)
        self.hb_bottom.set_homogeneous(False)
        self.ok_button = Gtk.Button.new_with_label("Cancel")
        self.ok_button.connect("clicked", self.on_cancel_button_clicked)
        self.hb_bottom.pack_end(self.ok_button, False, False, 6)

        self.l_error = Gtk.Label(label = "")
        self.hb_bottom.pack_start(self.l_error, False, False, 6)

        self.vbox.pack_start(self.hb_bottom, False, False, 6)

        self.progressbar.set_text("Downloading " + self.filename)
        self.progressbar.set_show_text("show_text")
        self.progressbar.set_fraction(0.0)

        self.timeout_id = GLib.timeout_add(50, self.on_timeout, None)

        self.thread = threading.Thread(target = self.start_download, args = (url, self.filename))
        self.thread.daemon = True
        self.thread.start()

    def on_cancel_button_clicked(self, button):
        Gtk.main_quit()
        exit(1)

    def start_download(self, *args):
        try: 
            urllib.request.urlretrieve(args[0], args[1], self.reporthook)
          
        except Exception as e: 
            self.l_error.set_text(str(e))                     


    def reporthook(self, count, block_size, total_size):
        downloaded = count * block_size
        if downloaded < total_size:
            self.progress = downloaded/total_size
        else:
            # print("Done")
            self.progress = 1.0
        # print(downloaded)


    def on_timeout(self, user_data):
        if self.progress == 2.0:
            Gtk.main_quit() 
        self.progressbar.set_fraction(self.progress)
        if self.progress == 1.0:
            self.progress = 2.0
        return True

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-u", "--url", help = "Download URL")
    args = parser.parse_args()
    print(args.url)
    win = GtkDownload(url = args.url)
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()


