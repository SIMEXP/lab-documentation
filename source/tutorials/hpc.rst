Using super computers from compute canada
=========================================

`Compute-canada <https://www.computecanada.ca/home/>`_ is the provider of High Performance Computers (HPC) that allows you to achieve massive computation speed.
It is a non-profit canadian organization providing free computation power to canadian institutions, so you should use it!

Don't hesitate to check the `compute canada website <https://docs.computecanada.ca/wiki/Running_jobs>`_ for more tutorials.

Pre-requisites
::::::::::::::
* Basics use of Linux (cmd line, shell scripting)
* Our tutorial on :doc:`ssh`
* Basic knowledge on containerized app (Docker, singularity)

What will you learn ?
:::::::::::::::::::::
* Connect to a compute canada node
* Submit a simple job to the server
* Launch a parrallelized containerized app

Connecting to compute canada server
:::::::::::::::::::::::::::::::::::

The first thing to do is to connect to their server!
For that, you will need a compute-canada account:

1.  Go to the `login page <https://ccdb.computecanada.ca/security/login>`_
2.  Click on ``register`` and enter your personnal information.
    For the lab, the insitution is ``udem`` and the department is ``Psychology``.
    You should also ask your sponsor (in our case Pierre Bellec) for his ``CCRI reference number``.
3.  Once your registering is validated, you are ready to ssh into `beluga <https://docs.computecanada.ca/wiki/B%C3%A9luga/en>`_:

    .. code-block:: bash

        ssh <your_username>@beluga.computecanada.ca

.. warning::
    If you can't connect at this point, you would want to check the `server status <https://status.computecanada.ca/>`_.

When you first registered, everything wil be setup automatically so you can continue this tutorial without bothering.

Hand's on
:::::::::

When using HPC, you have to tell it how to interact between your program and the computers. 
Execution of one program is called a *job* and you will require to create a *job script* to interact with the HPCs.
The HPC uses a *job scheduler* called `SLURM <https://slurm.schedmd.com/>`_ to decide when and where the job will be run.

.. note::
    Using a scheduler has few advantages. 

    Because the service is free, it is a way to ensure fair share between all users through
    `scheduling policies <https://docs.computecanada.ca/wiki/Job_scheduling_policies>`_. It is also a way to regularize the usage over time,
    so there is no huge peak of usage at any moment. Finally, submitting a job through a scheduler allow the user to work on other tasks
    independently and in parrallel.

There are two main types of jobs on HPCs, *serial* and *parrallel*.
A *parrallel job* is a way to sumbit multiple jobs at the same time, but each task must be independent from each other.
It is particulary usefull in machine learning when you are selecting hyper-parameters for example.
On the other hand, with a *serial job* you are limited to one task

.. note::
    The serial task can still run in parrallel itself by using multiple cores/cpus.

For the rest of the tutorial, all the files are availables at https://github.com/ltetrel/lab-documentation/source/files

Submit a simple serial job
--------------------------

In this section we will submit our first serial job on the server!
We will create a simple job  that output a sentence using a job script ``simple_job.bash``.

1.  Create a file ``simple_job.bash`` on your computer, this will be your job script that we will submit later to compute canada.

    .. literalinclude:: files/simple_job.bash
        :linenos:
     
    ``#SBATCH`` specify what options you want to give to slurm: ``--time`` is the duration of the job and ``--account`` specifies your organisation (usually your supervisor).
    You can add lot of informations there, just check the `online documentation <https://slurm.schedmd.com/sbatch.html>`_.

2.  Transfer this file from your computer to the server with `rsync <https://linux.die.net/man/1/rsync>`_.
    You can also use `sftp <https://docs.computecanada.ca/wiki/Transferring_data>`_ if you want to encrypt what you are sending.

    .. code:: bash

        rsync -rlt --progress simple_job.bash beluga.computecanada.ca:~/projects/rrg-pbellec/<user_name>/

    .. warning::
        An important practice is to use your home directory inside the lab group ``def-xxx`` like above.
        If you store data in the root directory at ``~``, you will run out of memory fast because `you have just 47GB in there <https://docs.computecanada.ca/wiki/Storage_and_file_management>`_.

3.  Submit the job script with SLURM,

    .. code:: bash

        sbatch simple_job.bash

4.  To check the status of the job in the queue (time remaining, finish status etc..) you can type:

    .. code:: bash

        squeue -u <user_name>

5.  When it is done, the output will be available in a file called ``slurm-<id_of_job>.out``.
    Check that the sentence ``Hello HPC world !`` indeed appears there.

