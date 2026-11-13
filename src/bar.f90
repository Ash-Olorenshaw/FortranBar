module FortranWMBar
    use iso_c_binding
    use gtk
    use bindings_GtkLayer
    use g, only: g_timeout_add
    use modules_date, only: date_time_string
    use modules_audio_gui, only: toggle_audio_popup
    implicit none

    ! TODO - bluetooth, internet, calendar, drives, volume

    private
    public :: gtk_main_loop

    type(c_ptr) :: clock_label
contains
    function set_date_str() result(res)
        integer(c_bool) :: res
        call gtk_label_set_text(clock_label, date_time_string()//c_null_char)
        res = .true.
    end function

    subroutine gtk_main_loop(app) bind(c)
        type(c_ptr), value, intent(in) :: app
        type(c_ptr) :: window_ptr, hbox, button
        integer(c_int) :: id_clock_timer

        window_ptr = gtk_application_window_new(app)
        call gtk_window_set_title(window_ptr, "fortran-bar"//c_null_char)

        call gtk_layer_init_for_window(window_ptr)
        call gtk_layer_set_namespace(window_ptr, "fortran-bar"//c_null_char) ! the name in `hyprctl layers`
        call gtk_layer_set_layer(window_ptr, GTK_LAYER_SHELL_LAYER_TOP)
        call gtk_layer_set_anchor(window_ptr, GTK_LAYER_SHELL_EDGE_LEFT, TRUE)
        call gtk_layer_set_anchor(window_ptr, GTK_LAYER_SHELL_EDGE_RIGHT, TRUE)
        call gtk_layer_set_anchor(window_ptr, GTK_LAYER_SHELL_EDGE_BOTTOM, TRUE)
        call gtk_layer_auto_exclusive_zone_enable(window_ptr) ! disallow things overlapping
        call gtk_window_set_default_size(window_ptr, -1_c_int, 30_c_int)

        hbox = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 8_c_int)
        call gtk_window_set_child(window_ptr, hbox)

        clock_label = gtk_label_new(date_time_string()//c_null_char)
        call gtk_box_append(hbox, clock_label)
        id_clock_timer = g_timeout_add(1000_c_int, c_funloc(set_date_str), c_null_ptr)

        button = gtk_button_new_from_icon_name("audio-volume-low"//c_null_char) ! audio-volume-off, audio-volume-medium, audio-volume-high
        call g_signal_connect(button, "clicked"//c_null_char, c_funloc(toggle_audio_popup), c_null_ptr)
        call gtk_box_append(hbox, button)
        call gtk_window_present(window_ptr)

    end subroutine
end module
