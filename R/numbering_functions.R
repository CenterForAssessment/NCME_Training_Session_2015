tblNum <- function() {return(getOption("table_counter"))}

tblNumNext <- function() {return(getOption("table_counter")+1)}

tblNumIncrement <- function() {options("table_counter" = getOption("table_counter")+1); return(getOption("table_counter"))}

tblCap <- function(caption.text) {
  tblNumIncrement()
  return(paste("**Table ", getOption("table_counter"), ":** ", caption.text, sep=""))
}

tblCap_NO_Increment <- function(caption.text) {
  return(paste("**Table ", getOption("table_counter"), ":** ", caption.text, sep=""))
}

tblCapNULL <- function() {
  options("table_counter" = getOption("table_counter")+1)
  return(NULL)
}

eqnNumNext <- function() {options("equation_counter" = getOption("equation_counter")+1); return(getOption("equation_counter"))}

eqnNum <- function(eqn.name="t1", em.space=150) {
  if (!is.null(eqn.name)) assign(eqn.name, eqnNumNext(), envir=.GlobalEnv) else eqnNumNext()
  return(cat('\\hspace{', em.space, 'em} \\text{(', getOption('equation_counter'), ')}', sep=""))
}

