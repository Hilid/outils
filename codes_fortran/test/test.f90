program test
        use iso_fortran_env
        implicit none
        
        real(real64), parameter :: minfonc = 0
        real(real64), parameter :: maxfonc = 1
        integer, parameter :: Nb_intervalle = 1000000
        real(real64) :: solution
        real(real64), parameter :: pi =  4d0 * datan(1d0) 

solution = integrale(minfonc, maxfonc, Nb_intervalle)

write(*,*) '------------------------------------------------'
write(*,*) "Solution de l'intégrale", solution
write(*,*) "Solution quasi-exacte  ", pi
write(*,*) ''
write(*,*) "différence", pi - solution
write(*,*) '------------------------------------------------'

contains
!=====================================================
function fonc(x)
        real(real64), intent(in) :: x
        real(real64) :: fonc
        fonc = 4d0 / (1d0 + x**2)
end function fonc


! calcul l'intégrale de la fonction fonc sur l'intervale [min,max]
function integrale(min, max, N)
       real(real64), intent(in) :: min,max
       integer, intent(in) :: N
       real(real64) :: h,integrale

       integer :: i
       real(real64) :: abscisse1, abscisse2


h = (max - min) /Nb_intervalle
integrale = 0
do i =1, N
        abscisse1 = minfonc + real((i-1), real64)/real(N, real64) * (maxfonc-minfonc)
        abscisse2 = minfonc + real((i), real64)/real(N, real64) * (maxfonc-minfonc)
        integrale = integrale+1d0/2d0*h*(fonc(abscisse1)+fonc(abscisse2))
enddo

end function integrale



end program test
