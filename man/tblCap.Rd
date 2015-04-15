\name{tblCap}
\alias{tblCap}
\title{Returns formated caption with table number}
\usage{
tblCap(caption.text="My table caption is great."))
}
\arguments{
  \item{caption.text}{Text string to be used for caption.}
}
\description{
Returns a formatted markdown text string for the caption, which includes
the table number.  The function relies on \code{options("table_number")} in
order to keep track of the current number.  Also increases the 
table number BEFORE processing the caption using \link{tblNumIncrement}.
}
\examples{
options(table_number=1)
tblCap("My table caption is great.")

# Returns ' **Table 2:**  My table caption is great. '

getOption("table_number")
# Returns '2'
}
