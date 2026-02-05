#------------------------------------------------------------------------
# Makefile for LIBIKU on Linux
# $Id: makefile,v 1.2 2004/04/15 10:36:46 morten Exp $
#--# ----------------------------------------------------------------------

ARCH   = linux
TOPDIR = /private/kehok/Soft/splpuma/fd/
SRCDIR = ${TOPDIR}/ikulib/src
OBJDIR = ${TOPDIR}/ikulib/linux/obj
IKULIB = $(TOPDIR)/ikulib/linux/lib

# #------------------------------------------------------------------------

F77C     = ifort
F90C     = ifort
CC       = icc
# Optimisation flags for Intel Compiler 8.0 and Pentium 4 Xeon
OPTFLAGS = -static-libcxa -O3 -tpp7
# Enable auto-parallelising of the code.
PARALLEL = -parallel
F90FLAGS = -c -w95 $(OPTFLAGS) $(PARALLEL) -I$(LIBDIR) -I$(IKULIB) 
F77FLAGS = -c -w95 $(OPTFLAGS) $(PARALLEL) -I$(LIBDIR) -I$(IKULIB) 
CFLAGS   = -c $(OPTFLAGS) -Wall $(PARALLEL)


#------------------------------------------------------------------------
#             BUILD  LIBRARY:  
#------------------------------------------------------------------------

LIBIKU = $(OBJDIR)/iku_$(ARCH)_module.o \
         $(OBJDIR)/fsdriv.o \
         $(OBJDIR)/segyio.o \
         $(OBJDIR)/iku_io_module.o \
         $(OBJDIR)/iku_constants_module.o

all : $(IKULIB)/libiku.a

$(IKULIB)/libiku.a: $(LIBIKU)  
	ar vr libiku.a $(LIBIKU)
	mv libiku.a $(IKULIB)/libiku.a

#------------------------------------------------------------------------
# machine_dep:
#------------------------------------------------------------------------

$(OBJDIR)/iku_$(ARCH)_module.o: $(SRCDIR)/machine_dep/iku_$(ARCH)_module.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/iku_$(ARCH)_module.o $(SRCDIR)/machine_dep/iku_$(ARCH)_module.f90
	mv *.mod $(IKULIB)/

#------------------------------------------------------------------------
# constants:
#------------------------------------------------------------------------
$(OBJDIR)/iku_constants_module.o: $(SRCDIR)/constants/iku_constants_module.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/iku_constants_module.o $(SRCDIR)/constants/iku_constants_module.f90
	mv *.mod $(IKULIB)/

#------------------------------------------------------------------------
# io:
#------------------------------------------------------------------------

SEGYH = $(SRCDIR)/io/debug.h \
        $(SRCDIR)/io/ebcdic.h \
        $(SRCDIR)/io/fsdriv.h \
        $(SRCDIR)/io/segyio.h \
        $(SRCDIR)/io/segyio.f.h

$(OBJDIR)/fsdriv.o: $(SRCDIR)/io/fsdriv.c $(SEGYH)
	$(CC) $(CFLAGS) -o $(OBJDIR)/fsdriv.o  $(SRCDIR)/io/fsdriv.c

$(OBJDIR)/segyio.o: $(SRCDIR)/io/segyio.c $(SEGYH)
	$(CC) $(CFLAGS) -o $(OBJDIR)/segyio.o  $(SRCDIR)/io/segyio.c

$(OBJDIR)/iku_io_module.o: $(SRCDIR)/io/iku_io/*.f90
	$(F90C) $(F90FLAGS) -I $(IKULIB) -o $(OBJDIR)/iku_io_module.o $(SRCDIR)/io/iku_io/iku_io_module.f90
	mv *.mod $(IKULIB)/

#------------------------------------------------------------------------
# clean:
#------------------------------------------------------------------------
clean:
	-rm  -f $(OBJDIR)/*.o  $(IKULIB)/*.mod $(IKULIB)/*.a $(OBJDIR)/*.il
