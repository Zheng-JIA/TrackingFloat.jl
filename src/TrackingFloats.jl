module TrackingFloats

export TrackingFloat, getmax, value

import Base: +, *, -, /
using LinearAlgebra

struct TrackingFloat <: AbstractFloat # why need <: AbstractFloat ?? why after adding {Float64}, struct returns Int64?
    value::Float64
    max::Float64
end

TrackingFloat(v::TrackingFloat) = v

function value(x::T) where T <: TrackingFloat
    return x.value
end

function getmax(x::T) where T <: TrackingFloat
    return x.max
end

function TrackingFloat(x::T) where T <:Real
    y = TrackingFloat(x, zero(x))
    return y
end

function Base.:+(x::T, y::T) where T<: TrackingFloat# why do we want to convert float to int? what's the purpose?
    z = x.value + y.value
    maximal = max(abs(x.max), abs(y.max), abs(x.value), abs(y.value))
    return TrackingFloat(z, maximal)
end
TrackingFloat(1.0) + TrackingFloat(2.0)

function Base.:*(x::T, y::T) where T<: TrackingFloat
    z = x.value * y.value
    maximal = max(abs(x.max), abs(y.max), abs(x.value), abs(y.value))
    return TrackingFloat(z, maximal)
end

function Base.:-(x::T, y::T) where T <: TrackingFloat
    z = x.value - y.value
    maximal = max(abs(x.max), abs(y.max), abs(x.value), abs(y.value))
    return TrackingFloat(z, maximal)
end

function Base.:/(x::T, y::T) where T <: TrackingFloat
    if abs(y.value) < 1.0
        y_inv = TrackingFloat(1.0 / y.value, y.max)
        return x * y_inv
    else
        z = x.value / y.value
        maximal = max(abs(x.max), abs(y.max), abs(x.value), abs(y.value))
        return TrackingFloat(z, maximal)
    end
end

function Base.:<(x::TrackingFloat, y::TrackingFloat)
    return x.value < y.value
end

function Base.:-(x::TrackingFloat)
    return TrackingFloat(-x.value, x.max)
end

function Base.:sqrt(x::TrackingFloat)
    return TrackingFloat(sqrt(x.value), x.max)
end


end
