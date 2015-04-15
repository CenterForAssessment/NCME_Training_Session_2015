\name{eqnNumNext}
\alias{eqnNumNext}
\title{Gets the next equation number}
\usage{
eqnNumNext())
}
\arguments{
}
\description{
The function relies on \code{options("equation_counter")} in
order to keep track of the last number.
}
\examples{
options(equation_counter=0)
eqnNumNext()
}
