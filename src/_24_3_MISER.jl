#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
##############
# 24.3 MISER #
##############
#############
# Footnotes #
#############
export monte_miser_alloc, monte_miser_init, monte_miser_integrate,
       monte_miser_free, monte_miser_params_get, monte_miser_params_set








# This function allocates and initializes a workspace for Monte Carlo
# integration in dim dimensions.  The workspace is used to maintain the state
# of the integration.
# 
#   Returns: Ptr{gsl_monte_miser_state}
function monte_miser_alloc(dim::Integer)
    output_ptr = ccall( (:gsl_monte_miser_alloc, :libgsl),
        Ptr{gsl_monte_miser_state}, (Csize_t, ), dim )
    output_ptr==C_NULL ? throw(GSL_ERROR(8)) : output_ptr
end
@vectorize_1arg Number monte_miser_alloc


# This function initializes a previously allocated integration state.  This
# allows an existing workspace to be reused for different integrations.
# 
#   Returns: Cint
function monte_miser_init(s::Ptr{gsl_monte_miser_state})
    errno = ccall( (:gsl_monte_miser_init, :libgsl), Cint,
        (Ptr{gsl_monte_miser_state}, ), s )
    if errno!= 0 throw(GSL_ERROR(errno)) end
end


# This routines uses the miser Monte Carlo algorithm to integrate the function
# f over the dim-dimensional hypercubic region defined by the lower and upper
# limits in the arrays xl and xu, each of size dim.  The integration uses a
# fixed number of function calls calls, and obtains random sampling points
# using the random number generator r. A previously allocated workspace s must
# be supplied.  The result of the integration is returned in result, with an
# estimated absolute error abserr.
# 
#   Returns: Cint
function monte_miser_integrate(xl::Real)
    f = convert(Ptr{gsl_monte_function}, Array(gsl_monte_function, 1))
    errno = ccall( (:gsl_monte_miser_integrate, :libgsl), Cint,
        (Ptr{gsl_monte_function}, Cdouble), f, xl )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(f)
end
@vectorize_1arg Number monte_miser_integrate


# This function frees the memory associated with the integrator state s.
# 
#   Returns: Void
function monte_miser_free(s::Ptr{gsl_monte_miser_state})
    ccall( (:gsl_monte_miser_free, :libgsl), Void,
        (Ptr{gsl_monte_miser_state}, ), s )
end


# This function copies the parameters of the integrator state into the user-
# supplied params structure.
# 
#   Returns: Void
function monte_miser_params_get(s::Ptr{gsl_monte_miser_state})
    params = convert(Ptr{gsl_monte_miser_params}, Array(gsl_monte_miser_params, 1))
    ccall( (:gsl_monte_miser_params_get, :libgsl), Void,
        (Ptr{gsl_monte_miser_state}, Ptr{gsl_monte_miser_params}), s, params )
    return unsafe_load(params)
end


# This function sets the integrator parameters based on values provided in the
# params structure.
# 
#   Returns: Void
function monte_miser_params_set(s::Ptr{gsl_monte_miser_state}, params::Ptr{gsl_monte_miser_params})
    ccall( (:gsl_monte_miser_params_set, :libgsl), Void,
        (Ptr{gsl_monte_miser_state}, Ptr{gsl_monte_miser_params}), s, params )
end
