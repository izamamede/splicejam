% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jambio-tx.R
\name{jamGeomean}
\alias{jamGeomean}
\title{Modified geometric mean for positive and negative values}
\usage{
jamGeomean(x, na.rm = TRUE, ...)
}
\arguments{
\item{x}{numeric vector which may contain positive and negative values.}

\item{na.rm}{logical indicating whether to ignore \code{NA} values.}

\item{...}{additional parameters are ignored.}
}
\value{
numeric value representing the modified geometric mean
of input values.
}
\description{
Modified geometric mean for positive and negative values
}
\details{
This function calculates a geometric mean using a formula which
tolerates positive and negative values. It also tolerates zeros
without resulting in zero. The intent is to provide
a mean summary value which closely models the classical
geometric mean, while retaining information present in
vectors that contain either zeros or negative values.

The classical geometric mean is defined as
the exponentiated mean of log-transformed values. Said another
way, it is the \code{n}th root of the product of \code{n} numeric values.
This formula is analogous to geometric distance. The formula
does not allow negative values, however, and if any value is
zero the result is also zero.

There are several proposed alternatives to address negative numbers,
or zeros. This function makes the following adjustments:
\itemize{
\item Add \code{1} to absolute value of the input, so the numeric sign
is not flipped during log transformation: \code{i <- log2(1+ abs(x))}
\item Multiply that vector by the \code{sign(x)} to retain the original
positive and negative directionality: \code{j <- i * sign(x)}
\item Take the mean: \code{k <- mean(j)}
\item Exponentiate the absolute value: \code{m <- 2^(abs(k))}
\item Multiply by the sign:
\code{n <- m * sign(k)}
\item Subtract \code{1}: \code{o <- n - 1;}
}

The properties of the calculation:
\itemize{
\item Symmetry around zero, for example \code{jamGeomean(x) = -jamGeomean(-x)}
\item Results are slightly different than classical geometric mean values,
as a result of adding \code{1} prior to log transformation. The difference
is larger with increasing \code{range(x)} and is most noticeable when one
input value in \code{x} is zero.
}
}
\examples{
x <- c(1, 10, 40);
jamGeomean(x);
# compare to classical geometric mean
geomean(x);

# Positive and negative values should offset
x <- c(-20, 20);
jamGeomean(x);

x <- c(-20,10,40);
jamGeomean(x);

}
\seealso{
Other jam numeric functions: 
\code{\link{geomean}()}
}
\concept{jam numeric functions}
