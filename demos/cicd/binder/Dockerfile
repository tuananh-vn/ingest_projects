FROM natbusa/datalabframework

USER root

# add apt, conda and pip installs
RUN mkdir /home/$NB_USER/binder
COPY environment.yml /home/$NB_USER/binder

#fix permissions
RUN fix-permissions /home/$NB_USER/binder

# Run the env update in as non-privileged user
USER $NB_USER
RUN conda env update -n base -f /home/$NB_USER/binder/environment.yml && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Ready to go: switch to user $NB_USER
USER $NB_USER
