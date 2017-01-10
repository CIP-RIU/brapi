library(jug)

# workaround: the include function's 2nd parameter does not seem to
# work correctly. So here is a one line solution:
# Load all modules in memory to activate mw_ variables for include
x = list.files(system.file("apps/brapi", package = "brapi"), pattern = "mw_", full.names = TRUE) %>%
  lapply(source)

res <- jug() %>%
  cors() %>%
  get("/brapi/v1/", function(req, res, err){
    "\nMock BrAPI server ready!\n\n"
  }) %>%

  # each 'include' corresponds to a first level path and corresponding path
  #include(mw_logs) %>%
  include(mw_calls) %>%
  include(mw_germplasm_search) %>%
  include(mw_germplasm) %>%
  include(mw_germplasm_pedigree) %>%
  include(mw_germplasm_markerprofiles) %>%
  include(mw_attributes) %>%
  include(mw_attributes_categories) %>%
  include(mw_germplasm_attributes) %>%
  include(mw_markers) %>%
  include(mw_markerprofiles) %>%
  include(mw_markerprofiles_id) %>%
  include(mw_allelematrix_search) %>%
  include(mw_programs) %>%
  include(mw_crops) %>%
  include(mw_trials) %>%
  include(mw_seasons) %>%
  include(mw_studytypes) %>%
  include(mw_studies_search) %>%
  include(mw_studies) %>%
  include(mw_studies_layout) %>%
  include(mw_studies_germplasm) %>%
  include(mw_studies_observations) %>%
  include(mw_studies_observationunits) %>%
  include(mw_studies_observationVariables) %>%
  include(mw_studies_table) %>%
  include(mw_observationlevels) %>%
  include(mw_phenotypes_search) %>%
  include(mw_traits) %>%
  include(mw_variables_datatypes) %>%
  include(mw_variables_ontologies) %>%
  include(mw_variables) %>%
  include(mw_variables_search) %>%
  include(mw_maps) %>%
  include(mw_maps_details) %>%
  include(mw_maps_positions) %>%
  include(mw_maps_positions_range) %>%
  include(mw_locations) %>%
  include(mw_samples) %>%

  # catch any remaining unknown pathes
  simple_error_handler() %>%
  serve_it(port = 2021)
