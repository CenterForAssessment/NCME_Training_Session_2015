\name{tblNum}
\alias{tblNum}
\title{Gets the table number}
\usage{
tblNum())
}
\arguments{
}
\description{
The function relies on \code{options("table_counter")} in
order to keep track of the current number.
}
\examples{
org_opts <- options(table_counter=1)
tblNum()
}
