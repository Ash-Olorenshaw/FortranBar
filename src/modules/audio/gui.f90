module modules_audio_gui
    use iso_c_binding
    use gtk
    use bindings_GtkLayer

    private
    public :: toggle_audio_popup

contains

    subroutine toggle_audio_popup(self, user_data)
        type(c_ptr), intent(in) :: self, user_data
        type(c_ptr) :: window_ptr = c_null_ptr

        if (.not. c_associated(window_ptr)) then
            print *, "not associated"
            window_ptr = create_audio_popup()
        end if

        print *, "Visible: ", gtk_widget_get_visible(window_ptr)
        if (gtk_widget_get_visible(window_ptr) == TRUE) then
            call gtk_widget_set_visible(window_ptr, FALSE)
        else
            call gtk_window_present(window_ptr)
        end if
    end subroutine

    function create_audio_popup() result(window_ptr)
        type(c_ptr) :: window_ptr

        window_ptr = gtk_window_new()
        call gtk_window_set_decorated(window_ptr, FALSE)
        call gtk_layer_init_for_window(window_ptr)
        ! call gtk_window_set_transient_for(window_ptr)
        call gtk_layer_set_layer(window_ptr, GTK_LAYER_SHELL_LAYER_OVERLAY)
        call gtk_layer_set_anchor(window_ptr, GTK_LAYER_SHELL_EDGE_RIGHT, TRUE)
        call gtk_layer_set_anchor(window_ptr, GTK_LAYER_SHELL_EDGE_BOTTOM, TRUE)
        call gtk_layer_set_margin(window_ptr, GTK_LAYER_SHELL_EDGE_BOTTOM, 30_c_int)
        call gtk_window_set_default_size(window_ptr, 300_c_int, 300_c_int)
        ! call gtk_layer_auto_exclusive_zone_enable(window_ptr)
        call gtk_window_set_resizable(window_ptr, FALSE)
    end function
end module
