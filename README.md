# Prolog-DL

Based on “A modal and deontic defeasible reasoning system for modelling policies and multi-agent systems,” Expert Systems with Applications, vol. 36, no. 2, pp. 4125–4134, Mar. 2009, doi: 10.1016/j.eswa.2008.03.009.

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

- $+\Delta bird(charles)$ do we have a definite proof that charles is a bird

```
?- strictly(bird(charles),knowledge).
true
```

- $-\Delta bird(charles)$ do we have a definite proof that charles is a not bird

```
?- strictly(~(bird(charles)),knowledge).
false
```

- $+\delta fly(charles)$ do we have a defeasible proof that charles can fly

```
?- defeasibly(fly(charles),knowledge).
false
```

- $-\delta fly(charles)$ do we have a defeasible proof that charles can fly

```
?- defeasibly(~(fly(charles)),knowledge).
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


