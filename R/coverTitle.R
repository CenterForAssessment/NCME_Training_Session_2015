coverTitle <- function(cover_img, title, subtitle=NULL, out_dir=NULL) {
  img <- readJPEG(cover_img)
  
  ###  Cut the title and subtitles into right sized lines:  titleParse(title)?
  tit.chars <- nchar(title)
  indx <- c(seq(0, tit.chars, 20), tit.chars); tit.lines <- length(indx)-1
  for(j in 2:(length(indx))) assign(paste("t", j-1, sep=""), paste(strsplit(title, " ")[[1]][cumsum(sapply(strsplit(title, " ")[[1]], nchar)) > indx[j-1] & cumsum(sapply(strsplit(title, " ")[[1]], nchar)) <= indx[j]], collapse=" "))
  if (eval(parse(text=paste("1", j-1, sep=""))) == "") {rm(list=paste("1", j-1, sep="")); tit.lines <- tit.lines-1}
  
#   t1 <- paste(strsplit(title, " ")[[1]][cumsum(sapply(strsplit(title, " ")[[1]], nchar)) <= 20], collapse=" ")
#   t2 <- paste(strsplit(title, " ")[[1]][cumsum(sapply(strsplit(title, " ")[[1]], nchar)) > 20], collapse=" ")
  
  if (!is.null(subtitle)) {
    subtit.chars <- nchar(subtitle)
    indx <- c(seq(0, subtit.chars, 25), subtit.chars); subtit.lines <- length(indx)-1
    for(j in 2:(length(indx))) assign(paste("s", j-1, sep=""), paste(strsplit(subtitle, " ")[[1]][cumsum(sapply(strsplit(subtitle, " ")[[1]], nchar)) > indx[j-1] & cumsum(sapply(strsplit(subtitle, " ")[[1]], nchar)) <= indx[j]], collapse=" "))
    if (eval(parse(text=paste("s", j-1, sep=""))) == "") {
      rm(list=paste("s", j-1, sep=""))
      subtit.lines <- subtit.lines-1
    }
#     s1 <- paste(strsplit(subtitle, " ")[[1]][cumsum(sapply(strsplit(subtitle, " ")[[1]], nchar)) <= 25], collapse=" ")
#     s2 <- paste(strsplit(subtitle, " ")[[1]][cumsum(sapply(strsplit(subtitle, " ")[[1]], nchar)) > 25 & cumsum(sapply(strsplit(subtitle, " ")[[1]], nchar)) <= 50], collapse=" ")
#     s3 <- paste(strsplit(subtitle, " ")[[1]][cumsum(sapply(strsplit(subtitle, " ")[[1]], nchar)) > 50], collapse=" ")
  }

  x <- seq(0, attributes(img)$dim[2], len=25)
  y <- seq(0, attributes(img)$dim[1], len=25)
  step <- diff(x)[1]
  xrange <- range(x) + c(-step/2, step/2)
  yrange <- range(y) + c(-step/2, step/2)
  
  xmid <- xrange[2]/2
  if (tit.lines==1)  tit1 <- xrange[2]*0.9 
  if (tit.lines==2){
    tit1 <- xrange[2]*0.975
    tit2 <- xrange[2]*0.875    
  } 
  if (tit.lines==3){
    tit1 <- xrange[2]
    tit2 <- xrange[2]*0.9    
    tit3 <- xrange[2]*0.8    
  } 
  if (tit.lines==4){
    tit1 <- xrange[2]
    tit2 <- xrange[2]*0.95    
    tit3 <- xrange[2]*0.9    
    tit4 <- xrange[2]*0.85    
  } 

  subtit1 <- xrange[2]*0.675
  subtit2 <- xrange[2]*0.6
  subtit3 <- xrange[2]*0.525
  subtit4 <- xrange[2]*0.45
  if (subtit.lines > 4) {
    subtit.lines <- 4
    s4 <- paste(s4, "...")
  }

  if (!is.null(out_dir)) if(strsplit(out_dir, "")[[1]][nchar(out_dir)] != "/") out_dir <- paste(out_dir, "/", sep="")
  
  jpeg(file=paste(out_dir, gsub(" ", "_", title), ".jpeg", sep=""), width = xrange[2], height = yrange[2], quality=100, pointsize=55)
  plot(x, y, xlim=xrange,ylim=yrange, type='n', axes=FALSE, ylab="", xlab="")
  rasterImage(img, xrange[1], yrange[1], xrange[2], yrange[2])
  for(t in 1:tit.lines) {
  	text(xmid, eval(parse(text=paste("tit", t, sep=""))), labels = eval(parse(text=paste("t", t, sep=""))), cex=2.5, font=2)
  }
   # text(xmid, tit.bot, labels = t2, cex=2.5, font=2)
  if (!is.null(subtitle)) {
	  for(s in 1:subtit.lines) {
	  	text(xmid, eval(parse(text=paste("subtit", s, sep=""))), labels = eval(parse(text=paste("s", s, sep=""))), cex=1.75, font=3)
	  }
	  # text(xmid, subtit.top, labels = s1, cex=1.75, font=3)
    # text(xmid, subtit.mid, labels = s2, cex=1.75, font=3)
    # text(xmid, subtit.bot, labels = s3, cex=1.75, font=3)
  }
  dev.off()
}
