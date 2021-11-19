/* xapp.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "XApp", gir_namespace = "XApp", gir_version = "1.0", lower_case_cprefix = "xapp__")]
namespace XApp {
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", type_id = "xapp_gtk_window_get_type ()")]
	public class GtkWindow : Gtk.Window, Atk.Implementor, Gtk.Buildable {
		[CCode (cname = "xapp_gtk_window_new", has_construct_function = false, type = "GtkWidget*")]
		public GtkWindow (Gtk.WindowType type);
		[CCode (cname = "xapp_gtk_window_set_icon_from_file")]
		public void set_icon_from_file (string? file_name) throws GLib.Error;
		[CCode (cname = "xapp_gtk_window_set_icon_name")]
		public void set_icon_name (string? icon_name);
		[CCode (cname = "xapp_gtk_window_set_progress")]
		public void set_progress (int progress);
		[CCode (cname = "xapp_gtk_window_set_progress_pulse")]
		public void set_progress_pulse (bool pulse);
	}
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", type_id = "xapp_icon_chooser_button_get_type ()")]
	public class IconChooserButton : Gtk.Button, Atk.Implementor, Gtk.Actionable, Gtk.Activatable, Gtk.Buildable {
		[CCode (cname = "xapp_icon_chooser_button_new", has_construct_function = false)]
		public IconChooserButton ();
		[CCode (cname = "xapp_icon_chooser_button_get_dialog")]
		public unowned XApp.IconChooserDialog get_dialog ();
		[CCode (cname = "xapp_icon_chooser_button_get_icon")]
		public unowned string get_icon ();
		[CCode (cname = "xapp_icon_chooser_button_set_icon")]
		public void set_icon (string? icon);
		[CCode (cname = "xapp_icon_chooser_button_set_icon_size")]
		public void set_icon_size (Gtk.IconSize icon_size);
		[CCode (cname = "xapp_icon_chooser_button_new_with_size", has_construct_function = false)]
		public IconChooserButton.with_size (Gtk.IconSize icon_size);
		[NoAccessorMethod]
		public string icon { owned get; set; }
		[NoAccessorMethod]
		public Gtk.IconSize icon_size { get; set; }
	}
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", type_id = "xapp_icon_chooser_dialog_get_type ()")]
	public class IconChooserDialog : XApp.GtkWindow, Atk.Implementor, Gtk.Buildable {
		[CCode (cname = "xapp_icon_chooser_dialog_new", has_construct_function = false)]
		public IconChooserDialog ();
		[CCode (cname = "xapp_icon_chooser_dialog_add_button")]
		public void add_button (Gtk.Widget button, Gtk.PackType packing, Gtk.ResponseType response_id);
		[CCode (cname = "xapp_icon_chooser_dialog_get_icon_string")]
		public string get_icon_string ();
		[CCode (cname = "xapp_icon_chooser_dialog_run")]
		public int run ();
		[CCode (cname = "xapp_icon_chooser_dialog_run_with_category")]
		public int run_with_category (string category);
		[CCode (cname = "xapp_icon_chooser_dialog_run_with_icon")]
		public int run_with_icon (string icon);
		[NoAccessorMethod]
		public bool allow_paths { get; set; }
		public signal void close ();
		public signal void select ();
	}
	[CCode (cheader_filename = "libxapp/xapp-kbd-layout-controller.h", type_id = "xapp_kbd_layout_controller_get_type ()")]
	public class KbdLayoutController : GLib.Object {
		[CCode (cname = "xapp_kbd_layout_controller_new", has_construct_function = false)]
		public KbdLayoutController ();
		[CCode (array_length = false, array_null_terminated = true, cname = "xapp_kbd_layout_controller_get_all_names")]
		public unowned string[] get_all_names ();
		[CCode (cname = "xapp_kbd_layout_controller_get_current_flag_id")]
		public int get_current_flag_id ();
		[CCode (cname = "xapp_kbd_layout_controller_get_current_group")]
		public uint get_current_group ();
		[CCode (cname = "xapp_kbd_layout_controller_get_current_icon_name")]
		public string get_current_icon_name ();
		[CCode (cname = "xapp_kbd_layout_controller_get_current_name")]
		public string get_current_name ();
		[CCode (cname = "xapp_kbd_layout_controller_get_current_short_group_label")]
		public string get_current_short_group_label ();
		[CCode (cname = "xapp_kbd_layout_controller_get_current_variant_label")]
		public string get_current_variant_label ();
		[CCode (cname = "xapp_kbd_layout_controller_get_enabled")]
		public bool get_enabled ();
		[CCode (cname = "xapp_kbd_layout_controller_get_flag_id_for_group")]
		public int get_flag_id_for_group (uint group);
		[CCode (cname = "xapp_kbd_layout_controller_get_icon_name_for_group")]
		public string get_icon_name_for_group (uint group);
		[CCode (cname = "xapp_kbd_layout_controller_get_short_group_label_for_group")]
		public string get_short_group_label_for_group (uint group);
		[CCode (cname = "xapp_kbd_layout_controller_get_variant_label_for_group")]
		public string get_variant_label_for_group (uint group);
		[CCode (cname = "xapp_kbd_layout_controller_next_group")]
		public void next_group ();
		[CCode (cname = "xapp_kbd_layout_controller_previous_group")]
		public void previous_group ();
		[CCode (cname = "xapp_kbd_layout_controller_render_cairo_subscript")]
		public static void render_cairo_subscript (Cairo.Context cr, double x, double y, double width, double height, int subscript);
		[CCode (cname = "xapp_kbd_layout_controller_set_current_group")]
		public void set_current_group (uint group);
		[NoAccessorMethod]
		public bool enabled { get; }
		public signal void config_changed ();
		public signal void layout_changed (uint object);
	}
	[CCode (cheader_filename = "libxapp/xapp-monitor-blanker.h", type_id = "xapp_monitor_blanker_get_type ()")]
	public class MonitorBlanker : GLib.Object {
		[CCode (cname = "xapp_monitor_blanker_new", has_construct_function = false)]
		public MonitorBlanker ();
		[CCode (cname = "xapp_monitor_blanker_are_monitors_blanked")]
		public bool are_monitors_blanked ();
		[CCode (cname = "xapp_monitor_blanker_blank_other_monitors")]
		public void blank_other_monitors (Gtk.Window window);
		[CCode (cname = "xapp_monitor_blanker_unblank_monitors")]
		public void unblank_monitors ();
	}
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", type_id = "xapp_preferences_window_get_type ()")]
	public class PreferencesWindow : Gtk.Window, Atk.Implementor, Gtk.Buildable {
		[CCode (cname = "xapp_preferences_window_new", has_construct_function = false)]
		public PreferencesWindow ();
		[CCode (cname = "xapp_preferences_window_add_button")]
		public void add_button (Gtk.Widget button, Gtk.PackType pack_type);
		[CCode (cname = "xapp_preferences_window_add_page")]
		public void add_page (Gtk.Widget widget, string name, string title);
		public virtual signal void close ();
	}
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", type_id = "xapp_stack_sidebar_get_type ()")]
	public class StackSidebar : Gtk.Bin, Atk.Implementor, Gtk.Buildable {
		[CCode (cname = "xapp_stack_sidebar_new", has_construct_function = false)]
		public StackSidebar ();
		[CCode (cname = "xapp_stack_sidebar_get_stack")]
		public unowned Gtk.Stack? get_stack ();
		[CCode (cname = "xapp_stack_sidebar_set_stack")]
		public void set_stack (Gtk.Stack stack);
		[NoAccessorMethod]
		public Gtk.Stack stack { owned get; set; }
	}
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", cprefix = "XAPP_ICON_SIZE_", has_type_id = false)]
	public enum IconSize {
		@16,
		@22,
		@24,
		@32,
		@48,
		@96
	}
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", cname = "xapp_set_window_icon_from_file")]
	public static void set_window_icon_from_file (Gtk.Window window, string? file_name) throws GLib.Error;
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", cname = "xapp_set_window_icon_name")]
	public static void set_window_icon_name (Gtk.Window window, string? icon_name);
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", cname = "xapp_set_window_progress")]
	public static void set_window_progress (Gtk.Window window, int progress);
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", cname = "xapp_set_window_progress_pulse")]
	public static void set_window_progress_pulse (Gtk.Window window, bool pulse);
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", cname = "xapp_set_xid_icon_from_file")]
	public static void set_xid_icon_from_file (ulong xid, string? file_name);
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", cname = "xapp_set_xid_icon_name")]
	public static void set_xid_icon_name (ulong xid, string? icon_name);
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", cname = "xapp_set_xid_progress")]
	public static void set_xid_progress (ulong xid, int progress);
	[CCode (cheader_filename = "libxapp/xapp-gtk-window.h", cname = "xapp_set_xid_progress_pulse")]
	public static void set_xid_progress_pulse (ulong xid, bool pulse);
}
