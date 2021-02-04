Preprocesing datasets on Beluga with fMRIPrep
=====================================================
This document purpose is to allow anyone with basic shell experience to preprocess datasets that are stored on our compute canada allocation.
We will specifically use `fmriprep-slurm <https://github.com/SIMEXP/fmriprep-slurm>`_, a python tool developped internally in the lab to automatically generate slurm files.
It is carefully designed and optimized to run run the preprocessing.

`fMRIPrep <https://fmriprep.org/en/stable/>`_ is the pipeline that we use internally to preprocess 
`BIDS <https://bids-specification.readthedocs.io/en/stable/>`_-compatible datasets.
It uses a combination of tools from well-known software packages, 
including `FSL <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/>`_, 
`ANTs <https://stnava.github.io/ANTs/>`_, `FreeSurfer <https://surfer.nmr.mgh.harvard.edu/>`_ and `AFNI <https://afni.nimh.nih.gov/>`_.

If it is the first time you are using our tool, you should go through the :ref:`Preparation steps`.

Pre-requisites
::::::::::::::
* Basic knowledge of `preprocessing pipeline <https://fsl.fmrib.ox.ac.uk/fslcourse/online_materials.html#Prep>`_
* Our tutorial on :doc:`../tutorials/hpc`
* Basic knowledge on containerized app (Docker, singularity)

What will you learn ?
:::::::::::::::::::::
* Use fmriprep to preprocess a dataset
* Optimize a slurm file for big data

Preparation steps
:::::::::::::::::

Freesrufer license
------------------
As part of the fMRIPrep pipeline, `Freesurfer <https://surfer.nmr.mgh.harvard.edu/fswiki>`_ is mostly used for the reconstruction steps.
It is free, but it requires a license to be used so you will need one before everything else.

To obtain a freesurfer license, `register in the website <https://surfer.nmr.mgh.harvard.edu/registration.html>`_.
For the ``institution_name`` you should use "CRIUGM" and the ``institution_type``  is "nonprofit_education_research".

Once downloaded, you can move the file to beluga:

    .. code:: bash

        scp ~/Downloads/license.txt beluga.computecanada.ca:~/.freesurfer.txt

Python dependencies
------------------

`fmriprep-slurm <https://github.com/SIMEXP/fmriprep-slurm>`_ have some dependencies to met before using it.
In order to use it, we will create a `python virtual environment <https://docs.python.org/3/tutorial/venv.html>`_
with `pybids <https://bids-standard.github.io/pybids/>`_ (to manage a BIDS compatible dataset)
and `templateflow <https://www.templateflow.org/python-client/0.5.0rc1/api/templateflow.api.html>`_
(a repository holding multiple templates for neuroimaging).

1. Connect to beluga and go into your project home:

    .. code:: bash

        ssh beluga.computecanada.ca
        cd $HOME/projects/rrg-pbellec/$USER

2. Create a virtualenv and install all fmriprep-slurm dependencies:

    .. code:: bash
        
        virtualenv --python=python3.6 .virtualenvs/fmriprep-slurm
        python3 -m pip install -r $HOME/projects/rrg-pbellec/fmriprep-slurm/requirements.txt

Generating the slurm files
::::::::::::::::::::::::::
Make sure that you have followed the :ref:`Preparation steps`.
You should be able to active the virtual environment:

    .. code:: bash

        source $HOME/projects/rrg-pbellec/$USER/.virtualenvs/fmriprep-slurm/bin/activate

You are now ready to use ``fmriprep-slurm``, with default commands:

    .. code:: bash

        python3 $HOME/projects/rrg-pbellec/fmriprep-slurm/fmriprep-slurm/main.py PATH/TO/BIDS/DATASET fmriprep

.. note::

    There are lot of different options, check the `github page <https://github.com/SIMEXP/fmriprep-slurm>`_ for more informations.

Submitting the preprocesing jobs
:::::::::::::::::::::::::::::::::
Once you checked the content of the slurm script, you are now ready to submit the jobs.

You can simply run

    .. code:: bash

        sbatch PATH/TO/FMRIPREP-SLURM-SBATCH-FILE

.. note::
    It is important to check for the time and hardware requests, because this impacts our allocation even if the job fails.

To go further
:::::::::::::
Look at the `fMRIPrep <https://fmriprep.org/en/stable/>`_ documentation, 
and more specifically the section on `singularity <https://fmriprep.org/en/stable/singularity.html>`_.
