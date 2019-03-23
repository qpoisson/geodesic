from libcpp.vector cimport vector

from geodesic_mesh_elements cimport Vertex
 
cdef extern from "geodesic_mesh.h" namespace "geodesic":
    cdef cppclass Mesh:
        Mesh()
        void initialize_mesh_data(vector[double]&, vector[unsigned]&)
        vector[Vertex]& vertices()