Launch a parrallelized in a containerized app
---------------------------------------------

`Docker <https://docs.docker.com/>`_ is a common and powerfull tool to bundle or "containerize" application into a virtual environment.
This will help you to deploy and share easilly your work, without worrying about the reproducibility of the environment.
You can't use docker on HPCs because you need admin rights to run it, but `singularity <http://singularity.lbl.gov/>`_ is allowed.

Before continuing this tutorial, you should `install the latest singularity <https://singularity.lbl.gov/install-linux>`_ on your computer.

1.  Create a single python script ``par_job.py`` that will output number from :math:`a` to :math:`b`, every 10s.

    .. literalinclude:: files/par_job.py
        :linenos:

    To make sure it is working, type :code:`python par_job.py 1 10`.

2.  Pull a container from `shub <https://singularity-hub.org/>`_ so you can use it to launch your script.

    .. code:: bash

        singularity pull --name anaconda3.simg shub://mjstealey/anaconda3

3.  Test your script inside the container

    .. code:: bash

        singularity --quiet exec anaconda3.simg python par_job.py 1 10

.. note::
    By default, singularity will mount your home inside the container. You can check that ``par_job.py`` is indeed inside the container:
    :code:`singularity --quiet shell anaconda3.simg ls`

4.  Because the jobs will launch in parrallel, we need to specify the parameters for each task.
    One way of doing it is putting all the job parameters inside a file ``params``, where each line is one task.
    Here we will have 10 independent tasks, each running a loop from :math:`n+1` to :math:`n+10`.

    .. literalinclude:: files/params
        :linenos:

5.  Now, transfer the singularity image the python script and the parameters file from your computer to beluga ``~/project/rrg-pbellec/<user_name>/``.

    .. code:: bash

        rsync -rlt --progress anaconda3.simg par_job.py params beluga.computecanada.ca:~/projects/rrg-pbellec/<user_name>/

5.  We will submit a whole batch of jobs with just one script ``simple_ar_job.bash`` using the `job array <https://docs.computecanada.ca/wiki/Running_jobs#Array_job>`_ mechanism.
    This will allows us to run our application in parrallel among many nodes on computecanada.

    .. literalinclude:: files/simple_ar_job.bash
        :linenos:

    The line :code:`#SBATCH --array=1-10` tells you that this is a ``job array`` and you specified here that you will run 10 parrallel jobs.
    Using :code:`--array=1-10%2` you said that no more than 2 jobs will run in parrallel, :code:`--array=1-10:2` is equivalent to :code:`--array=1,3,5,7,9`.
    :code:`PARAMS=$(cat params | head -n $SLURM_ARRAY_TASK_ID| tail -n 1)` is used to read all the parameters that you want to pass to the python script from the file ``params``.
    Take care of the folder mount there, :code:`singularity --quiet exec -B ~/projects/rrg-pbellec/<user_name>/:/scripts`, so the directory on your host 
    ``~/projects/rrg-pbellec/<user_name>/`` is available inside the container at ``/scripts``.

6.  Now you can submit the script to SLURM!

    .. code:: bash

        sbatch simple_ar_job.sh

7.  Verify that your jobs are indeed in the queue:

    .. code:: bash

        squeue -u <user_name>

8.  When your jobs are running, check the process for one job in one of the node by running,

    .. code:: bash

        srun --jobid <job_id> --pty htop -u <user_name>

    Where ``<job_id>`` is the id outputed by ``squeue``.

    .. note::
        `srun <https://slurm.schedmd.com/srun.html>`_ allows you to run a command on the worker
        node through :code:`--pty` argument , in this case ``htop``.

9.  When the jobs are finished, check the log and all the files ``slurm-<jobid>.out``.
    Each of them should contain the numbers ranging from :math:`n+1` to :math:`n+10`.

A few tips
::::::::::

Interactive node 
----------------

It is possible to run interactive jobs on HPCs using the `salloc <https://slurm.schedmd.com/salloc.html>`_ command.
You can use the same parameters as for a sbatch script, for example:

.. code:: bash

    salloc --account=rrg-pbellec --time=00:01:00; echo 'Hello HPC world !'; sleep 5s

There is however a limit of 3h for this type of allocation.
When you need to do some heavy, long duration jobs, you should use the :code:`sbatch` command described above.

