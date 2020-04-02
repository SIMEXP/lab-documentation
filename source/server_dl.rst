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

Here, we will learn how to launch your favourite notebooks on a remote server (could be CRIUGM, or computecanada)
using `singularity <https://singularity.lbl.gov/>`_.

.. note::
    ``singularity`` containers are gaining a lot of popularity in the HPC world, because it is now easy as never to share a reproducible
    pipeline working smoothly on a remote server.

We will work on the really known `cifar10 <https://www.cs.toronto.edu/~kriz/cifar.html>`_ dataset using simple CNN with an encoder with 4 layers,
and 3 dense layers.

.. code-block::


Upload your data in the server
------------------------------

1. Upload the notebook(s)
```
rsync -rlt --info=progress2 <my_local_file> <user_name>@thuya.criugm.qc.ca:~/path/where/you/want/<my_remote_file>
```

1. upload the database
```
rsync -rlt --info=progress2 <my_local_database> ${USER}@thuya.criugm.qc.ca:~/path/where/you/want/<my_remote_database>
```
**Please ensure that the data is not already available somewhere on** `/data/cisl`

Connect to the desired server
-----------------------------

1.  Open a cmd prompt

2.  Connect to ``meleze`` (passwordless authentification is assumed)

    .. code-block:: bash

        ssh <user_name>@meleze

### Launch the container

1. go to `/data/cisl/CONTAINERS`
```
cd /data/cisl/CONTAINERS

```
2. run the tensorflow cpu image
```
singularity exec -B <notebook_path>:/notebooks deep-neuro-docker.simg jupyter notebook --notebook-dir=/notebooks --no-browser --allow-root
```
or the GPU version with the `--nv` option
```
singularity exec --nv -B <notebook_path>:/notebooks deep-neuro-docker-gpu.simg jupyter notebook --notebook-dir=/notebooks --no-browser --allow-root
```

If you have a user space on the server and installed anaconda, you could have some trouble because singularity image mounts by default your home to the container. It can then load the library from the server/your local computer instead of the libraries inside the container !
To avoid this please use this command instead :
```
singularity exec -B <notebook_path>:/notebooks,<notebook_path>:/home/$USER --no-home deep-neuro-docker.simg jupyter notebook --notebook-dir=/notebooks --no-browser --allow-root
```
### Work on the notebook remotely !

1. Open a **new command prompt**

2. Create a ssh tunnel so you can work on your browser locally (even if it is running remotely)
```
ssh -L <server_port>:localhost:<server_port> pin
```
Where the output from jupyter on the remote indicates you the server port that is in use `http://localhost:<server_port>` :

<img src="notebook_weblink.png" width="500">

If nobody is using the server ports, it will be usually `8888`.

3. You can now just open a web browser with the jupyter hyperlink

*If you need other libraries for your application, it is possible to update the container.*

*Please ask to* : @ltetrel