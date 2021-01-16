from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

examples_extension = Extension(
    name="pinv",
    sources=["pinv.pyx"],
    libraries=["unuran"],
    library_dirs=["/home/christoph/Documents/argus/unuran/lib"],
    include_dirs=["/home/christoph/Documents/argus/unuran/include"]
)

setup(
    name="pinv",
    ext_modules=cythonize([examples_extension],
                          language_level="3")
)
