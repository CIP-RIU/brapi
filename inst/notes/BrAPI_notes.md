---
title: "BrAPI_notes"
author: "Reinhard Simon"
date: "November 30, 2016"
output: pdf_document
---

# Notes on BrAPI documentation

## Metadata

Metadata are not consistently used in examples.

- Empty pagination is sometimes 'null' or '{}'; should be '{}'.
- Status object is described as list of objects (which is ok) but examples use just one object. E.g.: '{"message": "", "exception": {}}'; but should be: '[{}, ...]'.
- Empty status object should therefore be rather: '"status": []'
- Paging: although the intro says that page counting starts with page = 0 all (?) examples show a 1.

# Notes on BrAPI implemenation of sweetpotatobase

# Notes on sweetpotato database
