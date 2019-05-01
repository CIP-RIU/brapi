
<!-- README.md is generated from README.Rmd. Please edit that file -->

# BrAPI R package

<!-- README.md is generated from README.Rmd. Please edit that file
 
[![Build status](https://ci.appveyor.com/api/projects/status/7qsrpldj8g3m3lu3?svg=true)](https://ci.appveyor.com/project/cipriuhq/brapi)
 -->

[![Build
Status](https://travis-ci.org/CIP-RIU/brapi.svg?branch=master)](https://travis-ci.org/CIP-RIU/brapi)
[![Coverage
Status](https://img.shields.io/codecov/c/github/CIP-RIU/brapi/master.svg)](https://codecov.io/github/CIP-RIU/brapi?branch=master)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/brapi)](https://cran.r-project.org/package=brapi)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

This version is still under development. The implementation sometimes
changes minor details.

Current support is mainly for BrAPI version 1.1.

Support for version 1.2 is underway.

A 176 tests have been implemented to check on compliance.

For independent checks against a database you may use
<http://webapps.ipk-gatersleben.de/brapivalidator>.

It seems several databases may not currently be fully accessible due to
protocol changes.

# README

An R package to use the [Breeding API
(BrAPI)](http://docs.brapi.apiary.io) for accessing plant breeding data.
See the [documentation](https://cip-riu.github.io/brapi/) for details.

It can be installed using:

``` r
install.packages("devtools")
devtools::install_github("CIP-RIU/brapi")
```

## How to use the package

See [tutorial](https://cip-riu.github.io/brapi/articles/tutorial.html).
