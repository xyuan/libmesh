# need to link lshaped.xda
BUILT_SOURCES = lshaped.xda
lshaped.xda:
	$(AM_V_GEN)$(LN_S) $(top_srcdir)/examples/adjoints/adjoints_ex1/lshaped.xda .

CLEANFILES = lshaped.xda

example_name  = adjoints_ex2
check_SCRIPTS = run.sh
install_dir   = $(examples_install_path)/adjoints/ex2
data          = adjoints_ex2.C ../adjoints_ex1/lshaped.xda L-shaped.C L-shaped.h femparameters.C femparameters.h general.in l-shaped.in L-qoi.C L-qoi.h run.sh
sources       = $(data) run.sh

CLEANFILES += primal.out.* adjoint_0.out.*

# also need to link input for VPATH builds
if LIBMESH_VPATH_BUILD
  BUILT_SOURCES += .linkstamp
.linkstamp:
	-rm -f general.in  && $(LN_S) $(srcdir)/general.in .
	-rm -f l-shaped.in && $(LN_S) $(srcdir)/l-shaped.in .
	$(AM_V_GEN)touch .linkstamp

  CLEANFILES += general.in l-shaped.in .linkstamp
endif

##############################################
# include common example environment
include $(top_srcdir)/examples/Make.common
