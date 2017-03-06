
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

Out of 52 BrAPI calls currently **51 (98.1%)** are implemented in this package.

| group                | name                                       | R.function                               |
|:---------------------|:-------------------------------------------|:-----------------------------------------|
| Authentication       | Authentication                             | ba\_login                                |
| Authentication       | Authentication                             | ba\_logout                               |
| Calls                | Calls                                      | ba\_calls                                |
| Crops                | ListCrops                                  | ba\_crops                                |
| GenomeMaps           | ListOfGenomeMap                            | ba\_genomemaps                           |
| GenomeMaps           | GenomeMapData                              | ba\_genomemaps\_data                     |
| GenomeMaps           | GenomeMapDataByRangeOnLinkageGroup         | ba\_genomemaps\_data\_range              |
| GenomeMaps           | GenomeMapDetails                           | ba\_genomemaps\_details                  |
| Germplasm            | GermplasmDetailsByGermplasmDbId            | ba\_germplasm\_details                   |
| Germplasm            | GermplasmDetailsListByStudyDbId            | ba\_germplasm\_details\_study            |
| Germplasm            | GermplasmMarkerprofile                     | ba\_germplasm\_markerprofiles            |
| Germplasm            | GermplasmPedigree                          | ba\_germplasm\_pedigree                  |
| Germplasm            | GermplasmSearchGET                         | ba\_germplasm\_search                    |
| Germplasm            | GermplasmSearchPOST                        | ba\_germplasm\_search                    |
| GermplasmAttributes  | ListAttributesByAttributeCategoryDbId      | ba\_germplasmattributes                  |
| GermplasmAttributes  | ListAttributeCategories                    | ba\_germplasmattributes\_categories      |
| GermplasmAttributes  | GermplasmAttributeValuesByGermplasmDbId    | ba\_germplasmattributes\_details         |
| Locations            | ListLocations                              | ba\_locations                            |
| MarkerProfiles       | MarkerProfileAlleleMatrix                  | ba\_markerprofiles\_allelematrix\_search |
| MarkerProfiles       | ScoresThroughPOST                          | ba\_markerprofiles\_allelematrix\_search |
| MarkerProfiles       | MarkerProfileData                          | ba\_markerprofiles\_details              |
| MarkerProfiles       | MarkerProfileSearchPost                    | ba\_markerprofiles\_search               |
| MarkerProfiles       | MarkerProfileSearch                        | ba\_markerprofiles\_search               |
| Markers              | MarkerDetailsByMarkerDbId                  | ba\_markers\_details                     |
| Markers              | MarkerSearch                               | ba\_markers\_search                      |
| ObservationVariables | VariableList                               | ba\_observationvariables                 |
| ObservationVariables | VariableDataTypeList                       | ba\_observationvariables\_datatypes      |
| ObservationVariables | VariableDetails                            | ba\_observationvariables\_details        |
| ObservationVariables | VariableOntologyList                       | ba\_observationvariables\_ontologies     |
| ObservationVariables | VariableSearch                             | ba\_observationvariables\_search         |
| Programs             | ListPrograms                               | ba\_programs                             |
| Programs             | ProgramSearch                              | ba\_programs\_search                     |
| Samples              | TakeASample                                | ba\_samples\_save                        |
| Samples              | RetrieveSampleMetadata                     | ba\_samples                              |
| Studies              | StudyDetails                               | ba\_studies\_details                     |
| Studies              | ListObservationLevels                      | ba\_studies\_observationlevels           |
| Studies              | GetObservationUnitsByObservationVariableId | ba\_studies\_observations                |
| Studies              | ObservationUnitDetails                     | ba\_studies\_observationunits            |
| Studies              | ObservationUnitDetails                     | ba\_studies\_observationunits\_save      |
| Studies              | StudyObservationVariables                  | ba\_studies\_observationvariables        |
| Studies              | ListStudySummaries                         | ba\_studies\_search                      |
| Studies              | SearchStudie                               | ba\_studies\_search                      |
| Studies              | ListSeasons                                | ba\_studies\_seasons                     |
| Studies              | ListStudyTypes                             | ba\_studies\_studytypes                  |
| Studies              | StudyObservationUnitsAsTable               | ba\_studies\_table                       |
| Studies              | PlotLayoutDetails                          | ba\_studies\_layout                      |
| Studies              | StudyObservationUnitsAsTableSave           | ba\_studies\_table\_save                 |
| Traits               | ListAllTraits                              | ba\_traits                               |
| Traits               | TraitDetails                               | ba\_traits\_details                      |
| Trials               | ListTrialSummaries                         | ba\_trials                               |
| Trials               | GetTrialById                               | ba\_trials\_details                      |

How to use the package
----------------------

See [tutorial](https://github.com/c5sire/brapi/blob/master/inst/doc/tutorial.Rmd).
