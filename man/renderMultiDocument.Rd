\name{renderMultiDocument}
\alias{renderMultiDocument}
\title{Render R Markdown in Multiple Output Formats}
\usage{
render(rmd_input, 
  output_formats = c("HTML", "EPUB", "PDF"), 
  cleanup_aux_files = TRUE,
  number_sections = TRUE,
  number_section_depth=3,
  convert_header_levels=c(5,6),
  toc = TRUE,
  toc_depth = 2,
  self_contained = TRUE,
  docx_self_contained = FALSE,
  dev="png",
  html_template = "default",
  epub_template = NULL,
  pdf_template = "default",
  html_css = "default",
  epub_css = "default",
  docx_css = "default",
  cover_img = NULL, 
  add_cover_title = FALSE,
  bibliography = "default",
  csl = "default",
  pandoc_args = NULL,
  ...)
}
\arguments{
  \item{input}{Input file. Must be an R Markdown (.Rmd) file located in the working directory).}

  \item{output_format}{Output format(s) to convert Rmd file to. Pass
  a vector of format names to render multiple formats.  Defaults to the three
  polished versions (c("HTML", "EPUB", "PDF")).  "DOCX" is also available,
  but is intended to be a draft-version document as it does not support many
  of the stylization features included in the other formats.}

  \item{cleanup_aux_files}{Boolean.  Defaults to TRUE to delete the 
  intermediate markdown files and directories be upon successful completion.}
  \item{number_sections}{Boolean. Should sections, subsections, and 
  subsubsections be numbered.  Default \code{TRUE}}
  \item{number_section_depth}{Numeric. Depth of headers to include in 
  section numbering. Default is 3 (subsubsections).}
  \item{convert_header_levels}{Numeric. Markdown header levels 5 and 6 can 
  be used as figure captions in HTML document. These headers are converted 
  back to in image captions for PDF format.}
  \item{toc}{Boolean. \code{TRUE} to include a table of contents in the output}
  \item{toc_depth}{Numeric. Depth of headers to include in table of 
  contents. Default is 2 (subsections).}
 \item{self_contained}{Produce a standalone HTML file with no external
  dependencies, using data: URIs to incorporate the contents of linked
  scripts, stylesheets, images, and videos.}
 \item{docx_self_contained}{Produce a standalone DOCX file with no external
  dependencies.  Allows copy and paste of HTML content to Word document
  without serving the local directory.}
  \item{dev}{Graphics device to use for figure output (defaults to png).}
  \item{html_template}{Pandoc template to use for HTML rendering. Pass "default"
  to use the SGPreports package default template.  Note that if you don't
  use the "default" template then the features of \code{multi_document} 
  won't be available.}
  \item{epub_template}{Pandoc template to use for EPUB rendering. Default is NULL,
  which uses Pandoc's base template.}
  \item{pdf_template}{Pandoc template to use for PDF rendering. Pass "default"
  to use the SGPreports package default template.}
  \item{html_css}{The CSS for HTML format if other than the default within the package.}
  \item{epub_css}{The CSS for EPUB format if other than the default within the package.}
  \item{docx_css}{The CSS for DOCX format if other than the default within the \code{Grmd} package.}
  \item{cover_img}{Directory path for image to use for cover to EPUB document.}
  \item{add_cover_title}{EXPERIMENTAL.  Add the document title and subtitle to the
  EPUB cover image.  Currently set up for only .jpg files and tailored to an image with
  dimensions roughly 2100 x 2800.}
  \item{bibliography}{The LaTeX style bibliography file (.bib, .bibtex, etc.) to include.
  The default file included in the package includes references often used by the author
  and will likely be insufficient for most users.}
  \item{csl}{The CSL (citation style language) to use to format bibliography 
  (if included).  Defaults to APA 5th edition.  See 
  \href{https://github.com/citation-style-language/styles}{this Github repository} 
  for alternatives.  If NULL pandoc's defaults will be used.}
  \item{pandoc_args}{Additional command line options to pass to pandoc}
  \item{...}{Passed onto\code{\link{multi_document}} and/or 
  \code{\link[rmarkdown]{html_document}}.}
}
\value{
  The compiled documents are written into the working directory.  Additional directories
  are created for each of the output formats.
}
\description{
Render the input file to the specified output formats using 
pandoc. If the input requires knitting then
\code{\link[knitr:knit]{knit}} is called prior to pandoc.
}
\details{
This function is a wrapper function that combines calls to \code{\link[rmarkdown]{render}}
and direct \code{system} calls to Pandoc.  The function begins with a rendering of the 
HTML version of the document and saves the markdown file from this rendering and 
uses that as a base from which other formats can be rendered.  Other formats require
specific post-processing, which is also accomplished in the function.
}
\seealso{
\href{http://rmarkdown.rstudio.com/}{Rmarkdown}
\link[knitr:knit]{knit}, \link[rmarkdown]{render},
\href{http://johnmacfarlane.net/pandoc}{pandoc}
}
\examples{
\dontrun{
library(SGPreports)

# Render all four formats.
# Use --webtex to process LaTeX style math equations.

renderMultiDocument("My_Report.Rmd",
                    output_format = c("HTML", "EPUB", "PDF", "DOCX"),
                    cleanup_aux_files = FALSE,
                    pandoc_args = "--webtex")

}
}
\author{
Adam Van Iwaarden
}