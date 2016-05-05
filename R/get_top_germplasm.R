averages_germplasm <- function(study, has_trait){
  #library(dplyr)
  #summarize by germplasm
  by_germplasm <- study %>% dplyr::group_by(study$germplasmName)
  options(warn=-1)
  dat = by_germplasm %>% dplyr::summarise_each(dplyr::funs(mean))
  options(warn=0)
  dat <- dat[!is.na(dat[, has_trait]), ]
  dat$germplasmName <- as.character(dat$germplasmName)
  dgp =dat$germplasmName

  # the above omits all germplasm with missing values
  # add back germplasm with at least one value in trait
  study$germplasmName = as.character(study$germplasmName)
  agp = study[!is.na(study[, has_trait]), "germplasmName"]
  agp = agp[!agp %in% dgp]
  x=study[!is.na(study[, has_trait]) & study$germplasmName %in% agp, ]

  dat <- rbind(dat, x)
  # summarize by germplasm
  dat
}


#' get_top_germplasm
#'
#' Selects a top list of germplasm by calculating ranks on the given trait.
#' The parameters frac and max_g are both used to calculate a minimum number of germplasm.
#' That is if the number based on fraction is bigger than max_g, the latter will be used.
#'
#' @param study data.frame
#' @param frac numeric value between 0.01 and 1 inclusive
#' @param max_g integer maximum number of germplasm
#' @param trait character the trait to use for calculation of ranking
#'
#' @return data.frame
#' @export
get_top_germplasm <- function(study = NULL, frac = .1, max_g = 20, trait = "Harvest index") {
  stopifnot(!is.null(study))
  stopifnot(is.data.frame(study))
  has_trait <- stringr::str_detect(names(study), trait) %>% which
  #stopifnot(length(has_trait) == 0)

  dat <- averages_germplasm(study, has_trait)

  nf <- round(nrow(dat) * frac, 0)
  ng = min(nf, max_g)
  sst <- dat[, c(has_trait)][[1]] %>% sort
  cut_off = sst[length(sst) - ng +1]
  dat = dat[dat[[has_trait]] >= cut_off, ]
  dat = as.data.frame(dat)
  dat[with(dat, order(-dat[, has_trait])), ]
}
