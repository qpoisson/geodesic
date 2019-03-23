import numpy
cimport numpy

from libcpp.vector cimport vector

from geodesic_mesh cimport Mesh as cpp_Mesh

cdef class Mesh:
    cdef cpp_Mesh *thisptr      # hold a C++ instance which we're wrapping
    def __cinit__(self):
        self.thisptr = new cpp_Mesh()
    def __dealloc__(self):
        del self.thisptr

    def initialize_mesh_data(self, numpy.ndarray[numpy.float64_t, ndim=2] vertices, numpy.ndarray[numpy.int32_t, ndim=2] faces):
        # Define C++ vectors to contain the mesh surface components.
        cdef vector[double] points
        cdef vector[unsigned] triangles

        # Map numpy array of mesh "vertices" to C++ vector of mesh "points"
        points.resize(vertices.size)
        cdef numpy.float64_t coord
        for idx, coord in enumerate(vertices.ravel()):
            points[idx]=coord

        # Map numpy array of mesh "triangles" to C++ vector of mesh "faces"
        triangles.resize(faces.size)
        cdef numpy.int32_t indx
        for idx, indx in enumerate(faces.ravel()):
            triangles[idx]=indx
        self.thisptr.initialize_mesh_data(points, triangles)

