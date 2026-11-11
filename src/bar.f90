module FortranWMBar
    use iso_c_binding
    use gtk
    use g, only: g_timeout_add
    use bindings_GtkLayer
    use modules_date, only: date_time_string
    implicit none

    ! TODO - bluetooth, internet, calendar, drives, volume

    private
    public :: gtk_main_loop
contains
    subroutine gtk_main_loop(app) bind(c)
        type(c_ptr), value, intent(in) :: app
        type(c_ptr) :: window_ptr, clock_label, hbox, button

        window_ptr = gtk_application_window_new(app)
        call gtk_window_set_title(window_ptr, "fortran-bar"//c_null_char)

        call gtk_layer_init_for_window(window_ptr)
        call gtk_layer_set_namespace(window_ptr, "fortran-bar"//c_null_char) ! the name in `hyprctl layers`
        call gtk_layer_set_layer(window_ptr, GTK_LAYER_SHELL_LAYER_TOP)
        call gtk_layer_set_anchor(window_ptr, GTK_LAYER_SHELL_EDGE_LEFT, TRUE)
        call gtk_layer_set_anchor(window_ptr, GTK_LAYER_SHELL_EDGE_RIGHT, TRUE)
        call gtk_layer_set_anchor(window_ptr, GTK_LAYER_SHELL_EDGE_BOTTOM, TRUE)
        call gtk_layer_auto_exclusive_zone_enable(window_ptr) ! reserve space
        call gtk_window_set_default_size(window_ptr, -1_c_int, 30_c_int)

        hbox = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 8_c_int)
        call gtk_window_set_child(window_ptr, hbox)

        clock_label = gtk_label_new(date_time_string()//c_null_char)
        call gtk_box_append(hbox, clock_label)

        button = gtk_button_new_with_label("Quit"//c_null_char)
        call gtk_box_append(hbox, button)
        call gtk_window_present(window_ptr)

    end subroutine
end module
