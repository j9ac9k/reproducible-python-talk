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
* `flit` (`pyproject.toml`)
* PyPI distribution

:::

## Motivation

* we want to share or distribute our code
* we want to make sure it can run on the target machine
* we want the recipient to have confidence
* copy and paste is just not a valid method of sharing code

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

## Create a Project Directory

![Create Source Directory](./images/basic_file.png "Creating Source Directory")

## More Boilerplate

* get an appropriate `.gitignore` file from https://gitignore.io
* assign a software license - if unsure take a look at https://choosealicence.com
* create a readme file

![More Boilerplate](./images/more_boilerplate.png "Adding More Boilerplate")

## Different Methods to Package

* `setuptools` with a `setup.py` to create a pip installable package
* `filt` with `pyproject.toml` to create a pip installable package
* `pipenv` with a `Pipfile` to create a reproducible python environment
* `conda-skeleton` to create a `conda` installable package

## setuptools

* Most common method of packaging
* Not part of the standard library, but comes with `pip` so you likely already have it
* Create `setup.py` and configure it to install things the way you want them to

## Basic `setup.py`

```python
from setuptools import setup

with open("README.md", "r") as fh:
    long_description = fh.read()

setup(
    name="adj_matrix-ogi",
    version="0.0.1",
    install_requires=['scipy'],
    description="Computed Adjacency Matrix From a List of Points",
    py_modules=["adj_matrix"],
    package_dir={"": "src"},
    long_description=long_description,
    long_description_content_type="text/markdown",
    classifiers=[
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
        "Operating System :: OS Independent",
    ],
    url="https://github.com/j9ac9k/adj_matrix",
    author="Ogi Moore",
    author_email="ognyan.moore@gmail.com"
    )
```

## Verify It Works

```bash
$ pip install -e .
...
$ python
Python 3.7.0 (default, Jul 26 2018, 12:04:38)
[Clang 9.1.0 (clang-902.0.39.2)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> from adj_matrix import make_adj_matrix
>>> make_adj_matrix([[0, 0], [1, 1], [2, 2]])
array([[0.        , 1.41421356, 2.82842712],
       [1.41421356, 0.        , 1.41421356],
       [2.82842712, 1.41421356, 0.        ]])
>>>
```

## Private Deployment

At this point, if the source code is on a remote git repository, it's installable via pip by someone else!

```bash
$ pip install git+git://github.com/j9ac9k/timeview#egg=timeview
```

## Creating Binary Distribution

```bash
$ python setup.py bdist_wheel
...
$ ls dist
adj_matrix_ogi-0.0.1-py3-none-any.whl
```

This creates a binary distribution, also known as a `wheel`, which is usually what PyPI distributes.

## Creating Source Distribution

Source distributions are an archive of everything in the source code repository, including
* LICENSE.txt
* supplemental data
* `setup.py`
* and more!

By default `setuptools` ignores these files.

## MANIFEST.in

To grab these supplemental files you will need to manually specify them...we do this using a `MANIFEST.in` file

```bash
$ cat ~/Developer/timeview/MANIFEST.in
include timeview/manager/main.ui
include timeview/manager/dataset.db
recursive-include timeview *.json
...
```

## MANIFEST Continued

* There's a tool for that...
* Make sure all the file are added to your repository and then run:

```bash
$ pip install check-manifest
...
$ check-manifest --create
```

## Verify Successful Build

```bash
$ python setup.py bdist_wheel sdist
...
$ ls dist/
adj_matrix-ogi-0.0.1.tar.gz  # source distribution
adj_matrix_ogi-0.0.1-py3-none-any.whl  # wheel distribution
```

## Deploy to PyPI

* create account at PyPI
* install twine via pip
* follow instructions from docs
    ```bash
    $ pip install twine
    ...
    $ twine upload dist/
    ...
    ```

## You Said There Would be Reproducibility

Creator did not guarantee anything about users environment

## pipenv

* `pipenv` is a tool that merged `virtualenv` along with `pip`
* `virtualenv` is a tool for creating isolated python environments
* the `virtualenv` is deterministic
    * by deterministic I mean your dependencies will be at a pinned version
    * your dependencies dependencies will be at a pinned version

## 