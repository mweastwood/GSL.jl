#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
######################################################
# 22.16 Updating and accessing 2D histogram elements #
######################################################
export histogram2d_increment, histogram2d_accumulate, histogram2d_get,
       histogram2d_get_xrange, histogram2d_get_yrange, histogram2d_xmax,
       histogram2d_xmin, histogram2d_nx, histogram2d_ymax, histogram2d_ymin,
       histogram2d_ny, histogram2d_reset


# This function updates the histogram h by adding one (1.0) to the bin whose x
# and y ranges contain the coordinates (x,y).          If the point (x,y) lies
# inside the valid ranges of the histogram then the function returns zero to
# indicate success.  If (x,y) lies outside the limits of the histogram then the
# function returns GSL_EDOM, and none of the bins are modified.  The error
# handler is not called, since it is often necessary to compute histograms for
# a small range of a larger dataset, ignoring any coordinates outside the range
# of interest.
# 
#   Returns: Cint
function histogram2d_increment(x::Real, y::Real)
    h = convert(Ptr{gsl_histogram2d}, Array(gsl_histogram2d, 1))
    errno = ccall( (:gsl_histogram2d_increment, :libgsl), Cint,
        (Ptr{gsl_histogram2d}, Cdouble, Cdouble), h, x, y )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(h)
end
@vectorize_2arg Number histogram2d_increment


# This function is similar to gsl_histogram2d_increment but increases the value
# of the appropriate bin in the histogram h by the floating-point number
# weight.
# 
#   Returns: Cint
function histogram2d_accumulate(x::Real, y::Real, weight::Real)
    h = convert(Ptr{gsl_histogram2d}, Array(gsl_histogram2d, 1))
    errno = ccall( (:gsl_histogram2d_accumulate, :libgsl), Cint,
        (Ptr{gsl_histogram2d}, Cdouble, Cdouble, Cdouble), h, x, y, weight )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(h)
end
#TODO This vectorization macro is not implemented
#@vectorize_3arg Number histogram2d_accumulate


# This function returns the contents of the (i,j)-th bin of the histogram h.
# If (i,j) lies outside the valid range of indices for the histogram then the
# error handler is called with an error code of GSL_EDOM and the function
# returns 0.
# 
#   Returns: Cdouble
function histogram2d_get(h::Ptr{gsl_histogram2d}, i::Integer, j::Integer)
    ccall( (:gsl_histogram2d_get, :libgsl), Cdouble, (Ptr{gsl_histogram2d},
        Csize_t, Csize_t), h, i, j )
end


# These functions find the upper and lower range limits of the i-th and j-th
# bins in the x and y directions of the histogram h.  The range limits are
# stored in xlower and xupper or ylower and yupper.  The lower limits are
# inclusive (i.e. events with these coordinates are included in the bin) and
# the upper limits are exclusive (i.e. events with the value of the upper limit
# are not included and fall in the neighboring higher bin, if it exists).  The
# functions return 0 to indicate success.  If i or j lies outside the valid
# range of indices for the histogram then the error handler is called with an
# error code of GSL_EDOM.
# 
#   Returns: Cint
function histogram2d_get_xrange(h::Ptr{gsl_histogram2d}, i::Integer)
    xlower = convert(Ptr{Cdouble}, Array(Cdouble, 1))
    xupper = convert(Ptr{Cdouble}, Array(Cdouble, 1))
    errno = ccall( (:gsl_histogram2d_get_xrange, :libgsl), Cint,
        (Ptr{gsl_histogram2d}, Csize_t, Ptr{Cdouble}, Ptr{Cdouble}), h, i,
        xlower, xupper )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(xlower), unsafe_load(xupper)
end


