FROM ubuntu:latest
MAINTAINER Anthony Rose "anthony_rose12@hotmail.com"

# Ubuntu setup
RUN apt update --yes
RUN apt install wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 --yes
RUN apt install git mercurial subversion --yes

# Get Miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p /miniconda

ENV PATH=/miniconda/bin:${PATH}
RUN echo $PATH

RUN conda update conda --yes
RUN conda config --add channels conda-forge

# Copy everything into the folder and move on from there
COPY . /app
ENV HOME=/app
WORKDIR /app

# Install requirements
RUN conda install --yes --file requirements.txt

RUN echo quick python test
RUN python test.py

# Open port
EXPOSE 5000

# Turn on backend
ENTRYPOINT ["python"]
CMD ["app.py"]
