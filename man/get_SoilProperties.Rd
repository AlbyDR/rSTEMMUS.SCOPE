% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_SoilProperties.R
\name{get_SoilProperties}
\alias{get_SoilProperties}
\title{to extract soil properties for point locations (Lat/Lon or sf multipoint object)}
\usage{
get_SoilProperties(
  patch = "D:/model/STEMMUS_SCOPE/input/input_for_input/SoilProperty/",
  lon = NA,
  lat = NA,
  sf_points = NULL
)
}
\arguments{
\item{patch}{the patch to the raster files, default "D:/model/STEMMUS_SCOPE/input/input_for_input/SoilProperty/",}

\item{lat, lon}{the latitude and longitude of the point of interest,}

\item{sf_points}{alternatively a multipoint sf object}
}
\value{
returns list with all soil properties required
}
\description{
\code{get_SoilProperties} returns all soil properties required to run the model.
}
\details{
This is a function to prepare the soil properties to run the set_static_inputs function.
\strong{important} the folder inputs_for_input/SoilProperty with the global data files need to be downloaded.
}
\examples{

Soil_property_loc1 <- get_SoilProperties(patch = "D:/model/STEMMUS_SCOPE/input/input_for_input/SoilProperty/",
                                         lon = 107.688,
                                         lat = 37.829)

}
\seealso{
Other get input parameters: 
\code{\link{get_CanopyHeight}()},
\code{\link{get_SoilInitials}()}
}
\concept{get input parameters}
