# This script removes some extra code from ggplot-examples-for-instructors.R
# that was used to help create slides to create a cleaner version in
# ggplot-examples.R
# You can safely ignore this file.

x <- readLines("ggplot-examples-for-instructors.R")
x <- x[!grepl("^gs\\(", x)]
x <- x[!grepl("^id <-", x)]
x <- x[!grepl("# delete this line$", x)]
writeLines(x, con = "ggplot-examples.R")
