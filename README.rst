xNVMe Conda Recipes
===================

The intent is to get these recipes into conda-forge. These Conda recipes are
utilized by the xNVMe CI to catch breakage prior to xNVMe release, basic CI
builds the package here, as well as on the xNVMe pipeline.


xnvme-sys/
  Conda recipe for the xNVMe system library and tools, not the Python bindings


xnvme/
  Conda recipe for the xNVMe Python Bindings


See the ``Makefile``, or just run ``make``, it has a collection of helpers to
build the Conda packages.

TODO
----

* Submit the 'xnvme' recipe once 'xnvme-sys' is integrated on conda-forge.
* Figure out how to enable OSX support on conda-forge, this will most likely
  require a pwritev() fallback in xNVMe to be in the next xNVMe release
* Figure out how to get the Windows package to build