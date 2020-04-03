Deep learning on a remote server
================================

You are probably in the case where you would like to use tensorflow on a remote server, to access the computation power from HPC.
It is now relatively easy to have a ready to use environment for your applications, specially for GPUs!

Pre-requisites
::::::::::::::
* Basics use of Linux (cmd line, shell scripting, ssh)
* Our `ssh tutorial <https://github.com/SIMEXP/tutorials/blob/master/ssh_connection/Connect_with_ssh.md>`_
* Basic knowledge on containerized app (Docker, singularity)

What will you learn ?
:::::::::::::::::::::
* Use singularity container
* Work on jupyter notebook for deep learning
* Establish secure connection and port-forwarding from the server to your computer

Why using containers ?
::::::::::::::::::::::

Container technology like `Docker <https://www.docker.com/>`_ is a major breakthrough in data science. 
Indeed, it allows for **reproducible**, **large-scale** and **burden-free environment setup**.
In the mean-time, `jupyter notebook <https://jupyter.org/>`_ provides a portable **interactive coding session**, and is easy to use.

Hand's on
:::::::::

Here, we will learn how to train a deep model on a remote server (could be CRIUGM, or computecanada)
using `singularity <https://singularity.lbl.gov/>`_.

.. note::
    ``singularity`` containers are gaining a lot of popularity in the HPC world, because it is now easy as never to share a reproducible
    pipeline working smoothly on a remote server.

We are using `cifar10 <https://www.cs.toronto.edu/~kriz/cifar.html>`_ dataset using a simple CNN with an encoder with 4 layers,
and 3 dense layers.

.. literalinclude:: files/mnist.py
    :linenos:


Upload your data and conncet to the GPU server
------------------------------------------

1.  Create on your machine a jupyer notebook ``mnist.ipynb`` containing the previous code.

2. Upload the notebook on the server:

    .. code-block:: bash

        rsync -rlt --info=progress2 ``mnist.py`` <user_name>@meleze.criugm.qc.ca:~/path/where/you/want/<my_remote_file>

    .. note::
        We are using the server ``meleze`` which has a GTX 1070, of course you can choose any server you have access to.

2.  Connect to ``meleze``

    .. code-block:: bash

        ssh <user_name>@meleze

We will launch this script using the container `deep-neuro-docker <https://github.com/SIMEXP/deep-neuro-docker>`_ available on github.
It is already installed on our server at ``/data/cisl/CONTAINERS/deep-neuro-docker-gpu.simg``.

.. note::
    The `deep-neuro-docker <https://github.com/SIMEXP/deep-neuro-docker>`_ container is only compatible with `tensorflow 2.0 <https://www.tensorflow.org/versions/r2.0/api_docs/python/tf>`
     for both GPU and CPU.
    Other software like `pytorch <https://pytorch.org/>` are also considered to be included in the future.

Launch the container
--------------------

1.  Load the singularity module to enable it,

    .. code-block:: bash

        module load singularity

2.  Run the tensorflow gpu container,

    .. code-block:: bash

        singularity exec --nv deep-neuro-docker-gpu.simg jupyter notebook --notebook-dir=~/ --no-browser --allow-root

    .. note::
        CPU version is also available using ``singularity exec deep-neuro-docker.simg jupyter notebook --notebook-dir=~/ --no-browser --allow-root``

    .. warning::
        If you installed anaconda on your home folder, you will likely have some trouble because singularity image mounts by default your home to the container.
        It then loads the library from the host instead of the libraries inside the container! To avoid this use this command instead 
        :code:`singularity exec -B <script_path>:/notebooks --no-home deep-neuro-docker.simg jupyter notebook --notebook-dir=/notebooks --no-browser --allow-root`

Work on the notebook remotely
-----------------------------

Create a ssh tunnel so you can work on your browser locally (even if it is running remotely):
    
.. code-block:: bash

    ssh -L 6789:localhost:<server_port> meleze

Where the output from jupyter on the remote host indicates what is the ``<server_port>``, in this example it is ``8889``:

.. image:: img/notebook_weblink
    :width: 400px

.. note::
    Usually, when nobody is using a notebook server, the port will typically be ``8888``.

You can now click on ``http:localhost:6789``, to open the localhost on your browser from your machine.
You will have access to the usual jupyter environment, launch the notebook to check that it is indeed using the GPU!

*If you need other libraries for your application, it is possible to update the container.*

*Please ask to* : @ltetrel