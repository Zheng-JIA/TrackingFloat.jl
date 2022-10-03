using PkgTemplates
t = Template(;user="Zheng-JIA",
            julia=v"1.8",
            plugins=[
                Git(; manifest=true, ssh=true),
                GitHubActions(; x86=true),
                Codecov(),
                Documenter{GitHubActions}(),
                Develop(),
            ])
t("TrackingFloats")

# if the manifest doesn't have anything, then using test will pop up error. Pkg.resolve() will help resolve the issues.
# Don't give package or github repo the same name as the struct name, such as TrackingFloat.jl and struct TrackingFloat because it will cause problems

# How to create a package
# 1. Create a github repo.
# 2. Connect codecov.io to your github account.
# 3. ]add PkgTemplates. This package generates a template structure and adds all files in the corrcet file structure and sets up CI integration. For example: run
# t = Template(; 
#            user="wahlquisty", # github user
#            dir="~/research", # what directory to put the package in
#            julia=v"1.8",
#            plugins=[
#                Git(; manifest=true, ssh=true),
#                GitHubActions(; x86=true),
#                Codecov(),
#                Documenter{GitHubActions}(),
#                Develop(),
#            ],
#        )
# t("FastPKSim")
# and a package will be generated automatically. Hopefully, this is connected to your github repo now (for me, that just happened automatically...?)
# 4. Now, copy/paste CI.yml from another package, for example DiscretePIDs.jl. Change versions etc if necessary.
# 5. Add your code and functions to your package. Remember to export functions that you wish to export.
# 6. Add tests in runtests.jl. Use @test and ≈ if working with Floats. You can run the tests in the terminal using ]test
# 7. If you want: Add the CI badge to your readme. See other packages for example.
# 8. push your code to github. Make sure CI passes.
# 9. Now you should be up and running!



