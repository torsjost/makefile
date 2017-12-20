#------------------------------------------------------------------
#| Makefile to create the test programs for the pfaffian routines | 
#| pfaffianAFP.f and pfaffianH.f                                  |
#------------------------------------------------------------------
#| Requires the Linear algebra libraries    Lapack and Blas       |
#|                                                                |
#------------------------------------------------------------------
#

#.SUFFIXES: .f90
#.f90.o:
#        $(FOR) -c $(FFLAGS) $*.f90

FFLAGS=-fcheck=all
LIBS= -L/opt/intel/Compiler/11.0/069/mkl/lib/em64t/ -lmkl_lapack -lmkl_core
-lmkl_em64t -lmkl_intel_thread -lmkl_intel_lp64 -liomp5
FOR=gfortran $(FFLAGS)
LIBS= -L/usr/lib/sse2/atlas/ -llapack -lblas


OBJSZ2= detmod.o xm_main.o pfaffianAFP_DEF.o
#pfaffianAFP_DEF.o pfaffianH_DEF.o 

main: $(OBJSZ2)
        $(FOR) $(FFLAGS) $(OBJSZ2)  $(LIBS) -o main

detmod.mod: detmod.o detmod.f90
        $(FOR) -c $(LIBS) $(FFLAGS) detmod.f90
detmod.o: detmod.f90
        $(FOR) -c $(LIBS) $(FFLAGS) detmod.f90
xm_main.o: detmod.mod xm_main.f90
        $(FOR) -c $(LIBS) $(FFLAGS) xm_main.f90
pfaffianAFP_DEF.o: pfaffianAFP_DEF.f90
        $(FOR) -c $(LIBS) pfaffianAFP_DEF.f90
#%.o: %.f90 

clean:
        rm main *.o detmod.mod
#distrib:
#        tar zcvf Pfaffian90.tgz  makefile90 README *.f90

# ----------------------------------------------------------------------
#                              Dependencies
# ----------------------------------------------------------------------
