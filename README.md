# Prolog-DL

Based on:

- G. Antoniou, N. Dimaresis, and G. Governatori, “A System for Modal and Deontic Defeasible Reasoning”.

- “A modal and deontic defeasible reasoning system for modelling policies and multi-agent systems,” Expert Systems with Applications, vol. 36, no. 2, pp. 4125–4134, Mar. 2009, doi: 10.1016/j.eswa.2008.03.009.

## Theory1

**Facts**

```math
bird(tweety) \\
penguin(charles) \\
```

**Rules**

```math
\text{r1 } \forall x: penguin(x) \rightarrow_{knowledge} bird(x) \\
\text{r2 } \forall x: bird(x) \Rightarrow_{knowledge} fly(x) \\
\text{r3 } \forall x: penguin(x) \rightsquigarrow_{knowledge} \lnot fly(x) 
```

**Experiment**

Load theory into swipl: `swipl theory1.pl`

- $+\Delta bird(charles)$ do we have a definite proof that charles is a bird?

```
?- strictly(bird(charles)).
true
```

- $-\Delta bird(charles)$ do we have a definite proof that charles is a not bird?

```
?- strictly(~(bird(charles))).
false
```

- $+\delta fly(charles)$ do we have a defeasible proof that charles can fly?

```
?- defeasibly(fly(charles)).
false
```

- $-\delta fly(charles)$ do we have a defeasible proof that charles can not fly?

```
?- defeasibly(~(fly(charles))).
false
```

## Theory2

**Facts**

```math
professor(herbert) \\
visiting(herbert) \\
```

**Rules**

```math
\text{r1 } \forall x : professor(x) \rightarrow_{knowledge} faculty(x) \\
\text{r2 } \forall x : professor(x) \Rightarrow_{knowledge} tenured(x) \\
\text{r3 } \forall x : visiting(x) \Rightarrow_{knowledge} \lnot tenured(x) \\
\text{r4 } \forall x : tenured(x) \rightsquigarrow_{knowledge} \lnot fired(x) \\
\text{r2} \gt \text{r3}
```

**Experiment**

Load theory into swipl: `swipl theory2.pl`

- $+\Delta faculty(herbert)$ do we have a definite proof that herbert is a part of a faculty?

```
?- strictly(faculty(herbert)).
true
```

- $-\Delta faculty(herbert)$ do we have a definite proof that charles is a not part of a faculty?

```
?- strictly(~(faculty(herbert))).
false
```

- $+\delta tenured(herbert)$ do we have a defeasible proof that herbert is tenured?

```
?- defeasibly(tenured(herbert)).
false
```

- $-\delta tenured(herbert)$ do we have a defeasible proof that charles is not tenured?

```
?- defeasibly(~(tenured(herbert))).
true
```