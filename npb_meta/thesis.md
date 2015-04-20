---
title: Structured Meta-Analysis via Hierarchical Gaussian Processes and Potential Outcomes
author:
- name: Wei Wang
  affiliation: Columbia University
  email: ww2243@columbia.edu
date: Apr 20, 2015
abstract: 
    Meta-Analysis, the synthesis of evidence from multiple study sources, has
    become increasing popular in fields such as education, psychology and public
    health. The major obstacle for meta-analysis is the interpretation and
    proper handeling of study-by-study heterogeneity. Based on [@sobel2015],
    which proposed a potential outcome framework for a formal causal approach to
    meta-analysis, I develop a high-dimensional Gaussian Process model that
    explicitly handels heterogeneities across studies, allows flexible modeling
    of response functions and admits fully probabilistic inference.
bibliography: npb_meta.bib
...

# Introducation #

Meta-Analysis, the synthesis of evidence from multiple study sources, has become
increasing popular in fields such as education, psychology and public
health. The major obstacle for meta-analysis is the interpretation and proper
handeling of study-by-study heterogeneity. Based on [@sobel2015], which proposed
a potential outcome framework for a formal causal approach to meta-analysis, I
develop a high-dimensional Gaussian Process model that explicitly handels
heterogeneities across studies, allows flexible modeling of response functions
and admits fully probabilistic inference.

# Meta-Analysis #

Meta-anlyses combine data from distinct but related studies for higher
resolution inference and more nuanced understanding of the effect under
investigation. Originally hailed in medical and education research,
meta-analyses gain traction in wider academic disciplines as the awareness for
open data is increasing across all scientific communities.

However, traditional meta-analyses mostly are conducted based on extracting and
combining study-level effect summaries, since access to individual-paticipant
level data are historically inhabitantly difficult to obtain. In this framework,
researchers extract effect size estimates $y_s$ and standard errors
$\sigma_s^2$, where $s\in \{1,\ldots,S\}$ and $S$ is the number of studies. To
handle effect size heterogeneity, a random effect model is typically used
[@dersimonian1986meta], in which all study effect sizes are random samples of a
underlying population of effect sizes, i.e.

\begin{align*}
    y_s&=\mu_s + \sigma_s^2\\
    \mu_s &\sim N(\mu_0, \tau^2)
\end{align*}

Admittedly, meta-analyses based on study-level summary is still effective when
the effects are homogeneous and different studies sample from similar
population, they nevertheless are prone to well-knowen statistical fallacies,
such as ecological bias, when the underlying populations and effects are
heterogeneous, as it is often the case in real data.

## Individual-Paticipant Meta-Analyses ##

Individual-Paticipatn Data (IPD) Meta-Analysis is becoming increasing common
[@higgins2001meta]. It has been argued that IPD data increases the power of
analysis [@cooper2009relative] and more robust to heterogenous effects sizes and
populations [cite]. To account for between study heterogeneity in treatment
effects, the use of covariates and/or random effects models is often recommended
[@tudursmith2005investigating; @aitkin1999meta]. The random effects models can
be seen as Bayesian Hierarchical Models [@gelman2006data], based on the
justification that conditioned on appropriate set of covariates, both
individual-level and study-level, the residual heterogeneities are
exchagneable. There are mature softwares for fitting various types of Bayesian
Hierarchical models, including Generalized Linear models and Proportional Hazard
models. [cite lme4, coxme and stan]

Despite its convenient form and ease of inference, traditional IPD meta-analysis
based on parametric Hierarchical models suffer two problems. The first is the
lack of formal causal framework. It is difficult to pinpoint the causal
interpretation of the effect estimates from a traditional IPD hierarchical
model. Consider the following example, education researchers try to determine
the effect of a new intervention program, applied to different classroom and
administered by different teachers. In this case, the heterogeneity might come
from either the different teachers or the different populations of schools, or
both. Is the effect estimate averaging over teachers? Schools? Or both? What can
we say about the effect for a new teacher, or a new school? The second problem
is the inflexible form of parametric models. Traditional parametric models
require explicit modeling assumptions from the researchers, which makes the
model sensitive and facilitate cheery-picking. Non-parametric modeling allows
flexible functional form and requires little manual tuning from the researchers.

# Meta-Analysis using Potential Outcomes #

[@sobel2015] put meta-anlaysis on a concrete causal foundation by introducing a
extended potential outcome framework. This section is joint work with Michael
Sobel and David Madigan.

## Potential Outcomes ##

