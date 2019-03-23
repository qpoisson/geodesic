from libcpp.vector cimport vector

from geodesic_mesh_elements cimport SurfacePoint
from geodesic_mesh cimport Mesh
from geodesic_algorithm_base cimport GeodesicAlgorithmBase

cdef extern from "geodesic_algorithm_subdivision.h" namespace "geodesic":
    cdef cppclass GeodesicAlgorithmSubdivision(GeodesicAlgorithmBase):
        GeodesicAlgorithmSubdivision(Mesh*)
