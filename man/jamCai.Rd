% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jambio-tx.R
\name{jamCai}
\alias{jamCai}
\title{Calculate Codon Adaptation Index}
\usage{
jamCai(x, codonDF, ...)
}
\arguments{
\item{x}{character vector containing DNA or RNA sequence, intended
to include amino acid codons in frame beginning with the first
character. It is sent to \code{dna2codon()} which creates a character
vector whose elements all contain three characters. The input
\code{x} represents sequence data for one protein-coding transcript
sequence.}

\item{codonDF}{data.frame containing amino acid codons per row,
with colname \code{"codon"} containing three-character codon sequences,
and colname \code{"multifreq"} containing the relative frequency
versus max of codon use per amino acid, as produced by
\code{codonUsage2df()}.}

\item{...}{additional arguments are ignored.}
}
\value{
numeric vector with length \code{length(x)}, named with
\code{names(x)} containing codon adaptation index (cai) values
equivalent to those produced by \code{seqinr::cai()}.
}
\description{
Calculate Codon Adaptation Index
}
\details{
This function is equivalent to \code{seqinr::cai()} except that it
runs in vectorized form and is markedly more efficient.
}
\seealso{
Other jam codon usage functions: 
\code{\link{codonUsage2df}()},
\code{\link{dna2codon}()}
}
\concept{jam codon usage functions}
