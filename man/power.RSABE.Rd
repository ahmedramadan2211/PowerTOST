\encoding{utf-8}
\name{power.RSABE}
\alias{power.RSABE}
\title{
(Empirical) Power for BE decision via linearized scaled ABE criterion
}
\description{
This function performs the power calculation of the BE decision via 
linearized scaled ABE criterion by simulations as recommended by the FDA.
}
\usage{
power.RSABE(alpha = 0.05, theta1, theta2, theta0, CV, n, 
            design = c("2x3x3", "2x2x4", "2x2x3"), regulator,
            nsims = 1e+05, details = FALSE, setseed=TRUE)
}
\arguments{
  \item{alpha}{
Type I error probability, significance level. Conventionally mostly set to 0.05.
}
  \item{theta1}{
Conventional lower \acronym{ABE} limit to be applied in the mixed procedure if 
\code{CVsWR <= CVswitch}. Also lower limit for the point estimate constraint.\cr
Defaults to 0.8 if not given explicitly.
}
  \item{theta2}{
Conventional upper \acronym{ABE} limit to be applied in the mixed procedure if 
\code{CVsWR <= CVswitch}. Also upper limit for the point estimate constraint.\cr
Defaults to 1.25 if not given explicitly.
}
  \item{theta0}{
\sQuote{True} or assumed T/R ratio. \cr
Defaults to 0.90 according to the two \enc{Lászlós}{Laszlos} if not given explicitly.
}
  \item{CV}{
Intra-subject coefficient(s) of variation as ratio (not percent).
  \itemize{
    \item If given as a scalar (\code{length(CV)==1}) the \emph{same} CV of Test
          and Reference is assumed (homoscedasticity, \code{CVwT==CVwR}).
    \item If given as a vector (\code{length(CV)==2}), \emph{i.e.}, assuming
          heteroscedasticity, the CV of the Test \strong{must} be given in \code{CV[1]} and the one of the Reference in the \code{CV[2]}.
  }
}
  \item{n}{
Number of subjects under study.\cr
May be given as vector. In that case it is assumed that n contains the number
of subjects in the sequence groups.\cr\cr
If \code{n} is given as single number (total sample size) and this number is not 
divisible by the number of sequences of the design an unbalanced design is 
assumed. A corresponding message is thrown showing the numbers of subjects 
in sequence groups used.\cr
Attention! In case of the \code{"2x2x3"} (TRT|RTR) design the order of sample sizes / sequence is important if given as a vector. \code{n[1]} is for sequence group 'TRT' and \code{n[2]} is for 
sequence group 'RTR'. 
}
  \item{design}{
Design of the study.\cr
\code{"2x3x3"} is the partial replicate design.\cr
\code{"2x2x4"} is a full replicate design with 2 sequences and 4 periods.\cr
\code{"2x2x3"} is a full replicate design with 2 sequences and 3 periods.\cr
Defaults to \code{"2x3x3"}. Details are given the section about Designs.
}
  \item{regulator}{
Regulatory settings for RSABE.\cr
May be given as character from the choices \code{"EMA"} or \code{"FDA"} or as an object of
class 'regSet' (see \code{\link{reg_const}}).\cr
Defaults to \code{regulator="FDA"} if missing.\cr
This argument may be given also in lower case if given as character.\cr\cr
Also the linearized scaled ABE criterion is usually calculated with the FDA 
constant \code{r_const=log(1.25)/0.25} you can override this behavior to use the 
EMA setting \code{r_const=0.76} to avoid the discontinuity at CV=30\% and be 
more stringent.
}
  \item{nsims}{
Number of simulations to be performed to obtain the empirical power.
Defaults to 100,000 = 1e+5.\cr
If simulations are aimed for empirical alpha \code{nsims=1e+06} is recommended.
}
  \item{details}{
If set to \verb{TRUE} the computational time is shown as well as the components
for the BE decision.\cr
p(BE-sABEc) is the probability that the 95\% CI of the ABE criterion is <0.\cr
p(BE-PE) is the probability that the point estimate is within theta1 ... theta2.\cr
p(BE-ABE) is the simulated probability for the conventional ABE test given for
comparision purposes.\cr
}
  \item{setseed}{
Simulations are dependent on the starting point of the (pseudo) random number 
generator. To avoid differences in power for different runs a \code{set.seed()} 
is issued if \code{setseed=TRUE}, the default. 
}
}
\details{
The linearized scaled ABE criterion is calculated according to the SAS code
given in the FDA\enc{’}{'}s progesterone guidance.\cr
The simulations are done via the distributional properties of the statistical
quantities necessary for deciding BE based on scaled ABE criterion.\cr
Details can be found in a document \verb{Implementation_scaledABE_simsVx.yy.pdf} 
located in the \code{/doc} sub-directory of the package.\cr
If a CVcap is defined for the regulator, the BE decision is based on the inclusion
of the CI in the capped widened acceptance limits in case of \code{CVwR > CVcap}. This
resembles method \sQuote{Howe-EMA} in \enc{Muñoz}{Munoz} \emph{et al.} and is the standard behavior now if
\code{regulator="EMA"} is choosen.
}
\value{
Returns the value of the (empirical) power if argument \code{details=FALSE}.\cr
Returns a named vector if argument \code{details=TRUE}.\cr
p(BE) is the power, p(BE-sABEc) is the power of the scaled ABE criterion alone 
and p(BE-pe) is the power of the criterion \sQuote{point estimat within acceptance 
range} alone.\cr
p(BE-ABE) is the power of the conventional ABE test given for comparative purposes.
}
\section{Designs}{
Although some designs are more \sQuote{popular} than others, power calculations are valid for \emph{all} of the following designs:
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
In case of the design \code{"2x2x3"}" heteroscedasticity (\emph{i.e.}, CVwT != CVwR) may 
lead to poor agreement of the power values compared to those calculated via the 
\sQuote{classical} way of subject data simulations if the design is unbalanced in respect
to the number of subjects in the sequence groups. Therefore, the function 
issues a warning for that cases.
}
\references{
Food and Drug Administration, Office of Generic Drugs (OGD). \emph{Draft Guidance on Progesterone.} Recommended Apr 2010. Revised Feb 2011. \href{https://www.accessdata.fda.gov/drugsatfda_docs/psg/Progesterone_caps_19781_RC02-11.pdf}{download}

\enc{Tóthfalusi}{Tothfalusi}, L, \enc{Endrényi}{Endrenyi}, L. \emph{Sample Sizes for Designing Bioequivalence Studies for Highly Variable Drugs.} J Pharm Pharmaceut Sci. 2011;15(1):73--84. 
\href{https://ejournals.library.ualberta.ca/index.php/JPPS/article/download/11612/9489}{open access}

\enc{Tóthfalusi}{Tothfalusi} L, \enc{Endrényi}{Endrenyi} L, \enc{García}{Garcia} Arieta A. \emph{Evaluation of Bioequivalence for Highly Variable Drugs with Scaled Average Bioequivalence.} Clin Pharmacokin. 2009;48(11):725--43. \doi{10.2165/11318040-000000000-00000}

\enc{Muñoz}{Munoz} J, Alcaide D, \enc{Ocaña}{Ocana} J. \emph{Consumer\enc{’}{'}s risk in the EMA and FDA regulatory approaches for bioequivalence in highly variable drugs.} Stat Med. 2015;35(12):1933--43. \doi{10.1002/sim.6834}
}
\author{
D. Labes
}
\seealso{
\code{\link{sampleN.RSABE}}, \code{\link{power.scABEL}}
}
\examples{
# using all the defaults:
# design="2x3x3" = partial replicate
# ABE limits, PE constraint 0.8-1.25
# true ratio = 0.90, 1E+5 simulations
power.RSABE(CV = 0.4, n = 36)
# should give
# [1] 0.83634
#
# to explore the simulation error due to the state of the
# random number generator
power.RSABE(CV = 0.4, n = 36, setseed = FALSE)
# will give something like
# [1] 0.83725
#
# explore pure RSABE (without mixed method, without pe constraint)
rs           <- reg_const("FDA")
rs$CVswitch  <- 0
rs$pe_constr <- FALSE
power.RSABE(CV = 0.4, n = 36, regulator = rs)
# should give
# [1] 0.84644
}
