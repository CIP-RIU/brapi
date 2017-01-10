
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

Out of 47 BrAPI calls currently **41 (87.2%)** are implemented in this package.

| group                | status   | call                            | datatypes      |
|:---------------------|:---------|:--------------------------------|:---------------|
|                      |          | calls                           | json           |
|                      |          | germplasm-search                | json           |
|                      |          | germplasm/id                    | json           |
|                      |          | germplasm/id/pedigree           | json           |
|                      |          | germplasm/id/markerprofiles     | json           |
|                      |          | attributes                      | json           |
|                      |          | attributes/categories           | json           |
|                      |          | germplasm/id/attributes/        | json           |
|                      |          | markers                         | json           |
|                      |          | markers/id                      | json           |
|                      |          | markerprofiles                  | json           |
|                      |          | markerprofiles-search           | json           |
|                      |          | markerprofiles/id               | json           |
|                      |          | allelematrix-search             | json; csv; tsv |
|                      |          | programs                        | json           |
|                      |          | crops                           | json           |
|                      |          | trials                          | json           |
|                      |          | trials/id                       | json           |
|                      |          | seasons                         | json           |
|                      |          | studyTypes                      | json           |
|                      |          | studies-search                  | json           |
|                      |          | studies-search                  | json           |
|                      |          | studies/id                      | json           |
|                      |          | studies/id/observationVariables | json           |
|                      |          | studies/id/germplasm            | json           |
|                      |          | observationLevels               | json           |
|                      |          | studies/id/observationunits     | json           |
|                      |          | studies/id/table                | json; csv; tsv |
|                      |          | studies/id/layout               | json           |
|                      |          | studies/id/observations         | json           |
|                      |          | traits                          | json           |
|                      |          | traits/id                       | json           |
| ObservationVariables | ACCEPTED | variables/datatypes             | json           |
| ObservationVariables | ACCEPTED | ontologies                      | json           |
| ObservationVariables | ACCEPTED | variables                       | json           |
| ObservationVariables | ACCEPTED | variables/id                    | json           |
|                      |          | maps                            | json           |
|                      |          | maps/id                         | json           |
|                      |          | maps/id/positions               | json           |
|                      |          | maps/id/positions/id            | json           |
|                      |          | locations                       | json           |

How to use the package
----------------------

See [tutorial](https://github.com/c5sire/brapi/blob/master/inst/doc/tutorial.Rmd).
