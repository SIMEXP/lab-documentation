A tutorial for fmriprep on Beluga
=================================

When you start `fmriprep <https://fmriprep.readthedocs.io/en/stable/singularity.html#internet-access-problems>`_ 
it tries to check for updates and to download the standard space brain template you have specified with 
``--output-spaces``. Because the compute nodes on `Beluga <https://docs.computecanada.ca/wiki/B%C3%A9luga/en>`_ 
cannot access the internet, we need to download these things in advance.

Luckily, on beluga that has already happened for the default template files. They are located here:
::
/lustre03/project/6003287/datasets/templateflow


Now we need to let fmriprep know, where they are. First, before we call fmriprep, we set the environment variable like so
::
export SINGULARITYENV_TEMPLATEFLOW_HOME=/home/fmriprep/.cache/templateflow


Next, we bind the tempflow directory on beluga to the mountpoint inside the singularity container by adding:
::
-B /lustre03/project/6003287/datasets/templateflow:/home/fmriprep/.cache/templateflow


to the singularity command.

And finally, we need to prevent fmriprep from trying to telephone home. We can achieve this by adding another flag to 
the singularity command:
::
--notrack


So a final singularity command might look like this:
::
export SINGULARITYENV_TEMPLATEFLOW_HOME=/home/fmriprep/.cache/templateflow
singularity run --cleanenv -B /lustre03/project/6003287/datasets/templateflow:/home/fmriprep/.cache/templateflow -B /path/to/data:/DATA -B /path/to/output:/OUT /home/surchs/containers/fmriprep-20-0-7.simg /DATA /OUT participant --participant-label sub-001  --notrack