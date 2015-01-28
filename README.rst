===============
cobbler-formula
===============

A saltstack formula that installs xymon on Ubuntu 12.04 and possibly
Debian Wheezy.

This formula requires the apache-formula and the python-augeas package.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``xymon.server``
----------------

Installs the xymon server package.

``xymon.client``
----------------

Installs the xymon client package.

``xymon.generate-hosts``
------------------------

Adds minions to the hosts list, it only adds minions in the same
environment (it assumes that the environment grain is setup)
