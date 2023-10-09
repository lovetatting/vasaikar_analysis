# Use an official R base image
FROM rocker/r-ver:latest

# Create a new user 'ruser'
# RUN useradd -m ruser

# Set working directory to ruser's home directory
# WORKDIR /home/ruser

RUN apt-get update && apt-get install -y \
    libharfbuzz-dev \
    libfribidi-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libmagick++-dev \
    libpoppler-cpp-dev \
    libcairo2-dev \
    libxt-dev \
    libssh2-1-dev \
    libpq-dev \
    libgdal-dev \
    libproj-dev \
    qpdf \
    libjpeg-dev \
    libpng-dev \
    texlive-full \
    python3 \
    python3-pip \
    pandoc \
    cmake \ 
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install mofapy2

RUN R -e "update.packages(ask = FALSE)"

# Install BiocManager and Bioconductor packages as root
RUN R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install('PALMO')"
RUN R -e "BiocManager::install(version = '3.18', ask = F)"
RUN R -e "BiocManager::install('MOFA2', version = 'devel')"
RUN R -e "BiocManager::install('org.Hs.eg.db', ask = F)"
RUN R -e "BiocManager::install('MOFAdata', ask = F)"

# Install CRAN packages in batches for layering
RUN R -e "install.packages('tidyverse', dependencies=TRUE)"
RUN R -e "install.packages(c('readxl', 'kableExtra', 'pander', 'ggpubr', 'reticulate'), dependencies=TRUE)"
RUN R -e "install.packages(c('magrittr', 'scales', 'patchwork', 'Hmisc', 'naniar', 'MASS'), dependencies=TRUE)"
RUN R -e "install.packages(c('visdat', 'UpSetR', 'VIM', 'impute', 'factoextra'), dependencies=TRUE)"
RUN R -e "install.packages(c('FactoMineR', 'Rtsne', 'M3C', 'RColorBrewer', 'qpdf'), dependencies=TRUE)"
RUN R -e "install.packages(c('pheatmap', 'mice', 'writexl', 'gridExtra', 'pdftools'), dependencies=TRUE)"

RUN apt-get update && apt-get install -y libgit2-dev

RUN R -e "install.packages(c('cowplot', 'devtools'), dependencies=TRUE)"

RUN R -e "library('devtools'); install_github('aifimmunology/PALMO')"

RUN R -e "BiocManager::install('impute', ask = F)"
RUN R -e "BiocManager::install('M3C', ask = F)"

RUN apt-get update && apt-get install -y sed

RUN sed -i 's/rights="none" pattern="PDF"/rights="read|write" pattern="PDF"/' /etc/ImageMagick-6/policy.xml

RUN R -e "BiocManager::install('clusterProfiler', ask = F)"

# Switch to ruser for executing the container
# USER ruser

# Set ENTRYPOINT to use Rscript to knit the RMarkdown file to PDF
ENTRYPOINT ["Rscript", "-e", "rmarkdown::render(input = commandArgs(trailingOnly = TRUE)[1])"]

# Set the default RMarkdown filename (e.g., 'Vasaikar.Rmd')
CMD ["Vasaikar.Rmd"]

