% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jambio-tx.R
\name{tx2ale}
\alias{tx2ale}
\title{tx2ale: detect alternative last exons (ALE) from transcript data}
\usage{
tx2ale(
  gtf = NULL,
  txdb = NULL,
  threeUtrGRL = NULL,
  detectedTx = NULL,
  tx2geneDF = NULL,
  iMatrix = NULL,
  aleMethod = c("first", "range"),
  verbose = FALSE,
  ...
)
}
\arguments{
\item{gtf}{character path to a GTF file, used to import gene models
using Bioconductor \code{GenomicFeatures::makeTxDbFromGFF()}
to create a transcriptDb object. If supplied, and if \code{tx2geneDF}
is NULL, then \code{tx2geneDF} will be created using
\code{makeTx2geneFromGtf}.}

\item{txdb}{a \code{TxDb} object as defined by Bioconductor
package \code{GenomicFeatures}. Note that when reloading an R session,
these objects usually become defunct, since they refer internally to
a sqlite database stored in a temporary file. Therefore, when saving
and reloading an R session, it is recommended to use the relevant
functions \code{AnnotationDbi::saveDb} and
\code{AnnotationDbi::loadDb}.}

\item{threeUtrGRL}{GRangesList object of 3'UTR exons by transcript, whose
names are available in the \code{tx2geneDF} data.frame with colname
\code{transcript_id}.}

\item{detectedTx}{optional character vector of transcripts detected,
whose values match the transcript names in \code{gtf}, \code{txdb},
\code{threeUtrGRL}, and/or \code{tx2geneDF} as relevant to the
supplied input data.}

\item{tx2geneDF}{optional data.frame with colnames \code{gene_id} and
\code{transcript_id} which are used to relate transcripts to genes.
If either \code{gtf} or \code{txdb} are supplied, this data.frame
can be determined from that data.}

\item{iMatrix}{optional numeric matrix of transcript rows, and sample
columns, containing expression abundance data. When supplied, a
matrix will be created \code{iMatrixByALE} where the transcript
abundance values have been aggregated per ALE as defined.}

\item{aleMethod}{character value describing the method used to define
ALE regions.}

\item{verbose}{logical whether to print verbose output during processing.}
}
\value{
aleGRL GRangesList object containing the ALE ranges after
processing. Compare to transcript models to see if 3'UTR regions have
been properly handled.

multiALEgenes vector of gene_name values which contain multiple
ALEs after processing.

tx2ale vector containing ALE_name values, named by transcript_id,
used to aggregate per-transcript data into per-ALE data.

iMatrixByALE optional data matrix created only if iMatrix was
supplied as input. The data matrix rows are ALE_name values after
aggregating transcripts into ALEs. Note that only multi-ALE genes
are included, all single-ALE genes are excluded.
}
\description{
detect alternative last exons (ALE) from transcript data
}
\details{
This function is intended to encapsulate logic used to define
alternative last exons (ALE) based upon gene-transcript models.
Specifically, it uses either the 5' end of all 3'UTR regions
\code{aleMethod="first"}, or the full 3'UTR range
\code{aleMethod="range"}, optionally using only detected transcripts
if given by \code{detectedTx}. Any transcripts overlapping the criteria
above are merged together by gene, to define a unique set of
ALEs for each gene.

Note that when using \code{aleMethod="first"},
3'UTRs will be combined if the 5'end of the
3'UTR is identical, which means the length of the 3'UTR is not considered
in terms of defining an ALE. The goal is to determine whether the ALE is
or is not maintained during transcript processing.

Note that when using \code{aleMethod="range"}, 3'UTRs are converted first
to a range, which converts multi-exon 3'UTRs to the full range covered by
the 3'UTR exons, and not specific exon ranges contained. It is mainly
intended to focus on the specific scenario where alternative 3'UTRs for
a give gene do not overlap in any way. In reality, several sources of
GTF gene models showed unusual transcript isoforms that contained premature
stop codons, thus annotating the remaining exons all as "3'UTR" and
therefore causing all subsequent 3'UTR regions to be combined into one
large spanning range. For this reason, we recommend using
\code{aleMethod="first"} by default.

We noted substantially improved results when supplying detected transcripts
via the parameter \code{detectedTx}, which greatly reduces the full set of
possible ALE regions to use only those regions relevant and observed in the
given RNA-seq dataset. In other words, there are a large number of possible
ALE regions which have no supporting measured data in a particular RNA-seq
experiment. It is possible that generating a superset of ALE regions
may not be practically problematic in downstream analysis steps, however
the impact may be seen predominantly during fase discovery rate (FDR)
adjustment for multiple testing, especially if over half the annotated
ALE regions have zero reported measurements. If they have no supporting
measurements, they are effectively not being tested. As GTF files become
increasingly annotated to cover every possible scenario, this issue is
likely to become more impactful over time.

Input data can be in one of three forms:
\itemize{
\item \code{gtf} a GTF file such as those GTF files provided by Gencode
\item \code{txdb} a TxDb R object as produced by the Bioconductor
package \code{GenomicFeatures}, suitable for use in calling
\code{GenomicFeatures::threeUTRsByTranscript()}
\item \code{threeUtrGRL} a \code{GenomicRanges::GRangesList} object
which is a list of 3'UTR exons by transcript. This input also requires
\code{tx2geneDF} which is used to relate transcripts to genes.
}

Two important outputs are \code{tx2ale} which converts transcripts to
ALE names, and if a matrix of transcript expression is supplied with
\code{iMatrix}, then \code{iMatrixByALE} is a matrix of expression
aggregated at the ALE level, suitable for differential testing in
\code{limma::diffSplice()} or \code{DEXSeq}.

This function depends upon custom functions: \code{annotateGRLfromGRL()},
\code{annotateGRfromGR()}, and \code{assignGRLexonNames()}.
}
\seealso{
Other jam ALE-specific RNA-seq functions: 
\code{\link{ale2violin}()},
\code{\link{getFirstStrandedFromGRL}()}
}
\concept{jam ALE-specific RNA-seq functions}
