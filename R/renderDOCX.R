renderDOCX <- function(
  input,  # same as rmd_input in renderMultiDocument, or has full YAML
  self_contained = FALSE,
  number_sections = TRUE,
  number_section_depth = 3,
  docx_css = "default",
  bibliography = "default",
  csl = "default",
  pandoc_args = NULL) {
  
  ### Create DOCX directory right away so that we can copy css to it.
  dir.create(file.path("DOCX", "markdown"), recursive=TRUE, showWarnings=FALSE)
  
  ### Initial checks of alternative css
  ##  CSS check from Grmd::docx_document - credit to Max Gordon/Gforge https://github.com/gforge

  if (docx_css != "default") {
    if (!all(sapply(docx_css, file.exists))) {
      alt_docx_css <- list.files(pattern = ".css$")
      if (length(alt_docx_css) > 0) {
        alt_docx_css <- paste0("\n You do have alternative file name(s) in current directory that you may intend to use.", 
                               " You may want to have a YAML section that looks something like:", 
                               "\n---", "\noutput:", "\n  SGPreports::multi_document:", 
                               "\n    docx_css: \"", paste(alt_docx_css, collapse = "\", \""), 
                               "\"", "\n---")
      } else {
        alt_docx_css <- ""
      }
      stop("One or more of the css-file(s) that you've specified can't be identified.", 
           "The file(s) '", paste(docx_css[!sapply(docx_css, file.exists)], 
                                  collapse = "', '"), "'", " can't be found in the file path provided.")
    }
  } else {
    docx_css <- system.file("rmarkdown", "docx.css", package = "Grmd") # default for docx_document
  }
  
  tmp_render_dir <- ifelse(self_contained, file.path("DOCX", "markdown"), "DOCX")
  file.copy(from = docx_css, to = ".", overwrite = TRUE)
  file.copy(from = docx_css, to = tmp_render_dir, overwrite = TRUE)
  docx_css <- "docx.css"
  
  if (self_contained)  file.copy("img/", tmp_render_dir, recursive = TRUE)
  
  ##  Check csl file  
  if (!is.null(csl)) {
    if (csl != "default") {
      if (!file.exists(csl)) {
        stop("The csl file that you've specified can't be found in the file path provided.")
      } else pandoc_args <- c(pandoc_args, "--csl", csl) # Use pandoc_args here since docx_document passes that to html_document
    } else pandoc_args <- c(pandoc_args, "--csl", system.file("rmarkdown", "templates", "multi_document", "resources", "apa-5th-edition.csl" , package = "SGPreports"))
  }
  
  ###
  ###   DOCX Drafts
  ###

  input.md <- gsub(".Rmd", ".md", input, ignore.case=TRUE)
  
  ###  pandoc args
  
  if(!is.null(pandoc_args)){
    if(any(grepl("--highlight-style", pandoc_args))) {
      highlight <- pandoc_args[grepl("--highlight-style", pandoc_args)]
      pandoc_args <- pandoc_args[!grepl("--highlight-style", pandoc_args)]
    } else {
      highlight <- "--highlight-style pygments"
    }
  }  
  
  ###  Get YAML from .Rmd file
  file <- file(input) # input file
  rmd.text <- rmarkdown:::read_lines_utf8(file, getOption("encoding"))
  close(file)
  # Valid YAML could end in "---" or "..."  - test for both.
  rmd.yaml <- rmd.text[grep("---", rmd.text)[1]:ifelse(length(grep("---", rmd.text))>=2, grep("---", rmd.text)[2], grep("[.][.][.]", rmd.text)[1])]
  
  if (any(grepl("output:", rmd.yaml))) docx.rmd.yaml <- c(rmd.yaml[1:(grep("output:", rmd.yaml)-1)], "---") else docx.rmd.yaml <- rmd.yaml

  ###  Get .md file rendered from .rmd for html output
  file <- file(file.path("HTML", "markdown", input.md))
  md.text <- rmarkdown:::read_lines_utf8(file, getOption("encoding"))
  close(file)
  
  if (any(grepl("<!-- HTML_Start", md.text))) {
    if (length(grep("<!-- HTML_Start", md.text)) != length(grep("<!-- LaTeX_Start", md.text))){
      stop("There must be equal number of '<!-- HTML_Start' and '<!-- LaTeX_Start' elements in the .Rmd file.")
    }
  }
  
  while(any(grepl("<!-- LaTeX_Start", md.text))) {
    latex.start<-grep("<!-- LaTeX_Start", md.text)[1]
    latex.end <- grep("LaTeX_End -->", md.text)[1]
    md.text <- md.text[-(latex.start:latex.end)]
  }
  
  if (!is.na(start.index <- grep("<!--SGPreport-->", md.text))) {
    md.text <- c(docx.rmd.yaml, md.text[(start.index-1):length(md.text)])
  } else md.text <- c(docx.rmd.yaml, md.text)

  ### Clean out remaining HTML/markdown comments
  while(any(grepl("<!--", md.text))) {
    comment.start<-grep("<!--", md.text)[1]
    comment.end <- grep("-->", md.text)[1]
    md.text <- md.text[-(comment.start:comment.end)]
  }
  
  writeLines(md.text, file.path("DOCX", "markdown", gsub(".md", "-docx.md", input.md, ignore.case=TRUE)))

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
        file.copy(from = bibliography, to = file.path("DOCX", "markdown"), overwrite = TRUE)
        file.copy(from = bibliography, to = tmp_render_dir, overwrite = TRUE)
        bibliography <- NULL
      } else stop("'bibliography' file not found.")
    }
  }
  
  message("\n\t Rendering DOCX with call to render(... Grmd::docx_document):\n")
  
  render(file.path("DOCX", "markdown", gsub(".md", "-docx.md", input.md, ignore.case=TRUE)),
         Grmd::docx_document(self_contained = self_contained, css=docx_css, number_sections=number_sections, pandoc_args=pandoc_args), output_dir="..")

  file <- file(file.path("DOCX", gsub(".md", "-docx.html", input.md, ignore.case=TRUE)))
  html.text <- readLines(file)

  for (header.level in (which(1:6 > number_section_depth))) {
    index <- grep(paste("<h", header.level, sep=""), html.text)
    for (i in index) {
      if (grepl("header-section-number", html.text[i])) {
        html.text[i] <- paste("<h", gsub(".*<h|><span.*", "", html.text[i]), ">",gsub("<span.*|.*span>", "", html.text[i]), sep="")
      }
    }
  }
  
  for(j in grep("↩", html.text)) html.text[j] <- gsub("↩", "", html.text[j])

  writeLines(html.text, file)
  close(file)

  file.copy("img", "DOCX", recursive = TRUE)
  if (self_contained)  unlink(file.path(tmp_render_dir, "img"), recursive = TRUE)
}  # End 'renderDOCX' function
