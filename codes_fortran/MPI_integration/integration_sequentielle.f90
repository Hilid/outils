program test
        use iso_fortran_env
        implicit none
        
        real(real64), parameter :: minfonc = 0
        real(real64), parameter :: maxfonc = 1
        integer, parameter :: Nb_intervalle = 10000000
        real(real64) :: solution,t1,t2
        real(real64), parameter :: pi =  4d0 * datan(1d0) 

CALL CPU_TIME(t1)
solution = integrale(minfonc, maxfonc, Nb_intervalle)
CALL CPU_TIME(t2)
write(*,*) '------------------------------------------------'
write(*,*) "Solution de l'intégrale", solution
write(*,*) "Solution quasi-exacte  ", pi
write(*,*) ''
write(*,*) 'différence', pi - solution
write(*,*) 'temps de calcul', t2-t1, ' secondes'
write(*,*) '------------------------------------------------'

contains
!=====================================================
! Fonction dont un cherche à calculer l'intégrale
function fonc(x)
        real(real64), intent(in) :: x
        real(real64) :: fonc
        fonc = 4d0 / (1d0 + x**2)
end function fonc


! calcul l'intégrale de la fonction fonc sur l'intervale [min,max]
function integrale(minf, maxf, N)
       real(real64), intent(in) :: minf,maxf
       integer, intent(in) :: N
       real(real64) :: h,integrale

       integer :: i
       real(real64) :: abscisse1, abscisse2


h = (maxf - minf) /real(N,real64)
integrale = 0
do i =1, N
        abscisse1 = minf + real((i-1), real64)*h
        abscisse2 = minf + real(i, real64)*h
        integrale = integrale+1d0/2d0*h*(fonc(abscisse1)+fonc(abscisse2))
enddo
end function integrale
end program test
