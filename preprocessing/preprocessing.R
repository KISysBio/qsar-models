#' @rdname preprocessing
#'
#' @param chemblDataset A dataframe containing the compounds downloaded from ChEMBL website
#' @param measures "IC50" (default), "Ki" or c("IC50","Ki")
#'
#' @return
#' @export
#' @import dplyr
#'
#' @examples
get_clean_dataset <- function(chemblDataset, measures=c("IC50"), removeDuplicated=TRUE){
  
  if(!measures %in% chemblDataset$STANDARD_TYPE){
    whichMeasures <- measures[which(!measures %in% chemblDataset$STANDARD_TYPE)]
    if(length(whichMeasures) == length(measures)){
      stop(paste0("Activity measures informed are not present in the data set: %s", whichMeasures))
    }else{
      warning(paste0("Some activity measures informed are not present in the data set: %s", whichMeasures))
    }
  }
  
  #Keep valid observations
  # - Remove rows where RELATION is different than `=`
  # - The column DATA_VALIDITY_COMMENT must be empty (data is not outside typical range)
  # - Observation has a pCHEMBL value
  # - STANDARD_TYPE is one of "measures"
  cleanDataset <- chemblDataset %>% filter(RELATION == "=", nchar(DATA_VALIDITY_COMMENT) == 0,
                                           !is.na(PCHEMBL_VALUE), STANDARD_TYPE %in% measures)
  
  #Identify duplicated compounds
  # - Calculate standard deviation and median of duplicated compounds
  # - Mark sd > 1 entries to be removed
  groupedDataset <-
    cleanDataset %>% group_by(PARENT_CMPD_CHEMBLID) %>%
    summarise(NUM_COMPOUNDS=n(), STANDARD_DEVIATION=sd(PCHEMBL_VALUE),
              NEW_ACTIVITY_VALUE=median(PCHEMBL_VALUE),
              DUPLICATED=NUM_COMPOUNDS > 1, REMOVE=STANDARD_DEVIATION > 1) %>%
    arrange(desc(REMOVE))
  
  cleanDataset <-
    if(removeDuplicated){
      #Remove entries with large standard deviation and keep only one of the entries in duplicated groups
      merge(cleanDataset, groupedDataset) %>% filter(REMOVE == FALSE | is.na(REMOVE)) %>%
        group_by(PARENT_CMPD_CHEMBLID) %>% slice(1)
    }else{
      merge(cleanDataset, groupedDataset)
    }
  
  cleanDataset$ID <- cleanDataset$PARENT_CMPD_CHEMBLID
  cleanDataset
}