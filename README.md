# Prolog-DL

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
- $-\Delta bird(charles)$ do we have a definite proof that charles is a not bird?
- $+\delta fly(charles)$ do we have a defeasible proof that charles can fly?
- $-\delta fly(charles)$ do we have a defeasible proof that charles can not fly?

```
?- defeasibly(~(fly(charles))).
false
```

## Theory2

**Facts**

$professor(herbert)$\
$visiting(herbert)$

**Rules**

$\text{r1 } \forall x : professor(x) \rightarrow_{knowledge} faculty(x)$\
$\text{r2 } \forall x : professor(x) \Rightarrow_{knowledge} tenured(x)$\
$\text{r3 } \forall x : visiting(x) \Rightarrow_{knowledge} \lnot tenured(x)$\
$\text{r2} \gt \text{r3}$

**Experiment**

Load theory into swipl: `run theory2.pl`

- $+\Delta faculty(herbert)$ do we have a definite proof that herbert is a part of a faculty?
- $-\Delta faculty(herbert)$ do we have a definite proof that charles is a not part of a faculty?
- $+\delta tenured(herbert)$ do we have a defeasible proof that herbert is tenured?
- $-\delta tenured(herbert)$ do we have a defeasible proof that charles is not tenured?