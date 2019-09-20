import numpy as np
cimport numpy as np
import cython

# We now need to fix a datatype for our arrays. I've used the variable
# DTYPE for this, which is assigned to the usual NumPy runtime
# type info object.
DTYPE = np.double

# "ctypedef" assigns a corresponding compile-time type to DTYPE_t. For
# every type in the numpy module there's a corresponding compile-time
# type with a _t-suffix.
ctypedef np.double_t DTYPE_t

@cython.boundscheck(False)
@cython.wraparound(False)

cpdef evolve(np.ndarray[DTYPE_t, ndim=2] u, np.ndarray[DTYPE_t, ndim=2] u_previous, double a, double dt, double dx2, double dy2):
    """Explicit time evolution.
       u:            new temperature field
       u_previous:   previous field
       a:            diffusion constant
       dt:           time step. """

    cdef int n,m
    n = u.shape[0]
    m = u.shape[1]
    cdef int i,j
    for i in range(1, n-1):
        for j in range(1, m-1):
            u[i, j] = u_previous[i, j] + a * dt * ( \
             (u_previous[i+1, j] - 2*u_previous[i, j] + \
              u_previous[i-1, j]) / dx2 + \
             (u_previous[i, j+1] - 2*u_previous[i, j] + \
                 u_previous[i, j-1]) / dy2 )
    u_previous[:] = u[:]

