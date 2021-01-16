
cdef extern from "unuran/include/unuran.h":
    ctypedef struct UNUR_DISTR:
        pass
    ctypedef struct UNUR_PAR:
        pass
    ctypedef struct UNUR_GEN:
        pass

    UNUR_DISTR *unur_distr_normal( const double *params, int n_params )
    UNUR_PAR *unur_pinv_new( const UNUR_DISTR *distribution )
    UNUR_GEN *unur_init( UNUR_PAR *parameters )
    double unur_sample_cont( UNUR_GEN *generator )
