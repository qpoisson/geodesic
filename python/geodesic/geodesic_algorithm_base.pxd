from libcpp.vector cimport vector

from geodesic_mesh_elements cimport SurfacePoint
from geodesic_mesh cimport Mesh

cdef extern from "geodesic_algorithm_base.h" namespace "geodesic":
    cdef cppclass GeodesicAlgorithmBase:
        GeodesicAlgorithmBase(Mesh*)
        void propagate(vector[SurfacePoint]&, double, vector[SurfacePoint]*)
        unsigned best_source(SurfacePoint&, double&)
        void geodesic(SurfacePoint& , SurfacePoint& , vector[SurfacePoint]& )
        Mesh* mesh()
        void print_statistics()
