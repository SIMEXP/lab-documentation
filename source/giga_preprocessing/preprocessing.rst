Preprocesing datasets on Beluga with fMRIPrep
=============================================
This document purpose is to allow anyone to preprocess datasets that are stored on the compute canada lab allocation.
We will specifically use `fmriprep-slurm <https://github.com/SIMEXP/fmriprep-slurm>`_, a python tool developped internally in the lab to automatically
generate `slurm <https://slurm.schedmd.com/sbatch.html>`_ files from a `BIDS <https://bids-specification.readthedocs.io/en/stable/>`_ dataset.

`fMRIPrep <https://fmriprep.org/en/stable/>`_ is the pipeline that we use internally to preprocess 
`BIDS <https://bids-specification.readthedocs.io/en/stable/>`_-compatible datasets.
It uses a combination of tools from well-known software packages, 
including `FSL <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/>`_, 
`ANTs <https://stnava.github.io/ANTs/>`_, `FreeSurfer <https://surfer.nmr.mgh.harvard.edu/>`_ and `AFNI <https://afni.nimh.nih.gov/>`_.

If it is the first time you are using our tool, you should go through the :ref:`Preparation steps`.

Pre-requisites
::::::::::::::
* Basic knowledge of `preprocessing pipeline <https://open.win.ox.ac.uk/pages/fslcourse/website/online_materials.html>`_
* Our tutorial on :doc:`../tutorials/hpc`
* Understanding containerized app (Docker, singularity)

What will you learn ?
:::::::::::::::::::::
* Use fmriprep to preprocess a dataset
* Gain knowledge on HPC optimization for big data

Preparation steps
:::::::::::::::::

Freesrufer license
------------------
As part of the `fMRIPrep <https://fmriprep.org/en/stable/>`_ pipeline, `Freesurfer <https://surfer.nmr.mgh.harvard.edu/fswiki>`__ 
is mostly used for the reconstruction steps.
It is free, but it requires a license to be used so you will need one before everything else.

To obtain a freesurfer license, `register in the website <https://surfer.nmr.mgh.harvard.edu/registration.html>`_.
For the ``institution_name`` you should use "CRIUGM" and the ``institution_type``  is "nonprofit_education_research".

Once downloaded, you can move the file to beluga:

    .. code:: bash

        scp ~/Downloads/license.txt beluga.computecanada.ca:~/.freesurfer.txt

Software environment
--------------------
`fmriprep-slurm <https://github.com/SIMEXP/fmriprep-slurm>`_ depends on `pybids <https://bids-standard.github.io/pybids/>`_ 
(to manage a BIDS compatible dataset)
and `templateflow <https://www.templateflow.org/python-client/0.5.0rc1/api/templateflow.api.html>`_
(a repository holding multiple templates for neuroimaging).

We use `singularity <https://singularity.lbl.gov/>`_ to make sure that the python dependencies are in agreement
with the `fMRIPrep <https://fmriprep.org/en/stable/>`_ container, and to manage the 
`pybids <https://github.com/bids-standard/pybids>`__ caching mechanism.

.. warning::
    You must check that `singularity <https://singularity.lbl.gov/>`__, the `fMRIPrep <https://fmriprep.org/en/stable/>`__
    container and `fmriprep-slurm <https://github.com/SIMEXP/fmriprep-slurm>`_ is available on the system, 
    this should be the case for `Béluga <https://docs.computecanada.ca/wiki/B%C3%A9luga/en>`_ .

