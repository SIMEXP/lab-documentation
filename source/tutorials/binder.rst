Executable environment on the cloud with Binder
===============================================

Binder allows you to execute and share notebooks to anyone using the web.
The way `Binder <https://github.com/jupyterhub/binderhub>`_ download the notebooks is through a GitHub repo, where the user should specify the environment to run them.
This make your work reproducible and shareable very easy like never before!

It ties together many technologies :

* `Docker <https://www.docker.com/>`_, a tool that emphasizes reproducibility by packaging your applications into containers to run them from any host.
* `JupyterHub <https://jupyter.org/hub>`_, which uses `kubernetes <https://kubernetes.io/>`_ to share multiple instances of notebooks among many users.
* `repo2docker <https://github.com/jupyter/repo2docker>`_, a tool that converts GitHub repositories into Jupyter-enabled Docker images.

Pre-requisites
::::::::::::::
* GitHub ease
* Basic knowledge on python packages (pip)

What will you learn ?
:::::::::::::::::::::
* Create a binder link

How to upload a work on Binder ?
::::::::::::::::::::::::::::::::

Of course, you will need a GitHub account (GitLab, Gist also supported).
After you can:

1.  Create a repository with at least one notebook (your work).
2.  Make the ``requirements.txt`` file, containing all the dependencies for your notebook(s).
3.  Build your repository into a Docker image that will host your interactive notebooks : https://mybinder.org/
4.  After few seconds, the link to share your notebook(s) from your GitHub repository are ready. Share it to anyone who has an internet browser!

Check `this repo <https://github.com/ltetrel/binder-tuto>`_, it contains all the necessary requirements.

A few tips
::::::::::

Hosting the static execution
----------------------------

If you execute your notebook before pushing it to github, any user that open the session will have a ready to play environment (without the need to re-execute the notebook).

Binder badge
------------

You can add a badge in your repository:

.. image:: https://mybinder.org/badge_logo.svg
    :target: https://mybinder.org/v2/gh/ltetrel/binder-tuto/master?filepath=notebooks%2Fnilearn-example.ipynb

When clicking on this badge, anyone can access the executable environment in an easy way.
Just add this snippet to your file, it can be either a ``.md`` or ``.rst``:

.. image:: https://mybinder.org/badge_logo.svg
  :target: https://mybinder.org/v2/gh/ltetrel/binder-tuto/master?filepath=notebooks%2Fnilearn-example.ipynb

JupyterLab
----------

`JupyterLab <https://jupyterlab.readthedocs.io/en/stable/>`_ is a more powerfull web IDE for jupyter notebooks.
Adding ``?urlpath=lab`` at the end of the link will open a jupyter lab environment.

Pointing to a specific notebook
-------------------------------

You can point to a specific notebook ``nilearn-example.ipynb`` by adding ``?filepath=notebooks%2Fnilearn-example.ipynb`` at the end of the binder url.

.. note::
    The slashes ``/`` are replaced by ``%2F``.

Questions ?
:::::::::::

If you have any issues using compute canada, don't hesitate to ask your questions on the SIMEXP lab slack in ``#conp`` channel!
