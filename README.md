

- The folder `/home/christoph/Documents/argus/` contains `cinv.pxd`, `cinv.pyx` and `setup.py`.
- UNU.RAN is installed in the subfolder `unuran`.
  - Installation instructions: http://statmath.wu.ac.at/software/unuran/doc/unuran.html#Installation
  - I used `sh ./configure --prefix=/home/christoph/Documents/argus/unuran/ --enable-shared --with-pic`
  - in the makefile, edit the variable `CFLAGS`: `CFLAGS = -fPIC ...`, then run `make` and `make install`
- `libunuran.a` is in `/home/christoph/Documents/argus/unuran/lib`
- Ubuntu 20.04
- gcc (Homebrew GCC 5.5.0_7) 5.5.0

The code in the repository is supposed to follow the example http://statmath.wu.ac.at/software/unuran/doc/unuran.html#Example_005f0 to generate a random variate that is normally distributed. The code is slighlty adapted to use the method PINV (http://statmath.wu.ac.at/software/unuran/doc/unuran.html#PINV). The goal is to wrap the C code in Python using Cython as described here: https://cython.readthedocs.io/en/latest/src/tutorial/clibraries.html

*unuran.h in UNU.RAN library:* 

translate to a `pxd` file using `autopxd` (use `pip install autopxd2`, see https://github.com/gabrieldemarmiesse/python-autopxd2)

```
struct unur_distr;                       
typedef struct unur_distr UNUR_DISTR;
struct unur_par;                         
typedef struct unur_par   UNUR_PAR;
struct unur_gen;                         
typedef struct unur_gen   UNUR_GEN;

UNUR_PAR *unur_pinv_new( const UNUR_DISTR *distribution );
UNUR_GEN *unur_init( UNUR_PAR *parameters );
UNUR_DISTR *unur_distr_normal( const double *params, int n_params );
double unur_sample_cont(UNUR_GEN *generator);
```

*Link the library*

Before compiling with `python setup.py build_ext --inplace`, set the environment variable `$LD_LIBRARY_PATH` to link the library:

`export LD_LIBRARY_PATH=/home/christoph/Documents/argus/unuran/lib:/usr/lib`

*Resources:*

- https://cython.readthedocs.io/en/latest/src/tutorial/clibraries.html
- https://cython.readthedocs.io/en/latest/src/userguide/external_C_code.html
- https://stavshamir.github.io/python/making-your-c-library-callable-from-python-by-wrapping-it-with-cython/
- http://statmath.wu.ac.at/software/unuran/doc/unuran.html#Example_005f0

