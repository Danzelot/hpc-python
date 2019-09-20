from cffi import FFI
ffibuilder = FFI()

ffibuilder.cdef("""
    void evolve(double *u, double *u_previous, int nx, int ny,
                double a, double dt, double dx2, double dy2);
                """)

# set_source() gives the name of the python extension module to
# produce, and some C source code as a string.  This C code needs
# to make the declarated functions, types and globals available,
# so it is often just the "#include".
ffibuilder.set_source("_evolve",
"""
    void evolve(double *u, double *u_previous, int nx, int ny,
                double a, double dt, double dx2, double dy2);
""",
   sources = ['evolve.c'],
   library_dirs = [],
   libraries = []   # if evolve utilizes math library we need to include it
                       # here
)

ffibuilder.compile(verbose=True)

