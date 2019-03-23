"""
This module the building of a cython wrapper around a C++ library for 
calculating the geodesic path between points on a mesh surface.

To build::
  python setup.py build_ext --inplace

"""

import numpy

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

geodesic_module = [Extension(name="geodesic",          # Name of extension
                             sources=["geodesic/__init__.pyx"], # Filename of Cython source
                             include_dirs = ['geodesic'],
                             language="c++",
                             extra_compile_args=["-std=c++11"],
                             extra_link_args=["-std=c++11"])]       # Cython create C++ source

include_directories = [numpy.get_include(), # NumPy dtypes
                       "../include/geodesic"]  # geodesic distance, C++ library.

setup(ext_modules = geodesic_module, 
      include_dirs = include_directories, 
      cmdclass = {'build_ext': build_ext},
      name='geodesic',
      license='GPL 2',
      version='1.0.3',
      url='https://github.com/mojocorp/geodesic',
      maintainer='Mojocorp',
      maintainer_email='morgan.leborgne@gmail.com',
      install_requires=['numpy', 'scipy', 'cython'],
      description="Compute geodesic distances",
      long_description="""
The geodesic module is a Cython interface to a C++ library 
(http://code.google.com/p/geodesic/) for computing
geodesic distance which is the length of shortest line between two 
vertices on a triangulated mesh in three dimensions, such that the line
lies on the surface. 

The algorithm is due Mitchell, Mount and Papadimitriou, 1987; the implementation
is due to Danil Kirsanov and the Cython interface to Gaurav Malhotra and 
Stuart Knock. 
"""
)
