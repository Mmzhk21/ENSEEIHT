program test_solve

  implicit none

  integer :: i, j, ierr, n
  double precision, dimension (:,:), allocatable :: L
  double precision, dimension (:), allocatable :: x, b
  double precision :: erreur
  double precision, external :: backward_error
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
   call left_looking_solve(L,x,b,n)
  ! TODO : call backward_error to check the accuracy
   erreur = backward_error(L,x,b,n)
   print *, "l'erreur inverse", erreur
  ! TODO : display the solution if n <= 10
   if (n <= 10) print *, x
  ! Right-looking triangular solve of Lx=b
  write(*,*) 'Solving with a right-looking method...'

  ! TODO : call right_looking_solve
  call right_looking_solve(L,x,b,n)
  ! TODO : call backward_error to check the accuracy
  erreur =  backward_error(L,x,b,n)
  print *, "l'erreur inverse", erreur
  ! TODO : display the solution if n <= 10
   if (n <= 10) print *, x

999 if(allocated(L)) deallocate(L)
    if(allocated(x)) deallocate(x)
    if(allocated(b)) deallocate(b)

end program test_solve

! TODO
! Implement sub-programs left_looking_solve, right_looking_solve, backward_error

  !left_looking_solve
subroutine left_looking_solve(L,x,b,n)
  integer :: n
  double precision, dimension (n,n) :: L
  double precision, dimension (n) :: x, b
  REAL :: t1,t2
   x = b
   call cpu_time(t1)
   do j = 1, n
       do i = 1 , j-1
          x(j) = x(j) - L(j,i)*x(i)
       end do
       x(j) = x(j)/L(j,j)
   end do
   call cpu_time(t2)
   print *, "temps sans report",t2-t1
end subroutine left_looking_solve

subroutine right_looking_solve(L,x,b,n)
  integer :: n
  double precision, dimension (n,n) :: L
  double precision, dimension (n) :: x, b
  REAL :: t1,t2
   x = b
   call cpu_time(t1)
   do j = 1, n
       x(j) = x(j)/L(j,j)
       do i = j+1,n
          x(i) = x(i) - L(i,j)*x(j)
       end do
   end do
   call cpu_time(t2)
   print *, "temps avec report",t2-t1
end subroutine right_looking_solve

! backward_error(L,x,b,n)
double precision FUNCTION backward_error(L,x,b,n)
  integer :: n
  double precision, dimension (n,n) :: L
  double precision, dimension (n) :: x, b
  double precision, dimension (n) :: v

  v= matmul(L,x)-b
  backward_error = sqrt(dot_product(v,v))/sqrt(dot_product(b,b))
END FUNCTION backward_error


     !  question de compréhension:

   !l algorithme right_looking_solve est plus rapide car son temps d execution 3.00002284E-06 est inferieur au temps d exécution de l algorithme left_looking_solve 4.00003046E-06 et ceci s explique par le faite que les matrices sont rangée en memoire colomme par colonne donc l accès est plus rapide par colonne que par ligne 






