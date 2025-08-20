# app.R
library(plumber)

port <- Sys.getenv("PORT", unset = "8000")  
pr <- plumb("plumber.R")
pr$run(host = "0.0.0.0", port = as.numeric(port))
