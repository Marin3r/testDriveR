
## dependencies
library(foreign)
library(dplyr)

## code from NORC
read.dct <- function(dct, labels.included = "yes") {
    temp <- readLines(dct)
    temp <- temp[grepl("_column", temp)]
    switch(labels.included,
           yes = {
               pattern <- "_column\\(([0-9]+)\\)\\s+([a-z0-9]+)\\s+(.*)\\s+%([0-9]+)[a-z]\\s+(.*)"
               classes <- c("numeric", "character", "character", "numeric", "character")
               N <- 5
               NAMES <- c("StartPos", "Str", "ColName", "ColWidth", "ColLabel")
           },
           no = {
               pattern <- "_column\\(([0-9]+)\\)\\s+([a-z0-9]+)\\s+(.*)\\s+%([0-9]+).*"
               classes <- c("numeric", "character", "character", "numeric")
               N <- 4
               NAMES <- c("StartPos", "Str", "ColName", "ColWidth")
           })
    temp_metadata <- setNames(lapply(1:N, function(x) {
        out <- gsub(pattern, paste("\\", x, sep = ""), temp)
        out <- gsub("^\\s+|\\s+$", "", out)
        out <- gsub('\"', "", out, fixed = TRUE)
        class(out) <- classes[x] ; out }), NAMES)
    temp_metadata[["ColName"]] <- make.names(gsub("\\s", "", temp_metadata[["ColName"]]))
    temp_metadata
}

read.dat <- function(dat, metadata_var, labels.included = "yes") {
    read.fwf(dat, widths = metadata_var[["ColWidth"]], col.names = metadata_var[["ColName"]])
}


GSS_metadata <- read.dct("gss16.dct")
GSS_ascii <- read.dat("gss16.dat", GSS_metadata)
attr(GSS_ascii, "col.label") <- GSS_metadata[["ColLabel"]]
GSS <- GSS_ascii

## clean up environment
rm(GSS_ascii)
rm(read.dat)
rm(read.dct)

## remove year variable
GSS <- GSS %>%
  select(-YEAR)

## create copy of data
GSS_MISS <- GSS

## code values as missing appropriate
GSS %<>%
  mutate(INCOM16 = ifelse(INCOM16 == -1 | INCOM16 >=7, NA, INCOM16)) %>%
  mutate(SPDEG = ifelse(SPDEG >= 7, NA, SPDEG)) %>%
  mutate(MADEG = ifelse(MADEG >= 7, NA, MADEG)) %>%
  mutate(PADEG = ifelse(PADEG >= 7, NA, PADEG)) %>%
  mutate(DEGREE = ifelse(DEGREE >= 7, NA, DEGREE)) %>%
  mutate(SPWRKSLF = ifelse(SPWRKSLF >= 7, NA, SPWRKSLF)) %>%
  mutate(SPHRS1 = ifelse(SPHRS1 == -1 | SPHRS1 >= 90, NA, SPHRS1)) %>%
  mutate(MARITAL = ifelse(MARITAL >= 7, NA, MARITAL)) %>%
  mutate(WRKSLF = ifelse(WRKSLF >= 7, NA, WRKSLF)) %>%
  mutate(HRS1 = ifelse(HRS1 == -1 | HRS1 >= 90, NA, HRS1)) %>%
  mutate(WRKSTAT = ifelse(WRKSTAT == 9, NA, WRKSTAT)) %>%
  mutate(INCOME16 = ifelse(INCOME16 == 0 | INCOME16 == 27 | INCOME16 == 98, NA, INCOME16))

## create new data frames for saving
gss16 <- GSS
gss16_Miss <- GSS_MISS

## export data objects
save(gss16, file="gss16.RData")
save(gss16_Miss, file="gss16_Miss.RData")
