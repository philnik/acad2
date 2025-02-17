


build: pyproject.toml
	python -m build

install: pyproject.toml
	python -m pip install --editable ./
