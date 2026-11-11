program main
    use FortranWMBar, only: gtk_main_loop
    use, intrinsic :: iso_c_binding, only: c_int, c_ptr, c_funloc, c_null_char, c_null_ptr
    use gtk, only: gtk_application_new, g_signal_connect, G_APPLICATION_FLAGS_NONE
    use g, only: g_application_run, g_object_unref

    implicit none

    integer(c_int) :: exit_status
    type(c_ptr)    :: app

    app = gtk_application_new("exmaple.asdf"//c_null_char, G_APPLICATION_FLAGS_NONE)
    call g_signal_connect(app, "activate"//c_null_char, c_funloc(gtk_main_loop), c_null_ptr)
    exit_status = g_application_run(app, 0_c_int, [c_null_ptr])
    call g_object_unref(app)
end program main
