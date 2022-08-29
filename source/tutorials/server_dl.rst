Deep learning on a remote server
================================

You are probably in the case where you would like to use tensorflow on a remote server, to access the computation power from HPC.
It is now relatively easy to have a ready to use environment for your applications, specially for GPUs!

Pre-requisites
::::::::::::::
* Our tutorial on :doc:`unix_intro`
* Our tutorial on :doc:`ssh`
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

Here, we will learn how to train a deep model on a remote server (could be CRIUGM, or Alliance Canada)
using `singularity <https://singularity.lbl.gov/>`_.

.. note::
    ``singularity`` containers are gaining a lot of popularity in the HPC world, because it is now easy as never to share reproducible
    applications working smoothly on a remote server.

We are using `cifar10 <https://www.cs.toronto.edu/~kriz/cifar.html>`_ dataset using a simple CNN containing an encoder with 4 layers,
and 3 dense layers.

.. literalinclude:: files/mnist.py
    :linenos:


Upload your data and connect to the GPU server
----------------------------------------------

1.  Create a jupyer notebook ``mnist.ipynb`` on your machine , containing the previous code.

2.  Upload the notebook on the server:

    .. code-block:: bash

        rsync -rlt --info=progress2 mnist.ipynb <user_name>@meleze.criugm.qc.ca:~/

    .. note::
        We are using the server ``meleze`` which has a GTX 1070, of course you can choose any server you have access to.

3.  Connect to ``meleze``

    .. code-block:: bash

        ssh <user_name>@meleze

Launch the container
--------------------

We will now launch this notebook using the container `deep-neuro-docker <https://github.com/SIMEXP/deep-neuro-docker>`_, 
already installed on our server at ``/data/cisl/CONTAINERS/deep-neuro-docker-gpu.simg``.
It is a ready to use jupyter environment with `tensorflow 2.0 <https://www.tensorflow.org/versions/r2.0/api_docs/python/tf>`_ for both GPU and CPU.

.. note::
    Other software like `pytorch <https://pytorch.org/>`_ are also considered to be included in the future.


1.  Load the singularity module to enable it,

    .. code-block:: bash

        module load singularity

2.  Run the tensorflow gpu container,

    .. code-block:: bash

        singularity exec --nv /data/cisl/CONTAINERS/deep-neuro-docker-gpu.simg jupyter notebook --notebook-dir=~/ --no-browser --allow-root

    .. note::
        CPU version is also available using the ``deep-neuro-docker.simg`` container.

    .. warning::
        If you installed anaconda on your home folder, you will likely have some trouble because singularity image mounts by default your home to the container.
        It then loads the library from the host instead of the libraries inside the container! To avoid this, use the following command instead:
        :code:`singularity exec -B <path/to/notebook>:/notebooks --no-home deep-neuro-docker-gpu.simg jupyter notebook --notebook-dir=/notebooks --no-browser --allow-root`

Work on the notebook remotely from home
---------------------------------------

Because you are in your own home network, you will need to use ``elm`` as an external bridge to the criugm network.
Create two ssh tunnels so you can work on your browser locally (even if it is running remotely):

.. code-block:: bash

    ssh -L 6789:localhost:6789 elm.criugm.qc.ca
    ssh -L 6789:localhost:<server_port> meleze

Where the output from jupyter on the remote server indicates what is the ``<server_port>``, in this example it is ``8889``:

.. image:: img/notebook_weblink.png
    :width: 600px

.. note::
    If nobody uses a notebook server on the remote, ``<server_port>`` will typically be ``8888``.

.. note::
    If you are inside the criugm network via ethernet (not wi-fi), you have direct access to the compute servers (meleze, ginkgo etc..).
    In this case you don't need to use ``elm``, just connect directly to ``meleze`` :code:`ssh -L 6789:localhost:<server_port> meleze`.

Click on `http://localhost:6789 <http://localhost:6789>`_, to open the localhost on your browser from your machine.
You should have now access to the usual jupyter environment, launch ``mnist.ipynb`` to check that it is indeed using the GPU!

Questions ?
:::::::::::

If you have any issues using jupyter notebooks, you can ask on the SIMEXP lab slack in ``#python`` channel!
For any other questions related to setup (containers) ask in ``#neuroinformatics``.