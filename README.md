

- The folder `/home/christoph/Documents/argus/` contains `cinv.pxd`, `cinv.pyx` and `setup.py`.
- UNU.RAN is installed in the subfolder `unuran`.
  - Installation instructions: http://statmath.wu.ac.at/software/unuran/doc/unuran.html#Installation
  - I used `sh ./configure --prefix=/home/christoph/Documents/argus/unuran/ --enable-shared --with-pic`
- `libunuran.a` is in `/home/christoph/Documents/argus/unuran/lib`

The code below is supposed to follow the example http://statmath.wu.ac.at/software/unuran/doc/unuran.html#Example_005f0 to generate a random variate that is normally distributed. The code is slighlty adapted to use the method PINV (http://statmath.wu.ac.at/software/unuran/doc/unuran.html#PINV). The goal is to wrap the C code in Python using Cython as described here: https://cython.readthedocs.io/en/latest/src/tutorial/clibraries.html

*unuran.h in UNU.RAN library:* 

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

*Error message:*

When compiling with `python setup.py build_ext --inplace`, the following error message appears:

`/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(pinv.o): relocation
R_X86_64_32 against .rodata.str1.1 can not be used when making a shared object; recompile with -fPIC`

*Resources:*

- https://cython.readthedocs.io/en/latest/src/tutorial/clibraries.html
- https://cython.readthedocs.io/en/latest/src/userguide/external_C_code.html
- https://stavshamir.github.io/python/making-your-c-library-callable-from-python-by-wrapping-it-with-cython/
- http://statmath.wu.ac.at/software/unuran/doc/unuran.html#Example_005f0
