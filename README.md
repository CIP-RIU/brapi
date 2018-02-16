
<!-- README.md is generated from README.Rmd. Please edit that file -->
BrAPI R package
===============

<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build status](https://ci.appveyor.com/api/projects/status/7qsrpldj8g3m3lu3?svg=true)](https://ci.appveyor.com/project/cipriuhq/brapi) [![Build Status](https://travis-ci.org/CIP-RIU/brapi.svg?branch=master)](https://travis-ci.org/CIP-RIU/brapi) [![Coverage Status](https://img.shields.io/codecov/c/github/CIP-RIU/brapi/master.svg)](https://codecov.io/github/CIP-RIU/brapi?branch=master)

This version is still under development. The implementation sometimes changes minor details.
--------------------------------------------------------------------------------------------

README
======

An R package to use the [Breeding API (BrAPI)](http://docs.brapi.apiary.io) for accessing plant breeding data.

It can be installed using:

``` r
install.packages("devtools")
devtools::install_github("CIP-RIU/brapi")
```

How to use the package
----------------------

See [tutorial](https://github.com/CIP-RIU/brapi/blob/master/inst/doc/tutorial.Rmd).


# Note
In case you get this error while you extract information from BTI databases (musabse, cassavabase, yambase, among others):
```
Error in value[[3L]](cond) : 
  Error in is.ba_status_ok(resp = res): Internal Server Error (HTTP 500). Failed to connect due internal server error.
```
It is due to BTI severs are under maintenance.
