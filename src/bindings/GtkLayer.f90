module bindings_GtkLayer
    use iso_c_binding
    implicit none

    ! GtkLayerShellEdge
    integer(c_int), parameter :: GTK_LAYER_SHELL_EDGE_LEFT   = 0
    integer(c_int), parameter :: GTK_LAYER_SHELL_EDGE_BOTTOM = 1
    integer(c_int), parameter :: GTK_LAYER_SHELL_EDGE_TOP    = 2
    integer(c_int), parameter :: GTK_LAYER_SHELL_EDGE_RIGHT  = 3

    ! GtkLayerShellLayer
    integer(c_int), parameter :: GTK_LAYER_SHELL_LAYER_BACKGROUND = 0
    integer(c_int), parameter :: GTK_LAYER_SHELL_LAYER_BOTTOM     = 1
    integer(c_int), parameter :: GTK_LAYER_SHELL_LAYER_TOP        = 2
    integer(c_int), parameter :: GTK_LAYER_SHELL_LAYER_OVERLAY    = 3

    interface
        subroutine gtk_layer_init_for_window(win) &
            bind(c, name="gtk_layer_init_for_window")
            import c_ptr
            type(c_ptr), value :: win
        end subroutine gtk_layer_init_for_window

        subroutine gtk_layer_set_namespace(win, ns) &
            bind(c, name="gtk_layer_set_namespace")
            import c_ptr, c_char
            type(c_ptr), value :: win
            character(kind=c_char), dimension(*) :: ns
        end subroutine gtk_layer_set_namespace

        subroutine gtk_layer_set_layer(win, layer) &
            bind(c, name="gtk_layer_set_layer")
            import c_ptr, c_int
            type(c_ptr), value :: win
            integer(c_int), value :: layer
        end subroutine gtk_layer_set_layer

        subroutine gtk_layer_set_anchor(win, edge, anchor_to_edge) &
            bind(c, name="gtk_layer_set_anchor")
            import c_ptr, c_int
            type(c_ptr), value :: win
            integer(c_int), value :: edge, anchor_to_edge
        end subroutine gtk_layer_set_anchor

        subroutine gtk_layer_set_margin(win, edge, margin) &
            bind(c, name="gtk_layer_set_margin")
            import c_ptr, c_int
            type(c_ptr), value :: win
            integer(c_int), value :: edge, margin
        end subroutine gtk_layer_set_margin

        subroutine gtk_layer_auto_exclusive_zone_enable(win) &
            bind(c, name="gtk_layer_auto_exclusive_zone_enable")
            import c_ptr
            type(c_ptr), value :: win
        end subroutine gtk_layer_auto_exclusive_zone_enable
    end interface
end module
