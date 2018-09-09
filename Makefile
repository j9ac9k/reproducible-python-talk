.PHONY: clean clean-test clean-pyc clean-build docs help
.DEFAULT_GOAL := help

make get-reveal:
	wget https://github.com/hakimel/reveal.js/archive/master.tar.gz +
	tar -xzvf master.tar.gz +
	mv reveal.js-master reveal.js

clean: clean-build clean-pyc  ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

slides: ## create slides
	/usr/local/bin/pandoc -t revealjs -s -o slides.html slides.md -V revealjs-url=./reveal.js -V theme=beige

pdf-slides:
	/usr/local/bin/pandoc -t beamer -s -o slides.pdf slides.md