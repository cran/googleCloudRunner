if(Sys.getenv("PORT") == "") Sys.setenv(PORT = 8000)

#' @get /
#' @html
function(){
  "<html><h1>It works!</h1></html>"
}


#' @get /hello
#' @html
function(){
  "<html><h1>hello world</h1></html>"
}

#' Echo the parameter that was sent in
#' @param msg The message to echo back.
#' @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#' Plot out data from the iris dataset
#' @param spec If provided, filter the data to only this species (e.g. 'setosa')
#' @get /plot
#' @png
function(spec){
  myData <- iris
  title <- "All Species"

  # Filter if the species was specified
  if (!missing(spec)){
    title <- paste0("Only the '", spec, "' Species")
    myData <- subset(iris, Species == spec)
  }

  plot(myData$Sepal.Length, myData$Petal.Length,
       main = title, xlab = "Sepal Length", ylab = "Petal Length")
}


#' Receive pub/sub message
#' @post /pubsub
#' @param message a pub/sub message
function(message=NULL){

  pub <- function(x) {
    paste("Echo:", x)
    }
  googleCloudRunner::cr_plumber_pubsub(message, pub)

}
