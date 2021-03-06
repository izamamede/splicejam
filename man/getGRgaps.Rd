% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jambio-tx.R
\name{getGRgaps}
\alias{getGRgaps}
\title{Get gaps in GRanges}
\usage{
getGRgaps(gr, strandSpecific = TRUE, verbose = FALSE, ...)
}
\arguments{
\item{gr}{GRanges object}

\item{strandSpecific}{logical indicating whether to convert strand
to \code{"*"} prior to determining gaps between features.}

\item{verbose}{logical indicating whether to print verbose output.}

\item{...}{additional arguments are passed to \code{getGRLgaps()}.}
}
\description{
Get gaps in GRanges
}
\details{
This function returns the gaps between GRanges regions, calculated
for each chromosome (using \code{GenomicRanges::seqnames(gr)}), and when \code{strandSpecific=TRUE}
it determines gaps in stranded fashion.
}
\seealso{
Other jam GRanges functions: 
\code{\link{addGRLgaps}()},
\code{\link{addGRgaps}()},
\code{\link{annotateGRLfromGRL}()},
\code{\link{annotateGRfromGR}()},
\code{\link{assignGRLexonNames}()},
\code{\link{closestExonToJunctions}()},
\code{\link{combineGRcoverage}()},
\code{\link{exoncov2polygon}()},
\code{\link{findOverlapsGRL}()},
\code{\link{getFirstStrandedFromGRL}()},
\code{\link{getGRLgaps}()},
\code{\link{getGRcoverageFromBw}()},
\code{\link{grl2df}()},
\code{\link{make_ref2compressed}()},
\code{\link{sortGRL}()},
\code{\link{spliceGR2junctionDF}()},
\code{\link{stackJunctions}()}
}
\concept{jam GRanges functions}
