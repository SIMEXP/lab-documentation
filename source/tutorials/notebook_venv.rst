Jupyter notebooks and python virtual environment
================================================

`Jupyter Notebook <https://jupyter.org/>`_ is an open document format based on JSON. 
They are really popular in the data science community for its ease of use, interactivity and shareability.
When using `python virtual environment <https://docs.python.org/3/library/venv.html>`_, it can be tricky to make it available inside your notebook.

This tutorial is intended to guide you through the different steps to make your venv compatible.

.. Note::
  If you want to share your work to others ine the group, we advice you to instead create a singularity image.
  Check our tutorial on using a singularity image remotely for more information :doc:`server_dl`.
  The virtual environment was not really designed to be shared.

Pre-requisites
::::::::::::::
* Our tutorial on :doc:`unix_intro`
* Knowledge on python packages (pip)

What will you learn ?
:::::::::::::::::::::
* Create a python virtual environment
* Use a jupyter notebook inside a virtual environment

Creation of the virtual environment
:::::::::::::::::::::::::::::::::::

We will first setup a python virtual environment.
Obviously if you already have one you can skip this section.

.. code:: bash

  mkdir ~/.virtualenvs
  python3 -m venv ~/.virtualenvs/MY_NEW_ENV

Then we will activate the environment and install the dependencies that you need for your notebook:

.. code:: bash

  source ~/.virtualenvs/MY_NEW_ENV/bin/activate
  python3 -m pip install ...

Adding the environment to jupyter
:::::::::::::::::::::::::::::::::
If you are inside a virtual environment at this step, you will first need to `deactivate` it:

.. code:: bash

  deactivate
  
The next step is to add a new `ipython kernel <https://ipython.org/>`_ which points to your environment.
You can see an ipython kernel as an execution backend for jupyter.

.. code:: bash

  python3 -m pip install ipykernel
  python3 -m ipykernel install --user --name MY_NEW_ENV

Access the jupyter interface:

.. code:: bash

  jupyter notebook

You should now `see your kernel in the notebook interface <https://doc.cocalc.com/howto/jupyter-kernel-selection.html>`_.
Switch the notebook kernel to MY_NEW_ENV.

.. Note::
  You can check the list of existing kernel on your computer with the command:

  .. code:: bash
  
    jupyter kernelspec list


Updating the environment
::::::::::::::::::::::::

If you need to update the modules in the environment, you just need to activate the environment and install what you need:

.. code:: bash

  source ~/.virtualenvs/MY_NEW_ENV/bin/activate
  python3 -m pip install ...

You don't need to change anything on the jupyter side because it points to your environment under the hood.

Questions ?
:::::::::::

If you have any issues using jupyter notebooks, you can ask on the SIMEXP lab slack in ``#python`` channel!
