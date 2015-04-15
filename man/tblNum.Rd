\name{tblNum}
\alias{tblNum}
\title{Gets the table number}
\usage{
tblNum())
}
\arguments{
}
\description{
The function relies on \code{options("table_number")} in
order to keep track of the current number.
}
\examples{
options(table_number=1)
tblNum()
}
