\name{tblNumIncrement}
\alias{tblNumIncrement}
\title{Increase the table number counter}
\usage{
tblNumIncrement())
}
\arguments{
}
\description{
Bump the table number by one.  The function relies 
on \code{options("table_counter")} in order to keep track of the last number.
}
\examples{
options(table_counter=1)
getOption("table_counter")
tblNumIncrement()
getOption("table_counter")
}
