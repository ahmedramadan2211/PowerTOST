\encoding{utf-8}
\name{sampleN.RSABE}
\alias{sampleN.RSABE}
\title{
Sample size estimation for BE decision via linearized scaled ABE criterion
}
\description{
This function performs the sample size estimation for the BE decision via 
linearized scaled ABE criterion based on simulations.
}
\usage{
sampleN.RSABE(alpha = 0.05, targetpower = 0.8, theta0, theta1, theta2, CV,
              design = c("2x3x3", "2x2x4", "2x2x3"), regulator = c("FDA", "EMA"),
              nsims = 1e+05, nstart, imax=100, print = TRUE,
              details = TRUE, setseed=TRUE)
}
\arguments{
  \item{alpha}{
Type I error probability. Per convention mostly set to 0.05.
}
  \item{targetpower}{
Power to achieve at least. Must be >0 and <1.\cr
Typical values are 0.8 or 0.9.
}
  \item{theta0}{
\sQuote{True} or assumed T/R ratio. \cr
Defaults to 0.90 according to the two \enc{Lászlós}{Laszlos} if not given explicitly.
}
  \item{theta1}{
Conventional lower ABE limit to be applied in the mixed procedure if 
\code{CVsWR <= CVswitch}.\cr
Also Lower limit for the point estimate constraint.\cr
Defaults to 0.8 if not given explicitly.
}
  \item{theta2}{
Conventional upper ABE limit to be applied in the mixed procedure if 
\code{CVsWR <= CVswitch}. Also upper limit for the point estimate constraint.\cr
Defaults to 1.25 if not given explicitly.
}
  \item{CV}{
Intra-subject coefficient(s) of variation as ratio (not percent).
  \itemize{
    \item If given as a scalar (\code{length(CV)==1}) the \emph{same} CV of Test
          and Reference is assumed (homoscedasticity, \code{CVwT==CVwR}).
    \item If given as a vector (\code{length(CV)==2}), \emph{i.e.}, assuming
          heteroscedasticity, the CV of the Test \strong{must} be given in 
          \code{CV[1]} and the one of the Reference in the \code{CV[2]}.
  }
}
  \item{design}{
Design of the study to be planned.\cr
\code{"2x3x3"} is the partial replicate design.\cr
\code{"2x2x4"} is a full replicate design with 2 sequences and 4 periods.\cr
\code{"2x2x3"} is a full replicate design with 2 sequences and 3 periods.\cr
Defaults to \code{design="2x3x3"}. Details are given the section about Designs.
}
  \item{regulator}{
Regulatory body settings for the scaled ABE criterion.\cr
Defaults to \code{design="FDA"}.\cr
Also the scaled ABE criterion is usually calculated with the FDA constant\cr
\code{r_const=log(1.25)/0.25} you can override this behavior to use the EMA setting
\code{r_const=0.76} to avoid the discontinuity at CV=30\% and be more stringent.
}
  \item{nsims}{
Number of simulations to be performed to obtain the (empirical) power.
}
  \item{nstart}{
Set this to a start for the sample size search if a previous run failed.\cr
After reworking the start n in version 1.1-05 rarely needed.
}
  \item{imax}{
Maximum number of steps in sample size search. Defaults to 100.
}
  \item{print}{
If \code{TRUE} (default) the function prints its results. If \code{FALSE} only the result data.frame will be returned. 
}
  \item{details}{
If set to \code{TRUE}, the default, the steps during sample size search are shown.
}
  \item{setseed}{
Simulations are dependent on the starting point of the (pseudo) random number 
generator. To avoid differences in power for different runs a \code{set.seed(123456)} 
is issued if \code{setseed=TRUE}, the default. 
}
}
\details{
The linearized scaled ABE criterion is calculated according to the SAS code
given in the FDA progesterone guidance.\cr\cr
The simulations are done via the distributional properties of the statistical
quantities necessary for deciding BE based on scaled ABE.\cr
For more details see a document \verb{Implementation_scaledABE_simsVx.yy.pdf} in the \code{/doc} sub-directory of 
the package.\cr\cr
If a CVcap is defined for the regulator, the BE decision is based on the inclusion
of the CI in the capped widened acceptance limits in case of CVwR > CVcap. This
resembles method \sQuote{Howe-EMA} in \enc{Muñoz}{Munoz} \emph{et al.} and is the standard behavior now if
\code{regulator="EMA"} is choosen.\cr\cr
The estimated sample size gives always the \emph{total} number of subjects (not subject/sequence -- like in some other software packages).
}
\value{
Returns a data.frame with the input and sample size results.\cr
The \code{Sample size} column contains the total sample size.\cr
The \code{nlast} column contains the last \code{n} value. May be useful for restarting.
}
\references{
Food and Drug Administration, Office of Generic Drugs (OGD). \emph{Draft Guidance on Progesterone.} Recommended Apr 2010. Revised Feb 2011. \href{https://www.accessdata.fda.gov/drugsatfda_docs/psg/Progesterone_caps_19781_RC02-11.pdf}{download}

\enc{Tóthfalusi}{Tothfalusi}, L, \enc{Endrényi}{Endrenyi}, L. \emph{Sample Sizes for Designing Bioequivalence Studies for Highly Variable Drugs.} J Pharm Pharmaceut Sci. 2011;15(1):73--84. 
\href{https://ejournals.library.ualberta.ca/index.php/JPPS/article/download/11612/9489}{open access}

\enc{Tóthfalusi}{Tothfalusi} L, \enc{Endrényi}{Endrenyi} L, \enc{García}{Garcia} Arieta A. \emph{Evaluation of Bioequivalence for Highly Variable Drugs with Scaled Average Bioequivalence.} Clin Pharmacokin. 2009;48(11):725--43. \doi{10.2165/11318040-000000000-00000}

\enc{Muñoz}{Munoz} J, Alcaide D, \enc{Ocaña}{Ocana} J. \emph{Consumer’s risk in the EMA and FDA regulatory approaches for bioequivalence in highly variable drugs.} Stat Med. 2015;35(12):1933--43. \doi{10.1002/sim.6834}
}
\author{
D. Labes
}
\note{
The sample size estimation is done only for balanced designs since the 
break down of the total subject number in case of unbalanced sequence groups
is not unique. Moreover the formulas used are only for balanced designs.\cr
The minimum sample size is n=6, even if the power is higher than the intended 
targetpower.
}
\section{Designs}{
Although some designs are more \sQuote{popular} than others, sample size estimations are valid for \emph{all} of the following designs:
  \tabular{ll}{
    \code{"2x2x4"} \tab TRTR | RTRT\cr
    \tab TRRT | RTTR\cr
    \tab TTRR | RRTT\cr
    \code{"2x2x3"} \tab TRT | RTR\cr
    \tab TRR | RTT\cr
    \code{"2x3x3"} \tab TRR | RTR | RRT
  }
}
\section{Warning }{
The sample size estimation for theta0 >1.2 and <0.85 may be very time consuming 
and will eventually also fail since the start values chosen are not really 
reasonable in that ranges. This is especially true in the range about CV = 0.3 
and regulatory constant according to FDA.\cr
If you really need sample sizes in that range be prepared to restart the sample 
size estimation via the argument nstart.\cr
Since the dependence of power from n is very flat in the mentioned region you 
may also consider to adapt the number of simulations not to tap in the simulation 
error trap.
}
\seealso{
\code{\link{power.RSABE}}, \code{\link{power.scABEL}}
}
\examples{
# using all the defaults:
# design=2x3x3 (partial replicate design), theta0=0.90, 
# ABE limits, PE constraint 0.8 - 1.25
# targetpower=80\%, alpha=0.05, 1E5 simulations
sampleN.RSABE(CV = 0.3)
# should result in a sample size n=45, power=0.80344
}
