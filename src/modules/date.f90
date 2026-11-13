module modules_date
    public :: date_time_string
contains
    function date_time_string() result(res)
        character(len=8) :: date
        character(len=10) :: time
        character(len=5) :: zone
        character(len=19) :: res
        integer, dimension(8) :: values

        call date_and_time(date, time, zone, values)
        write(res,'(i2.2,a,i2.2,a,i2.2,a,i2.2,a,i2.2,a,i4.4)') &
            & values(5),':', &
            & values(6),':', &
            & values(7),' ', &
            & values(3),'/', &
            & values(2),'/', &
            & values(1)
    end function
end module
