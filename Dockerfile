# Base image from Jupyter Docker Stacks 
# Minimal Jupyter Notebook Python Stack
ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER
LABEL author="UTB"

USER root
# Install dependencies
RUN pip install pandas numpy matplotlib plotly jupyter_kernel_gateway

# Switch back to user 
USER $NB_UID

# Copy local files to work container directory
#WORKDIR /ai
COPY . $HOME/

# Switch back to root
USER root

EXPOSE 9000

# Run the service:
CMD ["jupyter", "kernelgateway",  "--KernelGatewayApp.api=kernel_gateway.notebook_http", "--KernelGatewayApp.ip=0.0.0.0", "--KernelGatewayApp.port=9000", "--KernelGatewayApp.seed_uri=/home/jovyan/Students.ipynb", "--KernelGatewayApp.allow_origin=*"]
