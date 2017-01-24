
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

The library implements currently mainly API calls to retrieve breeding trial related data.

Implementation status
---------------------

Out of 48 BrAPI calls currently **45 (93.8%)** are implemented in this package.

| group                | name                                       | R.function                           |
|:---------------------|:-------------------------------------------|:-------------------------------------|
| Authentication       | Authentication                             | authenticate                         |
| Calls                | Calls                                      | calls                                |
| Crops                | ListCrops                                  | crops                                |
| GenomeMaps           | ListOfGenomeMap                            | genomemaps                           |
| GenomeMaps           | GenomeMapData                              | genomemaps\_data                     |
| GenomeMaps           | GenomeMapDataByRangeOnLinkageGroup         | genomemaps\_data\_range              |
| GenomeMaps           | GenomeMapDetails                           | genomemaps\_details                  |
| Germplasm            | GermplasmDetailsByGermplasmDbId            | germplasm\_details                   |
| Germplasm            | GermplasmDetailsListByStudyDbId            | germplasm\_details\_study            |
| Germplasm            | GermplasmMarkerprofile                     | germplasm\_markerprofiles            |
| Germplasm            | GermplasmPedigree                          | germplasm\_pedigree                  |
| Germplasm            | GermplasmSearchGET                         | germplasm\_search                    |
| Germplasm            | GermplasmSearchPOST                        | germplasm\_search                    |
| GermplasmAttributes  | ListAttributesByAttributeCategoryDbId      | germplasmattributes                  |
| GermplasmAttributes  | ListAttributeCategories                    | germplasmattributes\_categories      |
| GermplasmAttributes  | GermplasmAttributeValuesByGermplasmDbId    | germplasmattributes\_details         |
| Locations            | ListLocations                              | locations                            |
| MarkerProfiles       | MarkerProfileAlleleMatrix                  | markerprofiles\_allelematrix\_search |
| MarkerProfiles       | ScoresThroughPOST                          | markerprofiles\_allelematrix\_search |
| MarkerProfiles       | MarkerProfileData                          | markerprofiles\_details              |
| MarkerProfiles       | MarkerProfileSearchPost                    | markerprofiles\_search               |
| MarkerProfiles       | MarkerProfileSearch                        | markerprofiles\_search               |
| Markers              | MarkerDetailsByMarkerDbId                  | markers\_details                     |
| Markers              | MarkerSearch                               | markers\_search                      |
| ObservationVariables | VariableList                               | observationvariables                 |
| ObservationVariables | VariableDataTypeList                       | observationvariables\_datatypes      |
| ObservationVariables | VariableDetails                            | observationvariables\_details        |
| ObservationVariables | VariableOntologyList                       | observationvariables\_ontologies     |
| Programs             | ListPrograms                               | programs                             |
| Programs             | ProgramSearch                              |                                      |
| Studies              | StudyDetails                               | studies\_details                     |
| Studies              | ListObservationLevels                      | studies\_observationlevels           |
| Studies              | GetObservationUnitsByObservationVariableId | studies\_observations                |
| Studies              | ObservationUnitDetails                     | studies\_observationunits            |
| Studies              | StudyObservationVariables                  | studies\_observationvariables        |
| Studies              | ListStudySummaries                         | studies\_search                      |
| Studies              | SearchStudie                               | studies\_search                      |
| Studies              | ListSeasons                                | studies\_seasons                     |
| Studies              | ListStudyTypes                             | studies\_studytypes                  |
| Studies              | StudyObservationUnitsAsTable               | studies\_table                       |
| Studies              | PlotLayoutDetails                          | studies\_layout                      |
| Traits               | ListAllTraits                              | traits                               |
| Traits               | TraitDetails                               | traits\_details                      |
| Trials               | ListTrialSummaries                         | trials                               |
| Trials               | GetTrialById                               | trials\_details                      |

How to use the package
----------------------

See [tutorial](https://github.com/c5sire/brapi/blob/master/inst/doc/tutorial.Rmd).
