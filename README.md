# DL-Prolog - Defeasible Logic in Prolog

Based on:

- G. Antoniou, N. Dimaresis, and G. Governatori, “A System for Modal and Deontic Defeasible Reasoning”.

- “A modal and deontic defeasible reasoning system for modelling policies and multi-agent systems,” Expert Systems with Applications, vol. 36, no. 2, pp. 4125–4134, Mar. 2009, doi: 10.1016/j.eswa.2008.03.009.

## Theory1

**Facts**

$bird(tweety)$\
$penguin(charles)$

**Rules**

$\text{r1 } \forall x: penguin(x) \rightarrow_{knowledge} bird(x)$\
$\text{r2 } \forall x: bird(x) \Rightarrow_{knowledge} fly(x)$\
$\text{r3 } \forall x: penguin(x) \rightsquigarrow_{knowledge} \lnot fly(x)$ 

**Experiment**

Load theory into swipl: `run.sh theory1.pl`

- $+\Delta bird(charles)$ do we have a definite proof that charles is a bird?
    - It should be true, because of the definition r1.
- $-\Delta bird(charles)$ do we have a definite proof that charles is a not bird?
    - It should be false, because we have no definition that makes charles not a bird.
- $+\delta fly(charles)$ do we have a defeasible proof that charles can fly?
    - It should be false, because r2 charles can flye which is defeated by r3.
        - Being a pengiun means, that charles may not be able to fly.
- $-\delta fly(charles)$ do we have a defeasible proof that charles can not fly?
    - It should be false, there is no defeasible or strict proof that charles can not fly.

Remove r3 to get defeasible proof that charles can fly.

## Theory2

**Facts**

$professor(herbert)$\
$visiting(herbert)$

**Rules**

$\text{r1 } \forall x : professor(x) \rightarrow_{knowledge} faculty(x)$\
$\text{r2 } \forall x : professor(x) \Rightarrow_{knowledge} tenured(x)$\
$\text{r3 } \forall x : visiting(x) \Rightarrow_{knowledge} \lnot tenured(x)$\
$\text{r3} \gt \text{r2}$

**Experiment**

Load theory into swipl: `run theory2.pl`

- $+\Delta faculty(herbert)$ do we have a definite proof that herbert is a part of a faculty?
    - It should be true, because of definition r1.
- $-\Delta faculty(herbert)$ do we have a definite proof that herbert is a not part of a faculty?
    - It should be false, because there is no definition that makes herbert no faculty.
- $+\delta tenured(herbert)$ do we have a defeasible proof that herbert is tenured?
    - It should be false, because r3 has superiority over r2.
- $-\delta tenured(herbert)$ do we have a defeasible proof that herbert is not tenured?
    - It shoule be true, because r3 has superiority over r2.