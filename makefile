SHELL := /bin/bash

clean:
	@find . -type f -name '\#*' -exec rm -f  {} \;
	@find . -type f -name '*~' -exec rm -f  {} \;


build: pyproject.toml
	python -m build

install: pyproject.toml
	python -m pip install --editable ./
