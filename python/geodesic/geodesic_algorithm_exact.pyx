import numpy
cimport numpy

from libcpp.vector cimport vector

from geodesic_mesh cimport Mesh as cpp_Mesh
from geodesic_algorithm_base cimport GeodesicAlgorithmBase as cpp_GeodesicAlgorithmBase
from geodesic_algorithm_exact cimport GeodesicAlgorithmExact as cpp_GeodesicAlgorithmExact

cdef class GeodesicAlgorithmExact(GeodesicAlgorithmBase):
    def __cinit__(self, mesh):
        self.thisptr = new cpp_GeodesicAlgorithmExact((<Mesh>(mesh)).thisptr)

