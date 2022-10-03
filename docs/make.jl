using TrackingFloats
using Documenter

DocMeta.setdocmeta!(TrackingFloats, :DocTestSetup, :(using TrackingFloats); recursive=true)

makedocs(;
    modules=[TrackingFloats],
    authors="Zheng Jia <zheng.jia@control.lth.se> and contributors",
    repo="https://github.com/Zheng-JIA/TrackingFloats.jl/blob/{commit}{path}#{line}",
    sitename="TrackingFloats.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Zheng-JIA.github.io/TrackingFloats.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Zheng-JIA/TrackingFloats.jl",
    devbranch="master",
)
