---
title: "BrAPI_notes"
author: "Reinhard Simon"
date: "November 30, 2016"
output: pdf_document
---

# General remarks

All id's in request and response objects should be given as integers!? See: germplasm/attributes call.

## SCOPE

Use of Scope: if 'GENOTYPING' is used for calls like 'attributes' should 'PHENOTYPING' be used for calls related to 'traits' and 'variables'?

## Metadata

Metadata are not consistently used in examples.

- Empty pagination is sometimes 'null' or '{}'; should be '{}'.
- Status object is described as list of objects (which is ok) but examples use just one object. E.g.: '{"message": "", "exception": {}}'; but should be: '[{}, ...]'.
- Empty status object should therefore be rather: '"status": []'
- Paging: although the intro says that page counting starts with page = 0 all (?) examples show a 1.

## Call notation

- should we always use the trailing '/' before the question mark for the parameters?
- is there agreement on the full path structure: after the server name there is only one optional path element for the crop on multi-crop databases? That is: my.server.org/[mycrop]/brapi/v1/? No other addtional elements before [mycrop]?
- on a multicrop server: in the concept of REST architecture one should be able to get the next step from just looking at server calls. So, how do I know which crops to look for in the first call? One option: Can we assume an initial empty call for all brapi servers like: my.server.org/brapi/v1/crops which returns the list of all crops on that server and then one can go from there? E.g. assume the crops calls returns crop1, crop2, ... and then one knows that the crop specific calls are accessible via: my.server.org/crop1/brapi/v1/calls; my.server.org/crop2/brapi/v1/calls. In the case of a single crop server as before the 'crop' path element is omitted. To be more explicit: maybe the crop call should return corresponding links for each crop (like datalinks).

# calls

- dataype: the argument reads: dataFile; should better be same: datatype or 'format'?


# List of Trials

- Call says: crops; should be: trials

# Germplasm

- naming inconsistent?: germplasmPUI -> donorGermplasmPUI
- acquisitionDate: should be within nested donors (one acquisition date for each donation?)

# germplasm_markerprofiles

- the inner result items should be wrapped into 'data'

# attributes

- response json: 1st entry should probably be: attrubuteDbId (not attributeCategoryDbId; otherwise duplicating with attributeCategoryId)
- attributeCategoryId (2nd entry) should probably be: attributeCategoryDbId
- should there be: pages
- response object: currentPage = 0!
- unclear: attributes are always molecular (genetic/genomic markers)?
  - attributeCategory equals the category of the phenotypic effect (as the example suggests)?
- Or attribute equals 'trait'?

# attribute categories

htt- defines page and pageSize in parameters (should also be defined then for attributes!)
- contratry to up-front definition: 1st page is defined here as 1 (not 0 as in general?!)

# markers

- should be markers-search (as the section title seems to imply?)
- include parameter: may be better: synonyms?

# markerProfile search

- should also be markerprofiles-search?
- search parameter 'studyDbId' is not in response object
- method parameter not described

# makerprofiles by id

- markerProfilesDbId not in example call but in description; should the call be:
  brapi/v1/markerprofiles/germplasmDbId/?markerprofileDbId={markerprofileDbId}&...
- example on t3sandbox includes in response the field 'encoding': to be used?
- instructions on paging state first page equals 1 (not 0 - contrary to intro)

# allelematrix-search

- in case of multiple markerprofileDbId it is unclear how exactly the response object will look like
- Note: R brapi just sends one profile
- format parameter not documented?
- markerDbId: for multiple the call repeats them; but notation in other cases uses commas?
- there is no germplasmDbId to filter as in the preceding marker data call as part of the path nor as parameter? It seems that the assumption is that a germplasm may have several markerprofileDbId (where each markerprofileDbId in turn is unique for a germplasmId). In the format given in the example (https://github.com/plantbreeding/Documentation/wiki/BrAPI-TSV-Expected-Formats) the table apparently lists markers in the rows and the germplasm markerprofiles in the columns. Should be made more explicit since it seems to me the more standard way in general is to list objects (germplasm) in the rows and attributes (markers) in the columns. The column header should probably therefore be: markerDbId? Assuming 'mpdbid?' stands for 'markerprofileDbId?'?

# location

- pageNumber should be: currentPage in pagination.

# studies-search

- name -> studyName
- consistent use of plural and singular for identifier(s)
- consistent use of -search / list / summary
- POST parameters are different from GET version!

# studies layout

- could be large response object; is paging envisioned? No page parameters are documented. If no paging: the paging details should all be set to 0.
- this call is similar to the studies/id/germplasm one. In the latter case, though, the common variables/factors are singled out in the result object (that is studyDbId and trialName). This is similar to prior calls. So, studies layout should do the same?

# studies observations

- not clear: can there be more than one observationVariable? How should they be requested? Comma separated values or repetition of parameter name? Both ways are used elsewhere.
  Example: observationVariableDbIds=1,2,3 or
          observationVariableDbIds=1&observationVariableDbIds=2observationVariableDbIds=3

# studies observationunits

- data fields are basically all the same as in studies observtions. Only in the former 'operator' corresponds to 'collector' in this call. Should be the same!
- also different between the two: observationTimestamp vs observationTimeStamp
- in response: observationVariableId should be: observationVariableDbId
- unclear: if request is for observationLevel = plant: what should be returned if the observations are only at plot level (or all plantNumber = 0)? Just the corresponding fields or no observations for that observationUnit at all?
- camelCase? observationUnits (comapare to: observationVariables)

# studies observationVariables

- it does not have paging parameters? Corrrect? Pagination object slots should all be set to zero.
- from the first example several fields are missing after ontologyName like synonyms, contextOfUse. However in other cases they are simply set to empty strings (or null). So they should be listed in any case.
- in response: name should be observationVariableName as in other similar cases.
- for empty objects in method and scale should be {} - not: null

# studies germplasm details

- is grouped both under germplasm and studies!

# studies table GET

- observationTimestamp would be different for each measurement; so one column here does not make sense

# traits

- parameters page & pageSize not documentedl but probably implied


 
  
  
  
  


