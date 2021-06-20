# https://cran.r-project.org/web/packages/zoo/vignettes/zoo.pdf

library(zoo)
set.seed(1071)

# Use ISOdatetime() to generate POSIXct index
z1.index <- ISOdatetime(
  2004, rep(1:2, 5), sample(28, 10, replace = FALSE), 0, 0, 0
)
class(z1.index)
z1.index
z1.data <- rnorm(10)
z1.data
z1 <- zoo(z1.data, z1.index)
class(z1)
z1

# Use as.POSIXct() to generate POSIXct index
z2.index <- as.POSIXct(
  paste(2004, rep(1:2, 5), sample(28, 10, replace = FALSE), sep = "-")
)
class(z2.index)
z2.index
z2.data <- sin(2*1:10/pi)
z2 <- zoo(z2.data, z2.index)
class(z2)
z2

# The object can be a matrix too
Z.index <- as.Date(sample(12450:12500, 10, replace = FALSE))
class(Z.index)
Z.index
Z.data <- matrix(rnorm(30), ncol = 3)
class(Z.data)
Z.data
colnames(Z.data) <- c("Aa", "Bb", "Cc")
Z <- zoo(Z.data, Z.index)
Z

# Duplicated index values?
Z.duplicated.index <- as.Date(sample(12450:12459, 20, replace = TRUE))
Z.duplicated.index
Z.duplicated.data <- matrix(rnorm(20), ncol = 2)
colnames(Z.duplicated.data) <- c("Aa", "Bb")
# Warning when creating the zoo object due to duplicated index
# Warning message:
# In zoo(Z.duplicated.data, Z.duplicated.index) :
#   some methods for “zoo” objects do not work if the index entries in ‘order.by’ are not unique
Z.duplicated <- zoo(Z.duplicated.data, Z.duplicated.index)
Z.duplicated

# aggregate based on index
index(Z)
class(index(Z))
# format() turns Date into character
# ..$ refers to the last 2 characters/digits before the end boundary
firstofmonth <- function(x) as.Date(sub("..$", "01", format(x)))
firstofmonth(index(Z))
aggregate(Z, firstofmonth(index(Z)), mean)

# disaggregation
Nile
# add quarterly dummy entries into yearly data
Nile.na <- merge(
  as.zoo(Nile),
  zoo(order.by = seq(start(Nile)[1], end(Nile)[1], by = 1/4))
)
Nile.na
# impute NA values via linear
head(na.approx(Nile.na))
# last observation carry forward
head(na.locf(Nile.na))
# cubic spline interpolation
head(na.spline(Nile.na))

# rolling functions
Z
is.regular(Z)
?frequency.zoo
zoo:::frequency.zoo(Z)
# By default, by = 1, partial = FALSE, align = "center"
# by: calculate FUN at every by-th time point rather than every point
# partial: if FALSE then FUN is only applied when all indexes of the rolling
#   window are within the observed time range. If TRUE, then the subset of
#   indexes that are in range are passed to FUN.
# align: whether the index of the result should be left- or right-aligned or
#   centered compared to the rolling window of observations
?rollapply
# 2004-02-12 is the "center" of the first full window with 5 observations
# 2004-03-06 is the "center" of the last full window with 5 observations
rollapply(Z, 5, sd)
# for even-number width, the center is the first of the middle two
rollapply(Z, 4, sd)
# number of rows in result = nrow(Z) - (width - 1), if partial = FALSE
rollapply(Z, 5, sd, align = "left")
rollapply(Z, 5, sd, partial = TRUE)
rollapply(Z, 5, sd, partial = TRUE, align = "left")