Templateflow
------------
fMRIPrep uses common brain templates which are managed by [Templateflow](https://fmriprep.org/en/stable/spaces.html#templateflow).
Our utility script takes care of it so you don't have any additionnal setup to do for that.

BIDS validation
---------------
As lot of other neuroimaging tools, `fMRIPrep <https://fmriprep.org/en/stable/>`_ heavily relies on the `BIDS <https://bids-specification.readthedocs.io/en/stable/>`_ layout.
It is then all natural to check if your input dataset is indeed `BIDS <https://bids-specification.readthedocs.io/en/stable/>`_ compliant, with a tool called
`BIDS-validator <https://github.com/bids-standard/bids-validator>`_.
You don't need to install it as it is already available on Beluga, just run the following command:

    .. code:: bash

        singularity exec -B PATH/TO/BIDS/DATASET:/DATA /lustre03/project/6003287/containers/fmriprep-20.2.1lts.sif bids-validator /DATA 

.. warning::
    If you are on [Narval](https://docs.computecanada.ca/wiki/Narval/en), please use the following directory instead (same for the reamining sections):
    `/lustre06/project/6002071`

Generating the slurm files
::::::::::::::::::::::::::
A convenience script is available to help you run the `singularity <https://singularity.lbl.gov/>`_ command 
with `fmriprep-slurm <https://github.com/SIMEXP/fmriprep-slurm>`_.
The following command run the script inside a compute node:

    .. code:: bash

        salloc --account=rrg-pbellec --mem-per-cpu=2G --time=4:00:0 --cpus-per-task=2
        /lustre03/project/6003287/fmriprep-slurm/singularity_run.bash PATH/TO/BIDS/DATASET fmriprep

.. warning::
    We are asking the path to the dataset (without ``/`` at the end), not the content.
    For example, this is valid ``datasets/ADHD200`` but this is not 
    ``datasets/ADHD200/``.

.. note::
    There are lot of different options, check the `github page <https://github.com/SIMEXP/fmriprep-slurm>`_ for more informations.
    For example, you might want to add your email with the ``--email`` argument.

.. warning::
    You might also want to add additionnal fmrirep command, for example to enable ICA_AROMA and disable FreeSurfer reconstruction. 
    In this case, you should add the argument as ``--fmriprep-args=\"--use-aroma --fs-no-reconall\"`` (don't forget the escaping character ``\``).

It should take some time since the filesystem is slow, grab a cup of coffee!

Submitting the preprocesing jobs
::::::::::::::::::::::::::::::::
If everything worked as expected, all the slurm files should be inside a new folder under your scratch space ``SCRATCH/DATASET_NAME/UNIX_TIME/.slurm``.
There should be one slurm script per subject ``sub``, allowing you to preprocess them in parrallel.

Check the content of the slurms scripts, and more specifically the time and hardware requests since it impacts our allocation usage even if the job fails.

You are now ready to submit the jobs with ``sbatch``:

    .. code:: bash

      find ${SCRATCH}/DATASET_NAME/UNIX_TIME/.slurm/smriprep_sub-*.sh -type f | while read file; do sbatch $file; done

Checking the output
:::::::::::::::::::

Output and error logs
---------------------
Once the jobs are finished, the output ``smriprep_sub-*.out`` and error ``smriprep_sub-*.err`` logs should be under the same folder as previously ``SCRATCH/DATASET_NAME/UNIX_TIME``.

Double-check your input dataset, and if you have any further issues, contact one of the data admins.

.. warning::
    It is possible that you encounter BIDS errors due to bad pybids caching behavious, because the filesystem is slow on Beluga.
    In this case, you should re-run the tool as described in :ref:`Generating the slurm files` with the ```--force-reindex``` argument.

fMRIPrep outputs
----------------
A first file available is the ``resource_monitor.json`` under ``${SCRATCH}/DATASET_NAME/UNIX_TIME``, to help you track the usage for each subject.

All the preprocessing outputs should also be inside ``${SCRATCH}/DATASET_NAME/UNIX_TIME/fmriprep``.

Finally, if fMRIPrep unexpectedly crashed, you can check its working directory in ``${SCRATCH}/DATASET_NAME/UNIX_TIME/smriprep_sub-XXXX.workdir``.


To go further
:::::::::::::
Look at the `fMRIPrep <https://fmriprep.org/en/stable/>`_ documentation, 
and more specifically the section on `singularity <https://fmriprep.org/en/stable/singularity.html>`__.

Questions ?
:::::::::::

If you have any issues using compute canada, don't hesitate to ask your questions on the SIMEXP lab slack in ``#compute_canada`` channel!
