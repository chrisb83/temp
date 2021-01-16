

- The folder `/home/christoph/Documents/argus/` contains `cinv.pxd`, `cinv.pyx` and `setup.py`.
- UNU.RAN is installed in the subfolder `unuran`.
  - Installation instructions: http://statmath.wu.ac.at/software/unuran/doc/unuran.html#Installation
  - I used `sh ./configure --prefix=/home/christoph/Documents/argus/unuran/ --enable-shared --with-pic`
- `libunuran.a` is in `/home/christoph/Documents/argus/unuran/lib`
- Ubuntu 20.04
- gcc (Homebrew GCC 5.5.0_7) 5.5.0

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

```
building 'pinv' extension
gcc -pthread -B /home/christoph/anaconda3/envs/scipydev/compiler_compat -Wl,--sysroot=/ -Wsign-compare -DNDEBUG -g -fwrapv -O3 -Wall -Wstrict-prototypes -fPIC -I. -I/home/christoph/Documents/argus/unuran/include -I/home/christoph/anaconda3/envs/scipydev/include/python3.8 -c pinv.c -o build/temp.linux-x86_64-3.8/pinv.o
gcc -pthread -shared -B /home/christoph/anaconda3/envs/scipydev/compiler_compat -L/home/christoph/anaconda3/envs/scipydev/lib -Wl,-rpath=/home/christoph/anaconda3/envs/scipydev/lib -Wl,--no-as-needed -Wl,--sysroot=/ build/temp.linux-x86_64-3.8/pinv.o -L/home/christoph/Documents/argus/unuran/lib -lunuran -o /home/christoph/Documents/argus/pinv.cpython-38-x86_64-linux-gnu.so
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(pinv.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(x_gen.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(cont.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(distr.o): relocation R_X86_64_32S against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(distr_info.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(matr.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(c_normal.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(c_normal_gen.o): relocation R_X86_64_32S against symbol `_unur_stdgen_sample_normal_sum' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(ndtr.o): relocation R_X86_64_32 against `.data' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(ndtri.o): relocation R_X86_64_32 against `.data' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(functparser.o): relocation R_X86_64_32S against `.data' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(inverror.o): relocation R_X86_64_32 against symbol `unur_dstd_eval_invcdf' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(urng_default.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(debug.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(error.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(fmax.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(lobatto.o): relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(stream.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(umalloc.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(cstd.o): relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(dgt.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(dstd.o): relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(hinv.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(mixt.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(ninv.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(discr.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(countpdf.o): relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(counturn.o): relocation R_X86_64_32S against `.text' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(urng_builtin.o): relocation R_X86_64_32 against symbol `unur_urng_MRG31k3p_reset' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(urng_unuran.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(fish.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(mrg31k3p.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: /home/christoph/Documents/argus/unuran/lib/libunuran.a(urng.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/home/christoph/anaconda3/envs/scipydev/compiler_compat/ld: final link failed: nonrepresentable section on output
collect2: error: ld returned 1 exit status
error: command 'gcc' failed with exit status 1
```

*Resources:*

- https://cython.readthedocs.io/en/latest/src/tutorial/clibraries.html
- https://cython.readthedocs.io/en/latest/src/userguide/external_C_code.html
- https://stavshamir.github.io/python/making-your-c-library-callable-from-python-by-wrapping-it-with-cython/
- http://statmath.wu.ac.at/software/unuran/doc/unuran.html#Example_005f0

