\name{eqnNum}
\alias{eqnNum}
\title{Gets the equation number}
\usage{
eqnNum())
}
\arguments{
}
\description{
The function relies on \code{options("equation_counter")} in
order to keep track of the current number.
}
\examples{
options(equation_counter=1)
eqnNum()
}
