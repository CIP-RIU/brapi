
<!-- README.md is generated from README.Rmd. Please edit that file -->
|                       |                                                                                                                                                                                               |
|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| \[Tip\](vignette/warning.png) This package is under development. It has not yet been exhaustively tested for all calls neither. Usage may also still change. If you have suggestions please use the issue tracker. |

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/c5sire/brapi?branch=master&svg=true)](https://ci.appveyor.com/project/c5sire/brapi) [![Travis-CI Mac Build Status](https://travis-ci.org/c5sire/brapi.svg?branch=master&label=Mac%20OSX)](https://travis-ci.org/c5sire/brapi)

README
======

An R package to use the [Breeding API (BrAPI)](http://docs.brapi.apiary.io) for accessing plant breeding data.

It can be installed using:

``` r
install.packages("devtools")
devtools::install_github("c5sire/brapi")
```

The library implements currently mainly API calls to retrievie phenotypic field trial related data.

Implementation status
---------------------

| API call                 | status      |
|--------------------------|-------------|
| location                 | done        |
| germplasm search         | in progress |
| germplasm details        | in progress |
| germplasm MCPD           | in progress |
| germplasm pedigree       | in progress |
| germplasm markerprofiles | in progress |
| program list             | done        |
| study list               | done        |
| study                    | done        |
| study details            | done        |
| study layout             | done        |
| studies table            | done        |

How to use
----------

See [tutorial](https://github.com/c5sire/brapi/blob/master/vignettes/tutorial.md).
