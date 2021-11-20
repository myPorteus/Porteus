#!/usr/bin/python
#
# Author: jssouza
#
# This is a script to create gtk dialogs from a bash script

import gi
import sys
import argparse
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib

class GtkDialog():
    def __init__(self, primary_text = "Message Header", secondary_text = "Message Text", dtype = Gtk.MessageType.INFO, timeout = 0):

        if timeout > 0 and dtype == Gtk.MessageType.INFO:
            self.timeout_id = GLib.timeout_add(timeout, self.on_timeout, None)
        self.dialog = PorteusDialog(primary_text, secondary_text, dtype, timeout)
        response = self.dialog.run()
        self.dialog.destroy()
        self.dialog = None
        if response == Gtk.ResponseType.OK or response == Gtk.ResponseType.YES:
            exit(0)
        else:
            exit(1)

    def on_timeout(self, *args, **kwargs):
        if self.dialog is not None:
            self.dialog.destroy()
            exit(0)

class PorteusDialog(Gtk.Dialog):
    def __init__(self, primary_text, secondary_text, dtype, timeout):
        Gtk.Dialog.__init__(self, "Porteus Message", None, 0)

        self.set_default_size(250, 100)

        icon_name = "dialog-information"
        if timeout == 0:
            self.add_button(Gtk.STOCK_OK, Gtk.ResponseType.OK)
            self.set_default_size(250, 120)

        if dtype == Gtk.MessageType.QUESTION:
            self.add_button(Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL)
            icon_name = "dialog-question"
        elif dtype == Gtk.MessageType.ERROR:
            icon_name = "dialog-error"
        elif dtype == Gtk.MessageType.WARNING:
            icon_name = "dialog-warning"

        self.vb = self.get_content_area()

        self.hb = Gtk.Box(spacing = 5, homogeneous = False)

        self.grid = Gtk.Grid(row_spacing = 5, column_spacing = 10)
        self.img =  Gtk.Image.new_from_icon_name(icon_name, Gtk.IconSize.DIALOG)
        self.grid.attach(self.img, 0, 0, 1, 2)
        self.l_header = Gtk.Label(xalign = 0.0)
        self.l_header.set_markup("<span size=\"medium\" weight=\"bold\">" + primary_text + "</span>")
        self.grid.attach(self.l_header, 1, 0, 1, 1)
        self.l_txt = Gtk.Label(xalign = 0.0, label = secondary_text)

        self.grid.attach(self.l_txt, 1, 1, 1, 1)
        self.hb.pack_start(self.grid, False, False, 10)

        self.vb.pack_start(self.hb, False, False, 15)

        self.show_all()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-p", "--primary_text", help = "Primary message text")
    parser.add_argument("-s", "--secondary_text", help = "Secondary message text")        
    parser.add_argument("-d", "--dialog_type", help = "Dialog type (info, err, warn, yesno)")
    parser.add_argument("-t", "--timeout", help = "Timeout")
    args = parser.parse_args()

    if args.secondary_text:
        st = args.secondary_text
    else:
        st = None

    if args.primary_text:
        pt = args.primary_text
    else:
        pt = "Usage"
        st = parser.prog + " [-h] [-p PRIMARY_TEXT] [-s SECONDARY_TEXT] [-d DIALOG_TYPE] [-t TIMEOUT]"

    if args.dialog_type == "err":
        dt = Gtk.MessageType.ERROR
    elif args.dialog_type == "warn":
        dt = Gtk.MessageType.WARNING
    elif args.dialog_type == "yesno":
        dt = Gtk.MessageType.QUESTION
    else:
        dt = Gtk.MessageType.INFO

    if args.timeout:
        t = int(args.timeout)
        # Make readable dialogs
        if t <= 1000 or dt != Gtk.MessageType.INFO:
            t = 0
    else:
        t = 0

    GtkDialog(primary_text = pt, secondary_text = st, dtype = dt, timeout = t)

'''
#!/bin/bash

echo "No Args:"
gtkdialog.py
RET=$?
echo "RET is $RET"

echo "Warn:"
gtkdialog.py -p "Warning!" -s "You have been warned" -d "warn"
RET=$?
echo "RET is $RET"

echo "Error:"
gtkdialog.py -p "Error!" -s "There is an error" -d "err"
RET=$?
echo "RET is $RET"

echo "YesNo:"
gtkdialog.py -p "Are you sure?" -s "Yes or No" -d "yesno"
RET=$?
echo "RET is $RET"

echo "Info:"
gtkdialog.py -p "Info" -s "Some information" -d "info" -t 2000
RET=$?
echo "RET is $RET"
'''


