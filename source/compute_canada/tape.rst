Using the nearline storage server on Beluga
===========================================

Nearline is a tape-based filesystem used to archive data on compute canada.
It uses good old magnetic tape, with a data transfer up to 140 MB/s.
For example, it can be really usefull if you want to archive the analysis from a paper that you are no longer working on.

Pre-requisites
::::::::::::::
* Basics use of Linux (cmd line, shell scripting)
* Our tutorial on :doc:`/tutorials/hpc`

What will you learn ?
:::::::::::::::::::::
* Archive data
* Use a tape-server

Working with the tape server
::::::::::::::::::::::::::::

Archive the data and move into the tape
---------------------------------------
The first thing you will need to do is to ``tar`` the folder you want to archive.
This is intended to reduce the number of files, since a tape system is not meant to store deep file tree.
In the following example, ``my/data`` stands for the directory you want to tape:

.. code:: bash
    
    cd /path/to/my/data
    tar -czf /nearline/ctb-pbellec/my_data.tar.gz .

.. note::
    When the folder is big, it should take some time since the filesystem is slow. If it takes too much time, you should run this inside a compute node:
    ``salloc --account=rrg-pbellec --mem=2G --time=4:00:0``



Check that the output indeed exists at ``/nearline/ctb-pbellec``

Moving back to the standard filesystem
--------------------------------------
If you need to access and read your data, just untar it.

.. code:: bash

    tar -zxvf /nearline/ctb-pbellec/my_data.tar.gz

All the content of the archive should be seen into the folder ``my_data``.

To go further
:::::::::::::
You can check also check the `documentation from compute canada <https://docs.computecanada.ca/wiki/Using_nearline_storage>`_.
