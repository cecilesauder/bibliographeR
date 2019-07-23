#' Get ID (or PMID) from a query to NCBI
#'
#' @param query a query to enter in NCBI
#' @param retmax the maximum number of results (default = 1000)
#'
#' @return a vector with ids
#' @export
#'
#' @examples
#' get_ids("oyster herpesvirus")
get_ids <- function(query, retmax = 1000){
  query_search <- rentrez::entrez_search(db = "pubmed", term = query, retmode = "xml" , retmax = retmax)
  query_search$ids
}

#' Get XML code from NCBI giving a ids vector
#'
#' @param ids a vector with articles ids (PMID)
#'
#' @import magrittr
#'
#' @return a character with XML code
#' @export
#'
get_xml <- function(ids){
  rentrez::entrez_fetch(db = "pubmed", id = ids, rettype = "xml")
}

#' Get a variable from XML
#' variables availables are "title", "authors", "year", "journal", "volume", "issue", "pages", "key_words", "doi", "pmid", "abstract"
#'
#' @import magrittr
#'
#' @param xml a character with XML code
#' @param what the name of the variable you want
#'
#' @return a list with all the "variable selected" for all the articles in the XML
#' @export
#'
get_from_xml <- function(xml, what = "title"){
  if (!is_character(what)) {
    stop("'what' must be a character")
  }
  rentrez::parse_pubmed_xml(xml) %>%
    purrr::map(what)
}

#' Make a data frame with ID and an other variable of interest ("title", "authors", "year", "journal", "volume", "issue", "pages", "key_words", "doi", "pmid", "abstract")
#'
#' @import magrittr
#'
#' @param xml a character with XML code
#' @param var the name of the variable you want
#'
#' @return a tibble with 2 columns, id and "variable selected"
#' @export
#'
make_df <- function(xml, var){
  tib <- dplyr::tibble(pmid = get_from_xml(xml, "pmid") %>% purrr::flatten_chr(), var = get_from_xml(xml, var)) %>% dplyr::na_if("NULL") %>% tidyr::unnest()
  names(tib) <- c("id", var)
  tib
}
