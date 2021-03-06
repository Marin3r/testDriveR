#' Model Year 2017 Vehicles
#'
#' A data set containing model year 2017 vehicles for sale in the United States.
#'
#' @docType data
#'
#' @usage data(auto17)
#'
#' @format A data frame with 1216 rows and 21 variables:
#' \describe{
#'   \item{id}{DOT vehicle ID number}
#'   \item{mfr}{vehicle manufacturer}
#'   \item{mfrDivision}{vehicle brand}
#'   \item{carLine}{vehicle name}
#'   \item{carClass}{vehicle type, numeric}
#'   \item{carClassStr}{vehicle type, string}
#'   \item{cityFE}{fuel economy, city}
#'   \item{hwyFE}{fuel economy, highway}
#'   \item{combFE}{fuel economy, combined}
#'   \item{guzzlerStr}{poor fuel economy}
#'   \item{fuelStr}{fuel, abbrev.}
#'   \item{fuelStr2}{fuel, full}
#'   \item{fuelCost}{estimated fuel cost}
#'   \item{displ}{engine displacement}
#'   \item{transStr}{tarnsmission, full}
#'   \item{transStr2}{transmission, abbrev.}
#'   \item{gears}{number of gears}
#'   \item{cyl}{number of cylinders}
#'   \item{airAsp}{air aspiration method}
#'   \item{driveStr}{vehicle drive type, abbrev.}
#'   \item{driveStr2}{vehicle drive type, full}
#' }
#'
#' @source https://www.fueleconomy.gov/feg/download.shtml
#'
#' @examples
#' str(auto17)
#' head(auto17)
#'
"auto17"
