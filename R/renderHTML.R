renderHTML <- function (
  input,
  number_sections = TRUE,
  number_section_depth=3,
  toc = TRUE,
  toc_depth = 2,
  self_contained = TRUE,
  dev="png",
  html_template = "default",
  html_css = "default",
  bibliography = "default",
  csl = "default",
  pandoc_args = NULL, ...) {
  
  ### Initial checks of alternative css and/or pandoc template
  
	##  CSS check from Grmd::docx_document - credit to Max Gordon/Gforge https://github.com/gforge
	if (html_css != "default") {
		if (!all(sapply(html_css, file.exists))) {
			alt_html_css <- list.files(pattern = ".css$")
			if (length(alt_html_css) > 0) {
				alt_html_css <- paste0("\n You do have alternative file name(s) in current directory that you may intend to use.", 
															 " You may want to have a YAML section that looks something like:", 
															 "\n---", "\noutput:", "\n  SGPreports::multi_document:", 
															 "\n    html_css: \"", paste(alt_html_css, collapse = "\", \""), 
															 "\"", "\n---")
			} else {
				alt_html_css <- ""
			}
			stop("One or more of the css-file(s) that you've specified can't be identified.", 
					 "The file(s) '", paste(html_css[!sapply(html_css, file.exists)], 
					 											 collapse = "', '"), "'", " can't be found in the file path provided.")
		}
	} else html_css <- system.file("rmarkdown", "templates", "multi_document", "resources", "report.css" , package = "SGPreports")
	if (any(html_css != "-default")) {
		html_css <- c(html_css, system.file("rmarkdown", "templates", "multi_document", "resources", "report.css" , package = "SGPreports"))
	}
		
  ### Check pandoc template
  
	if (html_template != "default") {
		if (!file.exists(html_template)) {
			stop("The html_template file that you've specified can't be found in the file path provided.")
		}
	} else html_template <- system.file("rmarkdown", "templates", "multi_document", "resources", "report.html" , package = "SGPreports")

	### Bibliography
	
	if (!is.null(bibliography)) {
		my.pandoc_citeproc <- rmarkdown:::pandoc_citeproc()
		if (bibliography == "default") {
			pandoc_args <-c(pandoc_args, "--filter", my.pandoc_citeproc, "--bibliography", 
											system.file("rmarkdown", "templates", "multi_document", "resources", "educ.bib" , package = "SGPreports"))
			bibliography <- NULL
		} else {
			if(file.exists(bibliography)) {
				pandoc_args <-c(pandoc_args, "--filter", my.pandoc_citeproc, "--bibliography", bibliography)
				bibliography <- NULL
			} else stop("'bibliography' file not found.")
		}
	}
	
	##  Check csl file  
	if (!is.null(csl)) {
		if (csl != "default") {
			if (!file.exists(csl)) {
				stop("The csl file that you've specified can't be found in the file path provided.")
			} else {
				pandoc_args <- c(pandoc_args, "--csl", csl) # Use pandoc_args here since docx_document passes that to html_document
				csl <- NULL
			}
		} else {
			pandoc_args <- c(pandoc_args, "--csl", system.file("rmarkdown", "templates", "multi_document", "resources", "apa-5th-edition.csl" , package = "SGPreports"))
			csl <- NULL
		}
	}

	###
  ###  Render HTML (and master .md file)
  ###
  
	message("\n\t Rendering HTML with call to render(... multi_document):\n")
	
	render(input, 
  			 multi_document(..., # passed args to rmarkdown::html_document
  			 				number_sections=number_sections, number_section_depth=number_section_depth, toc=toc, toc_depth=toc_depth,
  			 				self_contained=self_contained, dev=dev, template=html_template, css=html_css, 
  			 				bibliography=bibliography, csl=csl, pandoc_args=pandoc_args),
  			     output_dir=file.path(".", "HTML"))
	
	### Move "master" .md file to HTML/markdown directory
	dir.create(file.path("HTML", "markdown"), showWarnings=FALSE)
	file.copy(file.path("HTML", gsub(".Rmd", ".md", input, ignore.case=TRUE)), file.path("HTML", "markdown"), overwrite=TRUE)
	file.remove(file.path("HTML", gsub(".Rmd", ".md", input, ignore.case=TRUE)))
	
  return(NULL)
}### End renderMultiDocument

