
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

Out of 47 BrAPI calls currently **36 (76.6%)** are implemented in this package.

| call                            | datatypes      | methods   | scope       |
|:--------------------------------|:---------------|:----------|:------------|
| calls                           | json           | GET       | CORE        |
| germplasm-search                | json           | GET; POST | CORE        |
| germplasm/id                    | json           | GET       | CORE        |
| germplasm/id/pedigree           | json           | GET       | CORE        |
| germplasm/id/markerprofiles     | json           | GET       | GENOTYPING  |
| attributes                      | json           | GET       | GENOTYPING  |
| attributes/categories           | json           | GET       | GENOTYPING  |
| germplasm/id/attributes/        | json           | GET       | GENOTYPING  |
| markers                         | json           | GET       | GENOTYPING  |
| markers/id                      | json           | GET       | GENOTYPING  |
| markerprofiles                  | json           | GET       | GENOTYPING  |
| markerprofiles-search           | json           | POST      | GENOTYPING  |
| markerprofiles/id               | json           | GET       | GENOTYPING  |
| allelematrix-search             | json; csv; tsv | GET; POST | GENOTYPING  |
| programs                        | json           | GET       | CORE        |
| crops                           | json           | GET       | CORE        |
| trials                          | json           | GET       | PHENOTYPING |
| trials/id                       | json           | GET       | PHENOTYPING |
| seasons                         | json           | GET       | PHENOTYPING |
| studyTypes                      | json           | GET       | PHENOTYPING |
| studies-search                  | json           | GET       | PHENOTYPING |
| studies-search                  | json           | POST      | PHENOTYPING |
| studies/id                      | json           | GET       | PHENOTYPING |
| studies/id/observationVariables | json           | GET       | PHENOTYPING |
| studies/id/germplasm            | json           | GET       | PHENOTYPING |
| observationLevels               | json           | GET       | PHENOTYPING |
| studies/id/observationunits     | json           | GET; POST | PHENOTYPING |
| studies/id/table                | json; csv; tsv | GET       | PHENOTYPING |
| studies/id/table                | json           | POST      | PHENOTYPING |
| studies/id/layout               | json           | GET       | PHENOTYPING |
| studies/id/observations         | json           | GET       | PHENOTYPING |
| maps                            | json           | GET       | GENOTYPING  |
| maps/id                         | json           | GET       | GENOTYPING  |
| maps/id/positions               | json           | GET       | GENOTYPING  |
| maps/id/positions/id            | json           | GET       | GENOTYPING  |
| locations                       | json           | GET       | PHENOTYPING |

How to use the package
----------------------

See [tutorial](https://github.com/c5sire/brapi/blob/master/inst/doc/tutorial.Rmd).
