\name{tblNumNext}
\alias{tblNumNext}
\title{Gets the next table number}
\usage{
tblNumNext())
}
\arguments{
}
\description{
The function relies on \code{options("table_counter")} in
order to keep track of the last number.
}
\examples{
org_opts <- options(table_counter=1)
tblNumNext()
options(org_opts)
}
