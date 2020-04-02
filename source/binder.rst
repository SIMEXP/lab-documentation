A binder tutorial
=================

This is a short tutorial on how to create a binder executable environment.



What is Binder ?
::::::::::::::::

Binder allows you to execute and share notebooks to anyone using the web.
The way `Binder <https://github.com/jupyterhub/binderhub>`_ download the notebooks is through a GitHub repo, where the user should specify the environment to run them.
This make your work reproducible and shareable very easy like never before!

It ties together many technologies :

* `Docker <https://www.docker.com/>`_, a tool that emphasizes reproducibility by packaging your applications into containers to run them from any host.
* `JupyterHub <https://jupyter.org/hub>`_, which uses `kubernetes <https://kubernetes.io/>`_ to share multiple instances of notebooks among many users.
* `repo2docker <https://github.com/jupyter/repo2docker>`_, a tool that converts GitHub repositories into Jupyter-enabled Docker images.

How to upload a work on Binder ?
::::::::::::::::::::::::::::::::

Have a GitHub account (GitLab, Gist also supported).

Create a repository with at leat one notebook (your work), and its dependencies listed in a file requirements.txt.

Build your repository into a Docker image that will host your interactive notebooks : https://mybinder.org/

You can now share the link of the environment to anyone who has a browser !
Few tips

    You can find other examples here.

    If you execute your notebook before pushing it to github, any user that open the session will have a ready to play environment (without the need to re-execute the notebook).

    You can add a badge in your repository. When clicking to this badge, anyone can access the executable environment in an easy way ! Just add this snippet to your README:

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/<user_name>/<repo_name>/master)

    Adding ?urlpath=lab at the end of the link will open a jupyter lab environment. You can also point to a notebook with ?filepath=notebooks%2Fnilearn-example.ipynb !
