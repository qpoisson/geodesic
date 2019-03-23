import numpy
cimport numpy

from libcpp.vector cimport vector

from geodesic_mesh cimport Mesh as cpp_Mesh
from geodesic_algorithm_base cimport GeodesicAlgorithmBase as cpp_GeodesicAlgorithmBase
from geodesic_algorithm_dijkstra cimport GeodesicAlgorithmDijkstra as cpp_GeodesicAlgorithmDijkstra

cdef class GeodesicAlgorithmDijkstra(GeodesicAlgorithmBase):
    def __cinit__(self, mesh):
        self.thisptr = new cpp_GeodesicAlgorithmDijkstra((<Mesh>(mesh)).thisptr)

