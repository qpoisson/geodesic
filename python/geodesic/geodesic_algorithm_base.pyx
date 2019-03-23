import numpy
cimport numpy

from libcpp.vector cimport vector

from geodesic_algorithm_base cimport GeodesicAlgorithmBase as cpp_GeodesicAlgorithmBase
from geodesic_mesh_elements cimport SurfacePoint

cdef class GeodesicAlgorithmBase:
    cdef cpp_GeodesicAlgorithmBase *thisptr      # hold a C++ instance which we're wrapping
    def __cinit__(self, mesh):
        self.thisptr = NULL
    def __dealloc__(self):
        del self.thisptr
    def geodesic(self, source, destination):
        cdef vector[SurfacePoint] path
        self.thisptr.geodesic(SurfacePoint(&self.thisptr.mesh().vertices()[<int>source]), SurfacePoint(&self.thisptr.mesh().vertices()[<int>destination]), path)

        cdef vector[vector[double]] spath
        spath.resize(path.size())
        for k in range(path.size()):
            spath[k].push_back(path[k].x())
            spath[k].push_back(path[k].y())
            spath[k].push_back(path[k].z())
        return spath
    def print_statistics(self):
        self.thisptr.print_statistics()
