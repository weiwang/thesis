---
title: Structured Meta-Analysis via Hierarchical Gaussian Processes and Potential Outcomes
author:
- name: Wei Wang
  affiliation: Columbia University
  email: ww2243@columbia.edu
date: Apr 17, 2015
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
both. Is the effect estimate averaging over teachers? Schools? Or both? What
can we say about the effect for a new teacher, or a new school? The second
problem is the inflexible form of parametric models. Traditional parametric
models require explicit modeling assumptions from the researchers, which makes
the model sensitive and facilitate cheery-picking. Non-parametric modeling
allows extremetly flexible functional form and requires little manual tuning
from the researchers.

## Meta-Analysis through Potential Outcomes ##

# Meta-Analysis through Non-parametric Models #

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

