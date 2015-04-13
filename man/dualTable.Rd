\name{dualTable}
\alias{dualTable}
\title{Output HTML and LaTeX Tables}
\usage{
dualTable(
    my_tbl, 
    where="H", 
    caption, 
    css.class = "gmisc_table breakboth", 
    ...)
}

\arguments{
  \item{my_tbl}{The matrix/data.frame with the data.}

  \item{...}{Passed on to \code{print.dualTable} function
  and any argument except the \code{useViewer} will be
  passed on to the \code{\link[base]{cat}} functions
  arguments.}

  \item{where}{Passed to \code{\link[Hmisc]{latex}}.  Specifies placement of floats if a table environment is used. Default is  \code{"H"}, which places the table in the exact location it appears in the document. To allow tables to appear in the middle of a page of text you might specify  \code{where="!htbp"} to  \code{latex.default}.}

  \item{caption}{Adds a table caption.}

  \item{css.class}{The html CSS class for the table. This
  allows directing html formatting through
  \href{http://www.w3schools.com/css/css_selectors.asp}{CSS}
  directly at all instances of that class. Default includes 
  \code{breakboth} class.  This inserts a page break before
  and after the table, which prevents tables from being broken
  up between pages when printed from HTML or rendered as
  an EPUB document.}

  \item{...}{Passed onto \code{\link[Grmd]{htmlTable}} and/or
  \code{\link[Hmisc]{latex}}.}
}
\value{
\code{string} Returns a character string containing the text for
both the table to be rendered in HTML or PDF via LaTeX.  String also
contains HTML/Markdown comments to demarcate the location of
the each code type, which is used later for post-processing markdown
text files using  \code{renderMultiDocument}.
}
\description{
This is a function for outputting a more advanced table
than what \pkg{xtable}, \pkg{ztable}, or \pkg{knitr}'s
\code{\link[knitr]{kable}()} allows. It's aim is to provide the
combined functionality of the the \pkg{Hmisc} \code{\link[Hmisc]{latex}()} 
and  \pkg{htmlTable} \code{\link[Grmd]{htmlTable}} . See those
function's documentation for more details.
}

\examples{
# A simple output
output <- matrix(1:4,
                 ncol=2,
                 dimnames = list(list("Row 1", "Row 2"),
                                 list("Column 1", "Column 2")))
dualTable(output)

# An advanced output
output <-
  matrix(ncol=6, nrow=8)

for (nr in 1:nrow(output)){
  for (nc in 1:ncol(output)){
    output[nr, nc] <-
      paste0(nr, ":", nc)
  }
}

dualTable(output, align="r",
          header =  paste(c("1st", "2nd",
                            "3rd", "4th",
                            "5th", "6th"),
                          "hdr"),
          rnames = paste(c("1st", "2nd",
                           "3rd",
                           paste0(4:8, "th")),
                         "row"),
          rgroup = paste("Group", LETTERS[1:3]),
          n.rgroup = c(2,4,nrow(output) - 6),
          cgroup = rbind(c("", "Column spanners", NA),
                         c("", "Cgroup 1", "Cgroup 2&dagger;")),
          n.cgroup = rbind(c(1,2,NA),
                           c(2,2,2)),
          caption="Basic table with both column spanners (groups) and row groups",
          tfoot="&dagger; A table footer commment",
          cspan.rgroup = 2,
          col.columns = c(rep("none", 2),
                          rep("#F5FBFF", 4)),
          col.rgroup = c("none", "#F7F7F7"),
          css.cell = "padding-left: .5em; padding-right: .2em;")

}


