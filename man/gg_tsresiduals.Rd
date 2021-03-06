% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graphics.R
\name{gg_tsresiduals}
\alias{gg_tsresiduals}
\title{Ensemble of time series residual diagnostic plots}
\usage{
gg_tsresiduals(data, ...)
}
\arguments{
\item{data}{A mable containing one model with residuals.}

\item{...}{Additional arguments passed to \code{\link[=gg_tsdisplay]{gg_tsdisplay()}}.}
}
\value{
A list of ggplot objects showing a useful plots of a time series model's residuals.
}
\description{
Plots the residuals using a time series plot, ACF and histogram.
}
\examples{
if (requireNamespace("fable", quietly = TRUE)) {
library(fable)

tsibbledata::aus_production \%>\%
  model(ETS(Beer)) \%>\%
  gg_tsresiduals()
}

}
\references{
Hyndman and Athanasopoulos (2019) \emph{Forecasting: principles
and practice}, 3rd edition, OTexts: Melbourne, Australia.
\url{https://OTexts.org/fpp3/}
}
\seealso{
\code{\link[=gg_tsdisplay]{gg_tsdisplay()}}
}
