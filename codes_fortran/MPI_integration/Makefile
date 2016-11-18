# Faire make ... pour exectuer les commandes associées
# typiquement: make all + make traitement execute le programme puis génère les frames
# enchainer avec make movie crée l'animation
#
all :

seq :
	gfortran integration_sequentielle.f90 -o integration_sequentielle 
	./integration_sequentielle

mpi :
	mpif90 integration_mpi.f90 -o integration_mpi
	mpirun -n 32 ./integration_mpi
