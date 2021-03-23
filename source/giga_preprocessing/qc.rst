Quality control from fMRIPrep outputs
=====================================
Quality control (qc) is a crucial step in any neuroscience study.
Indeed, the quality of any data science study is driven by the underlying data.

In this document, we will make use of `fmriprep-qc <https://github.com/SIMEXP/fmriprep-qc>`_, a python
tool developped internally in the lab that help to visualize and qc `fMRIPrep <https://fmriprep.org/en/stable/>`_ preprocessing outputs.

If it is the first time you are using our tool, you should go through the :ref:`Preparation steps`.

Pre-requisites
::::::::::::::
* Basic knowledge of `preprocessing pipeline <https://fsl.fmrib.ox.ac.uk/fslcourse/online_materials.html#Prep>`_
* Our tutorial on :doc:`preprocessing`
* Understanding containerized app (Docker, singularity)

What will you learn ?
:::::::::::::::::::::
* Understand the quality control procedure for neuroimaging data

Preparation steps
:::::::::::::::::

Software environment
--------------------

You will first need to prepare a working environment to use `fmriprep-qc <https://github.com/SIMEXP/fmriprep-qc>`_.

1. Connect to beluga and go into your project home:

    .. code:: bash

        ssh beluga.computecanada.ca
        cd $HOME/projects/rrg-pbellec/$USER

2. Create a virtualenv and install all `fmriprep-qc <https://github.com/SIMEXP/fmriprep-qc>`_ dependencies:

    .. code:: bash
        
        virtualenv --python=python3.6 .virtualenvs/fmriprep-qc
        source $HOME/projects/rrg-pbellec/$USER/.virtualenvs/fmriprep-qc/bin/activate
        python3 -m pip install -r $HOME/projects/rrg-pbellec/fmriprep-qc/requirements.txt

Start the qc server
:::::::::::::::::::

One advantage when using the tool is that you will not need to copy the data locally.
Everything will stay on beluga, and you will spawn an http server to access and visualize the `fMRIPrep <https://fmriprep.org/en/stable/>`_ outputs.

If you are logged in on beluga, please log-out:

    .. code:: bash

        exit

Now you can log-in again, but this time by forwarding your local port:

    .. code:: bash

        ssh -L 8050:localhost:8050 beluga.computecanada.ca

Make sure that you have followed the :ref:`Preparation steps`, and activate your virtual environment:

    .. code:: bash

        source $HOME/projects/rrg-pbellec/$USER/.virtualenvs/fmriprep-qc/bin/activate

You can now start the http server:

    .. code:: bash

        python3 ~/projects/rrg-pbellec/fmriprep-qc/fmriprep-qc/main.py PATH/TO/FMRIPREP/OUTPUT

Do the qc
:::::::::

If everything worked as expected, open `http://127.0.0.1:8050/ <http://127.0.0.1:8050/>`_ in your favourite browser.

.. note::
    You can change the port if needed with the ``--port`` argument, but remember to forward this new port when connecting to beluga.

(help needed here to explain how to qc)

Questions ?
:::::::::::

If you have any issues using compute canada, don't hesitate to ask your questions on the SIMEXP lab slack in ``#compute_canada`` channel!
