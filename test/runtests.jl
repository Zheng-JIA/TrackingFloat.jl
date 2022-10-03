using TrackingFloats
using Test
using LinearAlgebra

@testset "TrackingFloats.jl" begin
    v = TrackingFloat(1.0) + TrackingFloat(3.0) # We expect TrackingFloat(4, 3)
    @test v     == TrackingFloat(4,3)           # which we test using the macro @test
    @test v*v   == TrackingFloat(16, 4)
    @test v - v == TrackingFloat(0, 4)
    @test v/TrackingFloat(0.1, 0) == TrackingFloat(40, 10)

    # Try working with matrices
    A = randn(10,10)
    b = randn(10)

    # Convert using broadcast
    At = TrackingFloat.(A)
    bt = TrackingFloat.(b)

    # Try some operations
    v = A*b
    vt = At*bt
    # Did we calculate correctly? Using value to convert back to float
    @test maximum(abs, v - value.(vt)) < sqrt(eps())

    # Get the max fields using our function getmax
    getmax.(vt)



    #################### Part 2: Lets try something more complicated
    # promote_rule(::Type{Bool}, ::Type{T}) where {T<:Number} = T
    # +(x::TrackingFloat, y::Float64) = +(promote(x, y))
    Base.promote_rule(::Type{TrackingFloat}, ::Type{T}) where T<:Real = TrackingFloat

    #promote_rule(::Type{TrackingFloat}, ::Type{Float64}) = TrackingFloat
    # Is promotion working?
    #TrackingFloat(2,99)
    @test TrackingFloat(1.0, 0) + 2.0 == TrackingFloat(3, 2)

    # Create Positive definite matrix
    AA = A*A'
    # Convert to TrackingFloat matrix
    AAt = TrackingFloat.(AA)

    function Base.:<(x::TrackingFloat, y::TrackingFloat)
        return x.value < y.value
    end

    function Base.:-(x::TrackingFloat)
        return TrackingFloat(-x.value, x.max)
    end

    function Base.:sqrt(x::TrackingFloat)
        return TrackingFloat(sqrt(x.value), x.max)
    end
    sol1 = AAt\bt # Uses qr
    # Did we get the correct answer?
    @test maximum(abs, value.(sol1) - AA\b) < sqrt(eps())

    # Try cholesky factorization
    F = cholesky(AAt)

    sol2 = F\bt
    @test maximum(abs, value.(sol2) - AA\b) < sqrt(eps())

    # Which method was able to work with smallest elements?
    maximum(getmax.(sol1))
    maximum(getmax.(sol2))
end
