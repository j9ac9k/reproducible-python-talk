---
author: Ognyan Moore
title: Reproducible Python
date: September 11, 2018
---
## Who Am I

* @ogimoore
* Graduating M.S. Student
* TimeView Developer

## Topics

How (and why) do we go from a python script(s) to something reproducible?

:::incremental

* why publish?
* `setuptools` (`setup.py`)
* `pipenv`
* `filt` (`pyproject.toml`)
* PyPI distribution

:::

## Motivation

* we want to share or distribute our code
* we want to make sure it can run on the target machine
* we want the recipient to have confidence
* copy and paste is just not a valid method of sharing code

## Most Importantly

Every time you publish you make the ecosystem better

## My Motivation

* Developed TimeView GUI application
* Many Dependencies over 8k lines of code
* Different install process on each Operating System
* Install method was unsafe (tell end user to run script)

## Working Example

Let's say we want to make this a package and distribute it

```python
from scipy import spatial
from spatial.distance import squarelike, pdist

def make_adj_matrix(points):
    return squarelike(pdist(points))
```

## 