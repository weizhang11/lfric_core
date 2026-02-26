#!/bin/bash
set -e

export FC=ftn
#export FC=nvfortran
#export FC=gfortran
export CC=cc
#export CPP=cpp
#export FPP=cpp
#export FPP=/opt/cray/pe/gcc-native/13/bin/cpp
#export FPPFLAGS="-P -x f95-cpp-input"
#export FPP="cpp -x f95-cpp-input"
#export FFLAGS="${FFLAGS} -cpp"
#export FFLAGS="${FFLAGS} -Mpreprocess"
#export FPP="Mpreprocess"

export NVDIR=/lustre/blizzard/nwp501/scratch/zhangw/lfric-gh/nvidia-env

#export NVHPC=/opt/nvidia/hpc_sdk
#export NVHPC_VER=25.3
#export LD_LIBRARY_PATH=/opt/nvidia/hpc_sdk/Linux_aarch64/25.3/compilers/lib:$LD_LIBRARY_PATH


#HPC_PREFIX=/opt/nvidia/hpc_sdk/Linux_aarch64/25.3/compilers

YAXT_PREFIX=$NVDIR/yaxt-nvidia
MPI_PREFIX=/opt/cray/pe/mpich/8.1.32/ofi/nvidia/23.3
NC_PREFIX=/opt/cray/pe/netcdf-hdf5parallel/4.9.0.17/nvidia/24.3
XIOS_PREFIX=$NVDIR/xios-nvidia
PFUNIT_PREFIX=$NVDIR/pfunit-nvidia2/PFUNIT-4.15

YAXT_INC="${YAXT_PREFIX}/include"
YAXT_LIB="${YAXT_PREFIX}/lib"
MPI_INC="${MPI_PREFIX}/include"
MPI_LIB="${MPI_PREFIX}/lib"
NC_INC="${NC_PREFIX}/include"
NC_LIB="${NC_PREFIX}/lib"
XIOS_INC="${XIOS_PREFIX}/inc"
XIOS_LIB="${XIOS_PREFIX}/lib"
PFUNIT_INC="${PFUNIT_PREFIX}/include"
PFUNIT_LIB="${PFUNIT_PREFIX}/lib"
HPC_LIB="${HPC_PREFIX}/lib"

make clean || true
ulimit -s unlimited

export NO_MPI=1

#make VERBOSE=1 \
#  FCFLAGS="$FCFLAGS -I${YAXT_INC} -I${MPI_INC} -I${NC_INC} -I${XIOS_INC} -I${PFUNIT_INC}" \
#  FFLAGS="$FFLAGS -I${YAXT_INC} -I${MPI_INC} -I${NC_INC} -I${XIOS_INC} -I${PFUNIT_INC}" \
#  F90FLAGS="$F90FLAGS -I${YAXT_INC} -I${MPI_INC} -I${NC_INC} -I${XIOS_INC} -I${PFUNIT_INC}" \
##  LDFLAGS="$LDFLAGS -L${YAXT_LIB} -L${MPI_LIB} -L${NC_LIB} -L${XIOS_LIB} -L${PFUNIT_LIB}" \
# LIBS="$LIBS -lyaxt -lyaxt_c -lmpichf90 -lnetcdff -lnetcdf -lfunit"  \
#  build

make VERBOSE=1 \
  FCFLAGS="$FCFLAGS -I${YAXT_INC} -I${XIOS_INC} -I${PFUNIT_INC}" \
  FFLAGS="$FFLAGS -I${YAXT_INC} -I${XIOS_INC} -I${PFUNIT_INC}" \
  F90FLAGS="$F90FLAGS -I${YAXT_INC} -I${XIOS_INC} -I${PFUNIT_INC}" \
  LDFLAGS="$LDFLAGS -L${YAXT_LIB} -L${XIOS_LIB} -L${PFUNIT_LIB} -L${HPC_LIB}" \
  LIBS="$LIBS -lyaxt -lyaxt_c -lfunit"  \
  build


#make VERBOSE=1 \
#  FCFLAGS="$FCFLAGS -I${YAXT_INC} -I${MPI_INC} -I${NC_INC} -I${XIOS_INC} -I${PFUNIT_INC}" \
#  FFLAGS="$FFLAGS -I${YAXT_INC} -I${MPI_INC} -I${NC_INC} -I${XIOS_INC} -I${PFUNIT_INC}" \
#  F90FLAGS="$F90FLAGS -I${YAXT_INC} -I${MPI_INC} -I${NC_INC} -I${XIOS_INC} -I${PFUNIT_INC}" \
#  LDFLAGS="$LDFLAGS -L${YAXT_LIB} -L${MPI_LIB} -L${NC_LIB} -L${XIOS_LIB} -L${PFUNIT_LIB}" \
#  LIBS="$LIBS -lyaxt -lyaxt_c -lmpichf90  -lnetcdf -lfunit"  \
#  build
