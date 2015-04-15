tblNum <- function() {return(getOption("table_number"))}

tblNumNext <- function() {return(getOption("table_number")+1)}

tblNumIncrement <- function() {options("table_number" = getOption("table_number")+1); return(getOption("table_number"))}

tblCap <- function(caption.text) {
  tblNumIncrement()
  return(paste("**Table ", getOption("table_number"), ":** ", caption.text, sep=""))
}

tblCap_NO_Increment <- function(caption.text) {
  return(paste("**Table ", getOption("table_number"), ":** ", caption.text, sep=""))
}

tblCapNULL <- function() {
  options("table_number" = getOption("table_number")+1)
  return(NULL)
}

eqnNumNext <- function() {options("equation_counter" = getOption("equation_counter")+1); return(getOption("equation_counter"))}

eqnNum <- function(eqn.name="t1", em.space=150) {
  if (!is.null(eqn.name)) assign(eqn.name, eqnNumNext(), envir=.GlobalEnv) else eqnNumNext()
  return(cat('\\hspace{', em.space, 'em} \\text{(', getOption('equation_counter'), ')}', sep=""))
}