.. note::
    Compute canada have good reasons to do constrain the time, interactive nodes are really for short duration development, compiling or debugging of jobs. 
    When running interactive jobs (eg. for a notebook) it is likely that a lot of time will be spent not running anything, preventing other users to use resources.

Debugging your application
--------------------------

It can be an hassle to debug code when using HPC: there is no default graphical forwarding for code editing or debugging.
While it could be easier to use notebooks with an interactive node to debug some resssource intensive jobs, it is often better to combine interactive/non-interactive jobs with standard python files.
Here are the diffrents steps you should follow:

1. Ask for an interactive node and test your job on a small data sample. If it completes with errors, debug your applicaton.
2. Submit a batch script with :code:`sbatch` to ininterruptedly run the heavy part with the full data and, if possible, dump the intermediary results.
3. When your heavy job completes, open an interactive node to explore these results, produce figures, etc...

The following approach should:

* encourage you to write cleaner and reproducible code (structured modules and functions with tests as opposed to often messy linear coded notebook)
* save you a lot of time
* run multiple variations of your analysis/model in parallel, rather than waiting for the heavy-work notebook cell to complete before changing it to test something else
* avoid consuming our allocation for idle jobs, and ensure that we keep an acceptable priority for all members of the lab

Managing large datasets
----------------------

If you are working on machine learning algorithms, you will certainly need to load one of the big dataset that are available on ``beluga``.
One such dataset can be for exemple `cneuromod <https://docs.cneuromod.ca/en/2020-alpha2/>`_.

You might want to directly load the dataset from the global filesystem (at ``~/projects/rrg-pbellec``) to feed your model, but this not a good idea.
Indeed, this filesystem is slow, and because it is shared between many (many) users, you will likely expect lot of latency and slow I/O speed (and is the worth case data cache misses..).
The best way to go is to sync the data ``~/projects/rrg-pbellec`` to the local compute node storage ``/localscratch/$USER.13055121.0`` (usually reffered as scratch space).
The scratch path is different for each compute node, and because you will be allocated a new compute node each time, it is better to use the environment variable ``$SLURM_TMPDIR``.

.. note::
    The scratch space is just a SSD mounted directly on the compute node.
    This is why it is much faster than the global filesystem (usually accessed through ``nfs``).

.. warning::
    One might expect a ``disk quota exceeded`` when transfering data to the scratch space.
    this is because this SSD is shared between other users who have also accessed the compute node.
    To avoid this, you can access a whole node to make sure you have access to all the local storage.
    Check the `nodes characteristic <https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics>`_ to know how much scratch space it has.
   

Another important point is that if your dataset contains a lof of files (more than a thousand), ``rsync`` can take some time to build the file list.
To reduce the transfer time, you will want to create this file list before using rsync. 
Here is a concrete example with neuromod:

.. code:: bash

    # create the file liste before (outside of the SLURM script)
    # in this example we include `sub-01` and `sub-02`, and exclude `.git`
    cd ~/projects/rrg-pbellec/datasets/cneuromod_new/hcptrt/
    find . -type f -printf '%h\0%d\0%p\n' | sort -t '\0' -n | awk -F'\0' '{print $3}' | grep -e sub-01 sub-02 | grep -v .git > ~/list_files_neuromod
    # now use the below inside a SLURM script
    mkdir $SLURM_TMPDIR/hcptrt
    rysnc -avP --info=progress2 --files-from=~/list_files_neuromod projects/rrg-pbellec/datasets/cneuromod_new/hcptrt $SLURM_TMPDIR/hcptrt

Finally, remember that if you need to transfer data from two different servers (for example from ``elm`` to ``beluga``), it is better to use `globus <https://docs.computecanada.ca/wiki/Globus>`_.
Check the `compute canada documentation <https://docs.computecanada.ca/wiki/Storage_and_file_management>`_ for more details on this topic.

SLURM notifications on slack
----------------------------

It is possible to allow slack to send you notifications when a job is running, finished etc.. 

First create a mail in slack in ``preferences`` under ``messages and media`` section.
Then, you can use the provided email address to let SLURM send you notifications in slack (it will be sent by the *slackbot*).
Just insert the following in your ``.sh`` job script:

.. code-block:: bash
    :linenos:

    #SBATCH --mail-user=XXXX@simexp.slack.com 
    #SBATCH --mail-type=BEGIN
    #SBATCH --mail-type=END

.. image:: img/slackMail.png
  :width: 400px

Questions ?
:::::::::::

If you have any issues using compute canada, don't hesitate to ask your questions on the SIMEXP lab slack in ``#compute_canada`` channel!