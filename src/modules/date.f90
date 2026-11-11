module modules_date
    public :: date_time_string
contains
    function date_time_string() result(res)
        character(len=8) :: date
        character(len=10) :: time
        character(len=5) :: zone
        character(len=28) :: res
        integer, dimension(8) :: values

        call date_and_time(date, time, zone, values)

        res = time//" "//date//" ("//zone//")"

        write(*,'(i5,a)') &
            & values(1),' - year', &
            & values(2),' - month', &
            & values(3),' - day of the month', &
            & values(4),' - difference with UTC in minutes', &
            & values(5),' - hour of the day', &
            & values(6),' - minutes of the hour', &
            & values(7),' - seconds of the minute', &
            & values(8),' - milliseconds of the second'
    end function
end module
