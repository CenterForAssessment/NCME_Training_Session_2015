renderPDF <- function (
  input,  # same as rmd_input in renderMultiDocument, or has full YAML
  keep_tex = FALSE, # passed from 'cleanup_aux_files'
  number_sections=TRUE,
  convert_header_levels = c(5,6),
  pdf_template = "default",
  bibliography = "default",
  csl = "default",
  pandoc_args = NULL) {

  ### Initial checks of alternative css and/or pandoc template
  
  ##  Check pandoc template  
  if (pdf_template != "default") {
    if (!file.exists(pdf_template)) {
      stop("The pdf_template file that you've specified can't be found in the file path provided.")
    }
  } else pdf_template <- system.file("rmarkdown", "templates", "multi_document", "resources", "damian.tex" , package = "SGPreports")

  ##  Check csl file  
  if (!is.null(csl)) {
    if (csl != "default") {
      if (!file.exists(csl)) {
        stop("The csl file that you've specified can't be found in the file path provided.")
      } else csl <- paste("--csl", csl)
    } else csl <- paste("--csl", system.file("rmarkdown", "templates", "multi_document", "resources", "apa-5th-edition.csl" , package = "SGPreports"))
  }
  
  ###  pandoc args
  pdf_number_sections <- ifelse(number_sections, "--number-sections", NULL)

  if(!is.null(pandoc_args)){
    if(any(grepl("--highlight-style", pandoc_args))) {
      highlight <- pandoc_args[grepl("--highlight-style", pandoc_args)]
      pandoc_args <- pandoc_args[!grepl("--highlight-style", pandoc_args)]
    } else {
      highlight <- "--highlight-style tango"
    }
    if(any(grepl("--latex-engine", pandoc_args))) {
      latex_engine <- pandoc_args[grepl("--latex-engine", pandoc_args)]
      pandoc_args <- pandoc_args[!grepl("--latex-engine", pandoc_args)]
    } else {
      latex_engine <- "--latex-engine pdflatex"
    }
  } else {
    highlight <- "--highlight-style tango"
    latex_engine <- "--latex-engine pdflatex"
  }
  
  ###
  ###   Create PDF from .md output file
  ###
  
  ###  Get YAML from .Rmd file
  file <- file(file.path(".", input)) # input file
  rmd.text <- rmarkdown:::read_lines_utf8(file, getOption("encoding"))
  # Valid YAML could end in "---" or "..."  - test for both.
  rmd.yaml <- rmd.text[grep("---", rmd.text)[1]:ifelse(length(grep("---", rmd.text))>=2, grep("---", rmd.text)[2], grep("[.][.][.]", rmd.text)[1])]
  close(file)
  
  ##
  ##    Create .md file taylored for conversion to .pdf
  ##
  trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)
  
  input.md <- gsub(".Rmd", ".md", input, ignore.case=TRUE)
  
  dir.create(file.path("PDF", "markdown"), recursive=TRUE, showWarnings=FALSE)
  
  file <- file(file.path("HTML","markdown", input.md))
  md.text <- rmarkdown:::read_lines_utf8(file, getOption("encoding"))
  close(file)
  
  ### Combine rmd.yaml and md.text so that HTML tags get reformated too.
  if (!is.na(start.index <- grep("<!--SGPreport-->", md.text))) {
    md.text <- c(rmd.yaml, md.text[start.index:length(md.text)])
  } else md.text <- c(rmd.yaml, md.text)
  
  for(j in grep("[{]55pt[}]", md.text)) md.text[j] <- gsub(".*[{]55pt[}]", "\\\\begin{equation}", md.text[j])
  for(j in grep("[$][$]", md.text)) md.text[j] <- gsub("[$][$]", "\\\\end{equation}", md.text[j])
  
  for(j in grep("<sup>th</sup>", md.text)) md.text[j] <- gsub("<sup>th</sup>", "$^{th}$", md.text[j])
  for(j in grep("<sup>st</sup>", md.text)) md.text[j] <- gsub("<sup>st</sup>", "$^{st}$", md.text[j])
  for(j in grep("<sup>rd</sup>", md.text)) md.text[j] <- gsub("<sup>rd</sup>", "$^{rd}$", md.text[j])
  for(j in grep("<br></br>", md.text)) md.text[j] <- gsub("<br></br>", "\\\\", md.text[j])
  for(j in grep("<em>", md.text)) md.text[j] <- gsub("<em>", "\\\\emph{", md.text[j])
  for(j in grep("</em>", md.text)) md.text[j] <- gsub("</em>", "}", md.text[j])
  for(j in grep("\\label[{]my[}]", md.text)) {
    md.text[j] <- gsub("[{]my[}]", paste("{table", strsplit(strsplit(md.text[j], "[*][*]Table ")[[1]][2], ":[*][*]")[[1]][1], "}", sep=""), md.text[j])
  }
  for(j in grep("\\caption[{][*][*]Table", md.text)) {
    md.text[j] <- gsub(":[*][*]", ":}", gsub("\\caption[{][*][*]Table", "\\caption*{\\\\textbf{Table", md.text[j]))
  }
  
  ## ztable doesn't have \caption
  for(j in grep("[*][*]Table", md.text)) {
    md.text[j] <- gsub("\\\\end", "}\\\\end", gsub(":[*][*]", ":}", gsub("[*][*]Table", "\\\\caption*{\\\\textbf{Table", md.text[j])))
  }
  
  if (any(grepl("<!-- HTML_Start", md.text))) {
    if (length(grep("<!-- HTML_Start", md.text)) != length(grep("<!-- LaTeX_Start", md.text))){
      stop("There must be equal number of '<!-- HTML_Start' and '<!-- LaTeX_Start' elements in the .Rmd file.")
    }
  }
  while(any(grepl("<!-- HTML_Start", md.text))) {
    html.index <- grep("<!-- HTML_Start", md.text)[1]
    latex.index<- grep("<!-- LaTeX_Start", md.text)[1]
    if (grepl("%", md.text[latex.index+1])) latex.index <- latex.index+1
    md.text <- md.text[-(html.index:latex.index)]
  }
  
  md.text <- gsub("LaTeX_End -->", "", md.text)
  
  ### Use implicit_figures in pandoc - move header (5 & 6) caption titles into markdown position :: i.e. ![{here}](img...)
  for (header.level in rev(convert_header_levels)) {
    header <- paste(paste(rep("#", header.level), collapse=""), "")
    index <- grep(header, md.text)
    
    for (i in index) {
      if(grepl("[[][]]", md.text[i+1])){
        md.text[i+1] <- gsub("[[][]]", paste("[", trimWhiteSpace(gsub(".*:[*][*]", "", gsub(header, "", md.text[i]))), "]", sep=""), md.text[i+1])
        md.text[i] <- ""
      } else {
        if(grepl("[[][]]", md.text[i+2])){
          md.text[i+2] <- gsub("[[][]]", paste("[", trimWhiteSpace(gsub(".*:[*][*]", "", gsub(header, "", md.text[i]))), "]", sep=""), md.text[i+2])
          md.text[i] <- ""
        }}
    }
  }
  
  ###   Write out *-pdf.md tailored file to disk
  pdf_md_path <- file.path("PDF", "markdown", gsub(".md", "-pdf.md", input.md))
  writeLines(md.text, pdf_md_path)
  
  ###
  ### system() call to pandoc
  ###
  
  ### Find pandoc - preference goes to Rstudio version (for now)
  #   my.pandoc <- ifelse(grepl("PANDOC", toupper(Sys.getenv("RSTUDIO_PANDOC"))), Sys.getenv("RSTUDIO_PANDOC"), rmarkdown:::find_program("pandoc"))
  my.pandoc <- rmarkdown:::pandoc()
  my.pandoc_citeproc <- rmarkdown:::pandoc_citeproc()
  
  if(nchar(my.pandoc)==0) stop(
    "The program 'pandoc' was not found. Check 'Sys.getenv(\"RSTUDIO_PANDOC\")'.  If necessary,
      please install pandoc directly or a version of Rstudio (>=v0.98.932) that also contains it.")
  
  ### Bibliography
  if(!is.null(bibliography)) {
    if (bibliography == "default") {
      biblio<-paste("--filter", my.pandoc_citeproc, "--bibliography", 
                    system.file("rmarkdown", "templates", "multi_document", "resources", "educ.bib" , package = "SGPreports"))
    } else {
      if(file.exists(bibliography)) {
        biblio <- paste("--filter", my.pandoc_citeproc, "--bibliography", bibliography)
      } else stop("'bibliography:' file not found.")
    }
  }
                
  message(paste("\n\t Rendering PDF with system call to pandoc:\n\n", 
          my.pandoc,pdf_md_path, "--to latex --from markdown+autolink_bare_uris+ascii_identifiers --output ", file.path("PDF", gsub(".md", ".pdf", input.md, ignore.case=TRUE)), biblio, " ", csl, "--template ", pdf_template,  pdf_number_sections, highlight, latex_engine, pandoc_args, "\n"))
  if(keep_tex) {
  system(paste(my.pandoc, pdf_md_path, "--to latex --from markdown+autolink_bare_uris+ascii_identifiers --output ", file.path("PDF", gsub(".md", ".tex", input.md, ignore.case=TRUE)), biblio, " ", csl, "--template ", pdf_template,  pdf_number_sections, highlight, latex_engine, pandoc_args))
  }
  system(paste(my.pandoc, pdf_md_path, "--to latex --from markdown+autolink_bare_uris+ascii_identifiers --output ", file.path("PDF", gsub(".md", ".pdf", input.md, ignore.case=TRUE)), biblio, " ", csl, "--template ", pdf_template,  pdf_number_sections, highlight, latex_engine, pandoc_args))
}### End renderPDF