Potentail Outcomes Framework [] defines causal effects as comparisons of
outcomes under hypertheical counter-factual treatment assignment. For example,
with binary treatment $Z\in \{0,1\}$, the causal effect of treatment $Z$ on
indidvidual $i$ can be defined as $y_i(1)-y_i(0)$.  Typically, researchers are
interested in estimating quantities such as the population averge treatment
effect (PATE)

\begin{equation*} E(Y(1)-Y(0)), \end{equation*}

the population averge treatment effect on the treated (PATT)

\begin{equation*}
    E(Y(1)-Y(0)\mid Z=1)
\end{equation*}

The key assumption in causal inference is the ignorability assumption (or
unconfoundedness assumption) [@rosenbaum1983central], which states that given a
set of observed covariates, the treatment assignment $Z$ is independent of the
potential outcomes $(Y(0), Y(1))$

\begin{equation*}
    Y(0),Y(1) \perp Z \mid X
\end{equation*}

In the case of randomized experiment, this assumption is trivially met without
any covariates $X$. Under ignorability assumptoin, 

\begin{align*}
     &E(Y|X, z=1)-E(Y|X, z=0)\\
    =&E(Y(1)|X, z=1)-E(Y(0)|X, z=0)\\
    =&E(Y(1)|X)-E(Y(0)|X)\\
    =&E(Y(1)-Y(0)|X)
\end{align*}

And thus causal effect can be identified from observations.

## Extended Potential Outcomes ##

In the case of a meta-analysis, consisting $S$ studies and $Z$ treatment
variants, the potential outcomes $\bm Y$ for individual $i$ can be defined as a
matrix

\begin{equation*}
\bm Y_i=
\begin{pmatrix}
y_i(1,1) & y_i(1,2) & \cdots & y_i(1,Z)\\
y_i(2,1) & y_i(2,2) & \cdots & y_i(2,Z)\\
\vdots & \vdots & \ddots & \vdots\\
y_i(S,1) & y_i(S,2) & \cdots & y_i(S,Z)
\end{pmatrix}
\end{equation*}

In the context of meta-analyses, unconfoundedness can be recast as
unconfoundedness within each study, i.e.,

\begin{equation*}
    Y(0, s),Y(1, s) \perp Z \mid X, S=s
\end{equation*}

However, this assumption is not sufficient for identifying causal effects in
meta-analysis. One added layer for complexity of meta-analysis is the
confounding of study selection. Consider an example of clinical trials. If some
studies sample from mostly young patients while in some studies sample from
mostly elderly patients, and the treatment is more effective on younger
patients, then heterogeneities in treatment effects across studies would
arise. Hierarchial models without adequately addressing this selection problems
would result in misleading results.

However, study selection is not the only factor contributing to heterogneities
in treatment effects across studies. One lingering question is whether the same
treatment $z$ is implemented identically in all studies, or in another word,
whether $Y_i(s_1, z){\buildrel d \over =}Y_i(s_2, z)$ for all pair of $s_1, s_2
\in \{1,\dots, S\}$, where ${\buildrel d \over =}$ stands for equal in
distribution. Consider an example of education intervention, in which
interventions are carried out by teachers with various experience levels, then
it is reasonable to question whether $Y_i(s_1, z){\buildrel d \over =}Y_i(s_2,
x)$ holds.

Two assumptions from [@sobel2015] codify these two sources of heterogeneities.

A1.  _Weak response consistency assumption for treatment $z$_: For any
$z\in\{1,\dots,Z\}$ and any pair $s_1, s_2\in\{1,\ldots,S\}$,
\begin{equation*}
Y_i(s_1, z){\buildrel d \over =}Y_i(s_2, z)
\end{equation*}

A2.  _Unconfounded study selection_: \begin{equation*}\bm Y=
\begin{pmatrix}
y(1,1) & y(1,2) & \cdots & y(1,Z)\\
y(2,1) & y(2,2) & \cdots & y(2,Z)\\
\vdots & \vdots & \ddots & \vdots\\
y(S,1) & y(S,2) & \cdots & y(S,Z)
\end{pmatrix}
 \perp S \mid X\end{equation*}.

[@sobel2015] suggests that meta-analysts first assess the plausibilities of the
two assumptions based on the characteristics of the studies and

# Meta-Analysis using Non-parametric Models #

# Causal Inference #

## Non-parametric Approach to Causal Inference ##


See the [section on Gaussian Processes](#gp).

## Network Meta-Analysis ##

# Gaussian Processes {#gp} #

## Generative Models ##

# Models Descriptions #

# Inference #

# Simulations #

# Real Data (STAR data) #

