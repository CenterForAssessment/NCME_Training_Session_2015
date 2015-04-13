##  dualTable function for HTML and LaTeX output

dualTable <- function(my_tbl, where="H", caption, css.class = "gmisc_table breakboth", ...) { # , where="!htbp"
  tmp_caption <- tblCap(caption)
  cat("\n<!-- HTML_Start -->\n")
  html.text <- suppressWarnings(cat(htmlTable::htmlTable(my_tbl, title="", caption=tmp_caption, css.class=css.class,...)))
  cat("\n<!-- LaTeX_Start\n")
  latex.text<- print(Hmisc::latex(my_tbl, file="", where=where, caption=tmp_caption, ...))
  cat("\nLaTeX_End -->\n")
}
