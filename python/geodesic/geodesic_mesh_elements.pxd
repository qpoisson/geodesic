cdef extern from "geodesic_mesh_elements.h" namespace "geodesic":
    cdef cppclass Vertex:
        Vertex()

    cdef cppclass SurfacePoint:
        SurfacePoint()
        SurfacePoint(Vertex*)
        double& x()
        double& y()
        double& z()