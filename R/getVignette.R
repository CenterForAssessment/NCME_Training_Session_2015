getVignette <- function(){
file.copy(from=system.file("SGPreports_Vignette", package = "SGPreports"), to=".", recursive = TRUE)
setwd("SGPreports_Vignette")

message(
	"\n\tThe SGPreports_Vignette directory has been downloaded to your original working directory,
	and is now your working directory.  You can open the Vignette_Simple.Rmd and Vignette_Complex_HTML.Rmd
	files to inspect, and the documents can be rendered using the SGPreports functions.  The simple 
	vignette can be used to render all standard output types with this code:
	
			renderMultiDocument(
				rmd_input = 'Vignette_Simple.Rmd',
				output_format=c('HTML', 'EPUB', 'PDF', 'DOCX'),
				bibliography = 'mybibliography.bib',
				pandoc_args = '--webtex'
			)
	
	The second file is only meant to be rendered in HTML. This can be done by either using the 'knit' 
	capabilities in Rstudio (the 'knit' button or Shift+Command/Control+K), or by issuing the 
	following command in the R console:
	
			render('Vignette_Complex_HTML.Rmd')
	
	Note that an internet connection is required for some features (e.g. including images from
	the internet.  If you do not have an internet connection, you will want to remove these sections
	before attempting to render the document(s).")
}