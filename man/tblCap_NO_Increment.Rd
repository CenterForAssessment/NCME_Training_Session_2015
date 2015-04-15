\name{tblCap_NO_Increment}
\alias{tblCap_NO_Increment}
\title{Returns formated caption with table number}
\usage{
tblCap_NO_Increment(caption.text="My table caption is great."))
}
\arguments{
  \item{caption.text}{Text string to be used for caption.}
}
\description{
Returns a formatted markdown text string for the caption, which includes
the table number.  The function relies on \code{options("table_number")} in
order to keep track of the current number.  Does not increase the 
current table number, making it different than \link{tblCap}.
}
\examples{
options(table_number=1)
tblCap_NO_Increment("My table caption is great.")

# Returns **Table 1:**  My table caption is great.

getOption("table_number")
# Returns '1'
}
