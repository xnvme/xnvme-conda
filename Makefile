# Makefile for building a conda package
ENV_YAML = environment.yaml
ENV_NAME = xnvme_conda_build
BUILDDIR= builddir

# Phony targets
.PHONY: all environment xnvme-sys xnvme-sys-local-src test clean help

# Default target
all: help

# Help message
help:
	@echo "Usage:"
	@echo "  make environment         - Create the conda environment"
	@echo "  make xnvme-sys           - Build using meta.source.url = URL_OF_XNVME_SRC_TGZ"
	@echo "  make xnvme-sys-local-src - Build using meta.source.path = xnvme-src.tar.gz"
	@echo "  make clean               - Clean up the build environment"

# Create the conda environment
environment:
	@if conda env list | grep -q "^$(ENV_NAME) "; then \
		echo "$(ENV_NAME) exists... skipping"; \
	else \
		conda env create -f $(ENV_YAML); \
		conda run -n $(ENV_NAME) conda config --add channels conda-forge; \
		conda run -n $(ENV_NAME) conda config --set channel_priority strict; \
	fi

xnvme: environment
	conda run -n $(ENV_NAME) conda-build xnvme --output-folder $(BUILDDIR)
	@echo "Conda package built."

xnvme-sys: environment
	conda run -n $(ENV_NAME) conda-build xnvme-sys --output-folder $(BUILDDIR)
	@echo "Conda package built."

xnvme-sys-local-src: environment
	conda run -n $(ENV_NAME) conda-build xnvme-sys --output-folder $(BUILDDIR) \
	--clobber-file xnvme-sys/meta-source-clobber.yaml

clean:
	conda env remove -n $(ENV_NAME) -y
	rm -r $(BUILDDIR) || true