# These functions find the upper and lower range limits of the i-th and j-th
# bins in the x and y directions of the histogram h.  The range limits are
# stored in xlower and xupper or ylower and yupper.  The lower limits are
# inclusive (i.e. events with these coordinates are included in the bin) and
# the upper limits are exclusive (i.e. events with the value of the upper limit
# are not included and fall in the neighboring higher bin, if it exists).  The
# functions return 0 to indicate success.  If i or j lies outside the valid
# range of indices for the histogram then the error handler is called with an
# error code of GSL_EDOM.
# 
#   Returns: Cint
function histogram2d_get_yrange(h::Ptr{gsl_histogram2d}, j::Integer)
    ylower = convert(Ptr{Cdouble}, Array(Cdouble, 1))
    yupper = convert(Ptr{Cdouble}, Array(Cdouble, 1))
    errno = ccall( (:gsl_histogram2d_get_yrange, :libgsl), Cint,
        (Ptr{gsl_histogram2d}, Csize_t, Ptr{Cdouble}, Ptr{Cdouble}), h, j,
        ylower, yupper )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(ylower), unsafe_load(yupper)
end


# These functions return the maximum upper and minimum lower range limits and
# the number of bins for the x and y directions of the histogram h.  They
# provide a way of determining these values without accessing the
# gsl_histogram2d struct directly.
# 
#   Returns: Cdouble
function histogram2d_xmax(h::Ptr{gsl_histogram2d})
    ccall( (:gsl_histogram2d_xmax, :libgsl), Cdouble,
        (Ptr{gsl_histogram2d}, ), h )
end


# These functions return the maximum upper and minimum lower range limits and
# the number of bins for the x and y directions of the histogram h.  They
# provide a way of determining these values without accessing the
# gsl_histogram2d struct directly.
# 
#   Returns: Cdouble
function histogram2d_xmin(h::Ptr{gsl_histogram2d})
    ccall( (:gsl_histogram2d_xmin, :libgsl), Cdouble,
        (Ptr{gsl_histogram2d}, ), h )
end


# These functions return the maximum upper and minimum lower range limits and
# the number of bins for the x and y directions of the histogram h.  They
# provide a way of determining these values without accessing the
# gsl_histogram2d struct directly.
# 
#   Returns: Csize_t
function histogram2d_nx(h::Ptr{gsl_histogram2d})
    ccall( (:gsl_histogram2d_nx, :libgsl), Csize_t, (Ptr{gsl_histogram2d},
        ), h )
end


# These functions return the maximum upper and minimum lower range limits and
# the number of bins for the x and y directions of the histogram h.  They
# provide a way of determining these values without accessing the
# gsl_histogram2d struct directly.
# 
#   Returns: Cdouble
function histogram2d_ymax(h::Ptr{gsl_histogram2d})
    ccall( (:gsl_histogram2d_ymax, :libgsl), Cdouble,
        (Ptr{gsl_histogram2d}, ), h )
end


# These functions return the maximum upper and minimum lower range limits and
# the number of bins for the x and y directions of the histogram h.  They
# provide a way of determining these values without accessing the
# gsl_histogram2d struct directly.
# 
#   Returns: Cdouble
function histogram2d_ymin(h::Ptr{gsl_histogram2d})
    ccall( (:gsl_histogram2d_ymin, :libgsl), Cdouble,
        (Ptr{gsl_histogram2d}, ), h )
end


# These functions return the maximum upper and minimum lower range limits and
# the number of bins for the x and y directions of the histogram h.  They
# provide a way of determining these values without accessing the
# gsl_histogram2d struct directly.
# 
#   Returns: Csize_t
function histogram2d_ny(h::Ptr{gsl_histogram2d})
    ccall( (:gsl_histogram2d_ny, :libgsl), Csize_t, (Ptr{gsl_histogram2d},
        ), h )
end


# This function resets all the bins of the histogram h to zero.
# 
#   Returns: Void
function histogram2d_reset()
    h = convert(Ptr{gsl_histogram2d}, Array(gsl_histogram2d, 1))
    ccall( (:gsl_histogram2d_reset, :libgsl), Void, (Ptr{gsl_histogram2d},
        ), h )
    return unsafe_load(h)
end
