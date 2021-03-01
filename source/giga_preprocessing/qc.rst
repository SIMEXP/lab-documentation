Quality control from fMRIPrep outputs
=====================================

Previously, we run fmriprep on Beluga...
Here we will do the wc.

Pre-requisites
::::::::::::::
* Basic knowledge of `preprocessing pipeline <https://fsl.fmrib.ox.ac.uk/fslcourse/online_materials.html#Prep>`_
* Our tutorial on :doc:`preprocessing`
* Understanding containerized app (Docker, singularity)

What will you learn ?
:::::::::::::::::::::
* Understand the quality control procedure for neuroimaging data






1. Connect to beluga and go into your project home:

    .. code:: bash

        ssh beluga.computecanada.ca
        cd $HOME/projects/rrg-pbellec/$USER

2. Create a virtualenv and install all fmriprep-qc dependencies:

    .. code:: bash
        
        virtualenv --python=python3.6 .virtualenvs/fmriprep-qc
        python3 -m pip install -r $HOME/projects/rrg-pbellec/fmriprep-qc/requirements.txt



ssh -L 8050:localhost:8050 beluga4.computecanada.ca -i ~/.ssh/cc/cc



Make sure that you have followed the :ref:`Preparation steps`.
You should be able to active the virtual environment:

    .. code:: bash

        source $HOME/projects/rrg-pbellec/$USER/.virtualenvs/fmriprep-qc/bin/activate