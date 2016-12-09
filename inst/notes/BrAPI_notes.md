---
title: "BrAPI_notes"
author: "Reinhard Simon"
date: "November 30, 2016"
output: pdf_document
---

# Notes on BrAPI documentation

## SCOPE

Use of Scope: if 'GENOTYPING' is used for calls like 'attributes' should 'PHENOTYPING' be used for calls related to 'traits' and 'variables'?

## Metadata

Metadata are not consistently used in examples.

- Empty pagination is sometimes 'null' or '{}'; should be '{}'.
- Status object is described as list of objects (which is ok) but examples use just one object. E.g.: '{"message": "", "exception": {}}'; but should be: '[{}, ...]'.
- Empty status object should therefore be rather: '"status": []'
- Paging: although the intro says that page counting starts with page = 0 all (?) examples show a 1.

## List of Trials

- Call says: crops; should be: trials

## Germplasm

- naming inconsistent?: germplasmPUI -> donorGermplasmPUI
- acquisitionDate: should be within nested donors (one acquisition date for each donation?)

## germplasm_markerprofiles

- the inner result items should be wrapped into 'data'

## attributes

- response json: 1st entry should probably be: attrubuteDbId (not attributeCategoryDbId; otherwise duplicating with attributeCategoryId)
- attributeCategoryId (2nd entry) should probably be: attributeCategoryDbId
- should there be: pages
- response object: currentPage = 0!
- unclear: attributes are always molecular (genetic/genomic markers)?
  - attributeCategory equals the category of the phenotypic effect (as the example suggests)?
- Or attribute equals 'trait'?

## attribute categories

- defines page and pageSize in parameters (should also be defined then for attributes!)
- contratry to up-front definition: 1st page is defined here as 1 (not 0 as in general?!)

# Notes on BrAPI implemenation of sweetpotatobase

# Notes on sweetpotato database
