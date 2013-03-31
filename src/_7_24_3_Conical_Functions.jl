#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
############################
# 7.24.3 Conical Functions #
############################
export gsl_sf_conicalP_half, gsl_sf_conicalP_half_e, gsl_sf_conicalP_mhalf,
       gsl_sf_conicalP_mhalf_e, gsl_sf_conicalP_0, gsl_sf_conicalP_0_e,
       gsl_sf_conicalP_1, gsl_sf_conicalP_1_e, gsl_sf_conicalP_sph_reg,
       gsl_sf_conicalP_sph_reg_e, gsl_sf_conicalP_cyl_reg,
       gsl_sf_conicalP_cyl_reg_e


# These routines compute the irregular Spherical Conical Function
# P^{1/2}_{-1/2 + i \lambda}(x) for x > -1.
# 
#   Returns: Cdouble
function gsl_sf_conicalP_half(lambda::Cdouble, x::Cdouble)
    ccall( (:gsl_sf_conicalP_half, :libgsl), Cdouble, (Cdouble, Cdouble),
        lambda, x )
end


# These routines compute the irregular Spherical Conical Function
# P^{1/2}_{-1/2 + i \lambda}(x) for x > -1.
# 
#   Returns: Cint
function gsl_sf_conicalP_half_e(lambda::Cdouble, x::Cdouble)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    gsl_errno = ccall( (:gsl_sf_conicalP_half_e, :libgsl), Cint, (Cdouble,
        Cdouble, Ptr{gsl_sf_result}), lambda, x, result )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(result)
end


# These routines compute the regular Spherical Conical Function  P^{-1/2}_{-1/2
# + i \lambda}(x) for x > -1.
# 
#   Returns: Cdouble
function gsl_sf_conicalP_mhalf(lambda::Cdouble, x::Cdouble)
    ccall( (:gsl_sf_conicalP_mhalf, :libgsl), Cdouble, (Cdouble, Cdouble),
        lambda, x )
end


# These routines compute the regular Spherical Conical Function  P^{-1/2}_{-1/2
# + i \lambda}(x) for x > -1.
# 
#   Returns: Cint
function gsl_sf_conicalP_mhalf_e(lambda::Cdouble, x::Cdouble)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    gsl_errno = ccall( (:gsl_sf_conicalP_mhalf_e, :libgsl), Cint, (Cdouble,
        Cdouble, Ptr{gsl_sf_result}), lambda, x, result )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(result)
end


# These routines compute the conical function  P^0_{-1/2 + i \lambda}(x) for x
# > -1.
# 
#   Returns: Cdouble
function gsl_sf_conicalP_0(lambda::Cdouble, x::Cdouble)
    ccall( (:gsl_sf_conicalP_0, :libgsl), Cdouble, (Cdouble, Cdouble),
        lambda, x )
end


# These routines compute the conical function  P^0_{-1/2 + i \lambda}(x) for x
# > -1.
# 
#   Returns: Cint
function gsl_sf_conicalP_0_e(lambda::Cdouble, x::Cdouble)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    gsl_errno = ccall( (:gsl_sf_conicalP_0_e, :libgsl), Cint, (Cdouble,
        Cdouble, Ptr{gsl_sf_result}), lambda, x, result )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(result)
end


# These routines compute the conical function  P^1_{-1/2 + i \lambda}(x) for x
# > -1.
# 
#   Returns: Cdouble
function gsl_sf_conicalP_1(lambda::Cdouble, x::Cdouble)
    ccall( (:gsl_sf_conicalP_1, :libgsl), Cdouble, (Cdouble, Cdouble),
        lambda, x )
end


# These routines compute the conical function  P^1_{-1/2 + i \lambda}(x) for x
# > -1.
# 
#   Returns: Cint
function gsl_sf_conicalP_1_e(lambda::Cdouble, x::Cdouble)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    gsl_errno = ccall( (:gsl_sf_conicalP_1_e, :libgsl), Cint, (Cdouble,
        Cdouble, Ptr{gsl_sf_result}), lambda, x, result )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(result)
end


# These routines compute the Regular Spherical Conical Function
# P^{-1/2-l}_{-1/2 + i \lambda}(x) for x > -1,  l >= -1.
# 
#   Returns: Cdouble
function gsl_sf_conicalP_sph_reg{gsl_int<:Integer}(l::gsl_int, lambda::Cdouble, x::Cdouble)
    ccall( (:gsl_sf_conicalP_sph_reg, :libgsl), Cdouble, (Cint, Cdouble,
        Cdouble), l, lambda, x )
end


# These routines compute the Regular Spherical Conical Function
# P^{-1/2-l}_{-1/2 + i \lambda}(x) for x > -1,  l >= -1.
# 
#   Returns: Cint
function gsl_sf_conicalP_sph_reg_e{gsl_int<:Integer}(l::gsl_int, lambda::Cdouble, x::Cdouble)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    gsl_errno = ccall( (:gsl_sf_conicalP_sph_reg_e, :libgsl), Cint, (Cint,
        Cdouble, Cdouble, Ptr{gsl_sf_result}), l, lambda, x, result )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(result)
end


# These routines compute the Regular Cylindrical Conical Function  P^{-m}_{-1/2
# + i \lambda}(x) for x > -1,  m >= -1.
# 
#   Returns: Cdouble
function gsl_sf_conicalP_cyl_reg{gsl_int<:Integer}(m::gsl_int, lambda::Cdouble, x::Cdouble)
    ccall( (:gsl_sf_conicalP_cyl_reg, :libgsl), Cdouble, (Cint, Cdouble,
        Cdouble), m, lambda, x )
end


# These routines compute the Regular Cylindrical Conical Function  P^{-m}_{-1/2
# + i \lambda}(x) for x > -1,  m >= -1.
# 
#   Returns: Cint
function gsl_sf_conicalP_cyl_reg_e{gsl_int<:Integer}(m::gsl_int, lambda::Cdouble, x::Cdouble)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    gsl_errno = ccall( (:gsl_sf_conicalP_cyl_reg_e, :libgsl), Cint, (Cint,
        Cdouble, Cdouble, Ptr{gsl_sf_result}), m, lambda, x, result )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(result)
end