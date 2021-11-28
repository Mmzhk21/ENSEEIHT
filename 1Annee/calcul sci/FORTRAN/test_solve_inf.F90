

program test_solve

  implicit none

  integer :: i, j, ierr, n
  double precision, dimension (:,:), allocatable :: L
  double precision, dimension (:), allocatable :: x, b
  double precision :: backward_error
  real :: start, finish

  write(*,*) 'n?'
  read(*,*) n

  ! Initialization: L is lower triangular
  write(*,*) 'Initialization...'
  write(*,*)
  
  allocate(L(n,n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate L(n,n) with n=',n
    goto 999
  end if

  allocate(x(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate x(n) with n=',n
    goto 999
  end if

  allocate(b(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate b(n) with n=',n
    goto 999
  end if

  L = 0.D0
  do i = 1, n  
    L(i,i) = n + 1.D0
    do j = 1, i-1
      L(i,j) = 1.D0
    end do
  end do
  b = 1.D0
    
    
  ! Left-looking triangular solve of Lx=b
  write(*,*) 'Solving with a left-looking method...'

  ! TODO : call left_looking_solve
  call cpu_time(start)
  call left_looking_solve(L,x,b,n)
  call cpu_time(finish)
  print*, (finish-start)
  ! TODO : call backward_error to check the accuracy
  print*, backward_error(L,x,b,n)
  ! TODO : display the solution if n <= 10
  if (n<=10) then
    write(*,*) x
  end if
  ! Right-looking triangular solve of Lx=b
  write(*,*) 'Solving with a right-looking method...'

  ! TODO : call right_looking_solve
  call cpu_time(start)
  call right_looking_solve(L,x,b,n)
  call cpu_time(finish)
  print*, (finish-start)
  ! TODO : call backward_error to check the accuracy
  print*, backward_error(L,x,b,n)
  ! TODO : display the solution if n <= 10
  if (n<=10) then
    write(*,*) x
  end if

999 if(allocated(L)) deallocate(L)
    if(allocated(x)) deallocate(x)
    if(allocated(b)) deallocate(b)

end program test_solve

subroutine left_looking_solve (L,x,b,n)
    integer, intent(in) :: n
    double precision, intent(in), dimension(n,n) :: L
    double precision, intent(in), dimension(n) :: b
    double precision, intent(out), dimension(n) :: x

    x = b
    do i = 1, n
        do j = 1, (i-1)
            x(i) = x(i) - L(i,j)*x(j)
        end do
        x(i) = x(i)/L(i,i)
    end do
    return
    end subroutine left_looking_solve

    subroutine right_looking_solve (L,x,b,n)
    integer, intent(in) :: n
    double precision, intent(in), dimension(n,n) :: L
    double precision, intent(in), dimension(n) :: b
    double precision, intent(out), dimension(n) :: x

    x = b
    do i = 1, n
        x(i) = x(i)/L(i,i)
        do j = i+1, n
            x(j) = x(j) - L(j,i)*x(i)
        end do
    end do
    return
    end subroutine right_looking_solve
    
    double precision function backward_error (L,x,b,n)
    implicit none
    integer, intent(in) :: n
    double precision, intent(in), dimension(n,n) :: L
    double precision, intent(in), dimension(n) :: b
    double precision, intent(in), dimension(n) :: x
    integer :: i, j
    double precision :: norme_b
    double precision :: Memoire
    

    backward_error = 0
    norme_b = 0.0
    Memoire = 0.0
    do i = 1, n
        do j = 1, n
            Memoire = Memoire + L(i,j)*x(j)
        end do
        backward_error = backward_error + (Memoire - b(i))**2
        Memoire = 0.0
        norme_b = norme_b + b(i)**2
    end do
    backward_error = sqrt(backward_error)/sqrt(norme_b)
    return
    end function backward_error
! TODO
! Implement sub-programs left_looking_solve, right_looking_solve, backward_error
