
<!-- README.md is generated from README.Rmd. Please edit that file -->
|                                                                                                                                                                                      |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| This package is under development. It has not yet been exhaustively tested for all calls neither. Usage may also still change. If you have suggestions please use the issue tracker. |

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/c5sire/brapi?branch=master&svg=true)](https://ci.appveyor.com/project/c5sire/brapi) [![Travis-CI Mac Build Status](https://travis-ci.org/c5sire/brapi.svg?branch=master&label=Mac%20OSX)](https://travis-ci.org/c5sire/brapi) [![Coverage Status](https://img.shields.io/codecov/c/github/c5sire/brapi/master.svg)](https://codecov.io/github/c5sire/brapi?branch=master)

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

Out of 47 BrAPI calls currently **38 (80.9%)** are implemented in this package.

| group | status | call                            | datatypes      |
|:------|:-------|:--------------------------------|:---------------|
| NA    | NA     | calls                           | json           |
| NA    | NA     | germplasm-search                | json           |
| NA    | NA     | germplasm/id                    | json           |
| NA    | NA     | germplasm/id/pedigree           | json           |
| NA    | NA     | germplasm/id/markerprofiles     | json           |
| NA    | NA     | attributes                      | json           |
| NA    | NA     | attributes/categories           | json           |
| NA    | NA     | germplasm/id/attributes/        | json           |
| NA    | NA     | markers                         | json           |
| NA    | NA     | markers/id                      | json           |
| NA    | NA     | markerprofiles                  | json           |
| NA    | NA     | markerprofiles-search           | json           |
| NA    | NA     | markerprofiles/id               | json           |
| NA    | NA     | allelematrix-search             | json; csv; tsv |
| NA    | NA     | programs                        | json           |
| NA    | NA     | crops                           | json           |
| NA    | NA     | trials                          | json           |
| NA    | NA     | trials/id                       | json           |
| NA    | NA     | seasons                         | json           |
| NA    | NA     | studyTypes                      | json           |
| NA    | NA     | studies-search                  | json           |
| NA    | NA     | studies-search                  | json           |
| NA    | NA     | studies/id                      | json           |
| NA    | NA     | studies/id/observationVariables | json           |
| NA    | NA     | studies/id/germplasm            | json           |
| NA    | NA     | observationLevels               | json           |
| NA    | NA     | studies/id/observationunits     | json           |
| NA    | NA     | studies/id/table                | json; csv; tsv |
| NA    | NA     | studies/id/layout               | json           |
| NA    | NA     | studies/id/observations         | json           |
| NA    | NA     | traits                          | json           |
| NA    | NA     | traits/id                       | json           |
| NA    | NA     | variables/datatypes             | json           |
| NA    | NA     | maps                            | json           |
| NA    | NA     | maps/id                         | json           |
| NA    | NA     | maps/id/positions               | json           |
| NA    | NA     | maps/id/positions/id            | json           |
| NA    | NA     | locations                       | json           |

How to use the package
----------------------

See [tutorial](https://github.com/c5sire/brapi/blob/master/inst/doc/tutorial.Rmd).
