program test
        use iso_fortran_env
        use mpi
        implicit none
!        include 'mpif.h'


! Variables de l'algorithme et gestion du tps
        real(real64), parameter :: minfonc = 0
        real(real64), parameter :: maxfonc = 1
        integer, parameter :: Nb_intervalle = 1000000000
        real(real64) :: sol_partielle,t1,t2
        real(real64), parameter :: pi =  4d0 * datan(1d0) 

! Variables de MPI
        integer :: erreur, totalCPU, monCPU,Nb_intervalleCPU
        real(real64) :: sol_totale,minfoncCPU, maxfoncCPU
! Initialisation de la communication
call MPI_INIT(erreur)

! Récupération du nombre de processeurs utilisés
call MPI_COMM_SIZE(MPI_COMM_WORLD, totalCPU, erreur)

! Récupération du numéro du CPU
call MPI_COMM_RANK(MPI_COMM_WORLD, monCPU, erreur)

CALL CPU_TIME(t1)

! Calcul des bornes de l'intervalle à faire pour chaques CPU
minfoncCPU = minfonc + monCPU * (maxfonc-minfonc) / real(totalCPU,real64)
maxfoncCPU = minfonc + (monCPU+1)* (maxfonc-minfonc) / real(totalCPU,real64)

! Calcul du nombre d'intervalle
Nb_intervalleCPU = nint(real(Nb_intervalle,real64) / real(totalCPU,real64)) 

! Chaques processeurs calcul ça portion
sol_partielle = integrale(minfoncCPU, maxfoncCPU, Nb_intervalleCPU)

! Tout les coeurs s'attendent puis centralisent sur le coeur 0
call MPI_BARRIER(MPI_COMM_WORLD, erreur)
call MPI_REDUCE(sol_partielle, sol_totale, 1, MPI_DOUBLE_PRECISION, MPI_SUM, 0,&
 MPI_COMM_WORLD, erreur)

CALL CPU_TIME(t2)

! affichage seulement par le coeur 0
if(monCPU.eq.0) then
        write(*,*) '------------------------------------------------'
        write(*,*) 'Nombre de coeurs utilisées', totalCPU
        write(*,*) 'Nombre d"intervalles par coeurs', Nb_intervalleCPU
        write(*,*) "Solution de l'intégrale", sol_totale
        write(*,*) "Solution quasi-exacte  ", pi
        write(*,*) ''
        write(*,*) 'différence', pi - sol_totale
        write(*,*) 'temps de calcul', t2-t1, ' secondes'
        write(*,*) '------------------------------------------------'
endif

! fin de l'utilisation de MPI
call MPI_FINALIZE(erreur)


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
