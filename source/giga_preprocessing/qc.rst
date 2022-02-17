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

Everything was installed on beluga inside a singularity container.
Double check that the container indeed exists at this path: ``$HOME/projects/rrg-pbellec/containers/fmriprep-qc.simg``.

Start the qc server
:::::::::::::::::::

One advantage when using the tool is that you will not need to copy the data locally.
Everything will stay on beluga, and you will spawn an http server to access and visualize the `fMRIPrep <https://fmriprep.org/en/stable/>`_ outputs.

If you are logged in on beluga, please log-out:

    .. code:: bash

        exit

Now you can log-in again, but this time by forwarding your local port:

    .. code:: bash

        ssh -L 8050:localhost:8050 username@beluga.computecanada.ca
        
Where ``username`` is from the compute canada organization.

Make sure that you have followed the :ref:`Preparation steps`, and spawn the http server:

    .. code:: bash

        module load singularity/3.6
        singularity run -B PATH/TO/FMRIPREP/OUTPUT:/input $HOME/projects/rrg-pbellec/containers/fmriprep-qc.simg --dataset-name MY_DATASET

.. warning::
    Point to the ``fmriprep`` directory, not `freesurfer`, for example ``ccna_raw_data_2020/derivatives/fmriprep/fmriprep``
    
.. note::
    You can change the port if needed with the ``--port`` argument, but remember to also forward this new port when connecting to beluga.
    For example:
        .. code:: bash
        
            ssh -L PORT:localhost:PORT username@beluga.computecanada.ca

Do the qc
:::::::::

If everything worked as expected, open `http://127.0.0.1:8050/ <http://127.0.0.1:8050/>`_ in your favourite browser (or ctrl-click on the given link in the console output).

You can click on the ``pass``, ``maybe``, or ``fail`` button to save the current status of the QC in a json file, to continue the QC later.
The json file is saved under ``$HOME/.fmriprep-qc/${USER}_DATASET.json``, use it to share your results with others.


fmriprep-g
:::::::::

There is also another tool that we discovered in case ours is not working anymore:
https://github.com/nimh-comppsych/fmriprep-group-report
You can find relevant instructions in the repository, then after generating the html files create a bridge as before:
```
ssh -L 8050:localhost:8050 username@beluga.computecanada.ca
cd PATH/TO/GROUP/FOLDER/FROM/fmriprepg
python3 -m http.server 8050
```

Questions ?
:::::::::::

If you have any issues using compute canada, don't hesitate to ask your questions on the SIMEXP lab slack in ``#compute_canada`` channel!
