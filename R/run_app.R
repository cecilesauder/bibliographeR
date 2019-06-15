#' @export
run_app <- function() {
  appDir <- system.file("shiny-app", "BibliographeR", package = "bibliographeR")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `bibliographeR`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}
