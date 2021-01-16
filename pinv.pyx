cimport cpinv

def test_pinv(double loc, double scale):
    cdef double param[2]
    param[0] = loc
    param[1] = scale

    return test(param)

cdef test(double[2] param):

    cdef cpinv.UNUR_DISTR *distr
    cdef cpinv.UNUR_PAR *par

    distr = cpinv.unur_distr_normal(param, 2)
    par = cpinv.unur_pinv_new(distr)
    gen = cpinv.unur_init(par)

    if gen == NULL:
        return 0.0

    return cpinv.unur_sample_cont(gen)
