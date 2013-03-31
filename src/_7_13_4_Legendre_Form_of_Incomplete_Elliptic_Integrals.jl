#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
#########################################################
# 7.13.4 Legendre Form of Incomplete Elliptic Integrals #
#########################################################
export gsl_sf_ellint_F, gsl_sf_ellint_F_e, gsl_sf_ellint_E, gsl_sf_ellint_E_e,
       gsl_sf_ellint_P, gsl_sf_ellint_P_e, gsl_sf_ellint_D, gsl_sf_ellint_D_e




# These routines compute the incomplete elliptic integral F(\phi,k) to the
# accuracy specified by the mode variable mode.  Note that Abramowitz & Stegun
# define this function in terms of the parameter m = k^2.
# 
#   Returns: Cdouble
#XXX Unknown input type mode::gsl_mode_t
#XXX Coerced type for mode::Void
function gsl_sf_ellint_F(phi::Cdouble, k::Cdouble, mode::Void)
    ccall( (:gsl_sf_ellint_F, :libgsl), Cdouble, (Cdouble, Cdouble, Void),
        phi, k, mode )
end


# These routines compute the incomplete elliptic integral F(\phi,k) to the
# accuracy specified by the mode variable mode.  Note that Abramowitz & Stegun
# define this function in terms of the parameter m = k^2.
# 
#   Returns: Cint
#XXX Unknown input type mode::gsl_mode_t
#XXX Coerced type for mode::Void
function gsl_sf_ellint_F_e(phi::Cdouble, k::Cdouble, mode::Void)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    gsl_errno = ccall( (:gsl_sf_ellint_F_e, :libgsl), Cint, (Cdouble,
        Cdouble, Void, Ptr{gsl_sf_result}), phi, k, mode, result )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(result)
end


# These routines compute the incomplete elliptic integral E(\phi,k) to the
# accuracy specified by the mode variable mode.  Note that Abramowitz & Stegun
# define this function in terms of the parameter m = k^2.
# 
#   Returns: Cdouble
#XXX Unknown input type mode::gsl_mode_t
#XXX Coerced type for mode::Void
function gsl_sf_ellint_E(phi::Cdouble, k::Cdouble, mode::Void)
    ccall( (:gsl_sf_ellint_E, :libgsl), Cdouble, (Cdouble, Cdouble, Void),
        phi, k, mode )
end


# These routines compute the incomplete elliptic integral E(\phi,k) to the
# accuracy specified by the mode variable mode.  Note that Abramowitz & Stegun
# define this function in terms of the parameter m = k^2.
# 
#   Returns: Cint
#XXX Unknown input type mode::gsl_mode_t
#XXX Coerced type for mode::Void
function gsl_sf_ellint_E_e(phi::Cdouble, k::Cdouble, mode::Void)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    gsl_errno = ccall( (:gsl_sf_ellint_E_e, :libgsl), Cint, (Cdouble,
        Cdouble, Void, Ptr{gsl_sf_result}), phi, k, mode, result )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(result)
end


# These routines compute the incomplete elliptic integral \Pi(\phi,k,n) to the
# accuracy specified by the mode variable mode.  Note that Abramowitz & Stegun
# define this function in terms of the parameters m = k^2 and \sin^2(\alpha) =
# k^2, with the change of sign n \to -n.
# 
#   Returns: Cdouble
#XXX Unknown input type mode::gsl_mode_t
#XXX Coerced type for mode::Void
function gsl_sf_ellint_P(phi::Cdouble, k::Cdouble, n::Cdouble, mode::Void)
    ccall( (:gsl_sf_ellint_P, :libgsl), Cdouble, (Cdouble, Cdouble,
        Cdouble, Void), phi, k, n, mode )
end


# These routines compute the incomplete elliptic integral \Pi(\phi,k,n) to the
# accuracy specified by the mode variable mode.  Note that Abramowitz & Stegun
# define this function in terms of the parameters m = k^2 and \sin^2(\alpha) =
# k^2, with the change of sign n \to -n.
# 
#   Returns: Cint
#XXX Unknown input type mode::gsl_mode_t
#XXX Coerced type for mode::Void
function gsl_sf_ellint_P_e(phi::Cdouble, k::Cdouble, n::Cdouble, mode::Void)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    gsl_errno = ccall( (:gsl_sf_ellint_P_e, :libgsl), Cint, (Cdouble,
        Cdouble, Cdouble, Void, Ptr{gsl_sf_result}), phi, k, n, mode, result )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(result)
end


# These functions compute the incomplete elliptic integral D(\phi,k) which is
# defined through the Carlson form RD(x,y,z) by the following relation,
# D(\phi,k,n) = (1/3)(\sin(\phi))^3 RD (1-\sin^2(\phi), 1-k^2 \sin^2(\phi), 1).
# The argument n is not used and will be removed in a future release.
# 
#   Returns: Cdouble
#XXX Unknown input type mode::gsl_mode_t
#XXX Coerced type for mode::Void
function gsl_sf_ellint_D(phi::Cdouble, k::Cdouble, n::Cdouble, mode::Void)
    ccall( (:gsl_sf_ellint_D, :libgsl), Cdouble, (Cdouble, Cdouble,
        Cdouble, Void), phi, k, n, mode )
end


# These functions compute the incomplete elliptic integral D(\phi,k) which is
# defined through the Carlson form RD(x,y,z) by the following relation,
# D(\phi,k,n) = (1/3)(\sin(\phi))^3 RD (1-\sin^2(\phi), 1-k^2 \sin^2(\phi), 1).
# The argument n is not used and will be removed in a future release.
# 
#   Returns: Cint
#XXX Unknown input type mode::gsl_mode_t
#XXX Coerced type for mode::Void
function gsl_sf_ellint_D_e(phi::Cdouble, k::Cdouble, n::Cdouble, mode::Void)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    gsl_errno = ccall( (:gsl_sf_ellint_D_e, :libgsl), Cint, (Cdouble,
        Cdouble, Cdouble, Void, Ptr{gsl_sf_result}), phi, k, n, mode, result )
    if gsl_errno!= 0 throw(GSL_ERROR(gsl_errno)) end
    return unsafe_ref(result)
end