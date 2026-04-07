FROM repbioinfo/biohackaton:latest

LABEL maintainer="Luca & Davide - YoungInfoLife RNA-seq Webinar"
LABEL description="Bulk RNA-seq pipeline: QC -> trimming -> alignment -> count matrix"

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        curl \
        unzip \
        bzip2 \
        xz-utils \
        ca-certificates \
        git \
        default-jdk \
        perl \
        build-essential \
        gfortran \
        pkg-config \
        xxd \
        libncurses5-dev \
        libncursesw5-dev \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libreadline-dev \
        libx11-dev \
        libxt-dev \
        libpng-dev \
        libjpeg-dev \
        libcairo2-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libtiff5-dev \
        libicu-dev \
        libharfbuzz-dev \
        libfribidi-dev \
        libblas-dev \
        liblapack-dev \
        jupyter-core \
    && rm -rf /var/lib/apt/lists/*

ARG SAMTOOLS_VERSION=1.19
RUN wget -q https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 \
    && tar -xjf samtools-${SAMTOOLS_VERSION}.tar.bz2 \
    && cd samtools-${SAMTOOLS_VERSION} \
    && ./configure --prefix=/usr/local \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && rm -rf samtools-${SAMTOOLS_VERSION}*

ARG STAR_VERSION=2.7.11b
RUN wget -q https://github.com/alexdobin/STAR/archive/refs/tags/${STAR_VERSION}.tar.gz -O STAR-${STAR_VERSION}.tar.gz \
    && tar -xzf STAR-${STAR_VERSION}.tar.gz \
    && cd STAR-${STAR_VERSION}/source \
    && make STAR -j$(nproc) \
    && cp STAR /usr/local/bin/ \
    && cd / \
    && rm -rf STAR-${STAR_VERSION} STAR-${STAR_VERSION}.tar.gz

ARG FASTQC_VERSION=0.12.1
RUN wget -q https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VERSION}.zip \
    && unzip -q fastqc_v${FASTQC_VERSION}.zip \
    && chmod +x FastQC/fastqc \
    && mv FastQC /opt/FastQC \
    && ln -s /opt/FastQC/fastqc /usr/local/bin/fastqc \
    && rm -f fastqc_v${FASTQC_VERSION}.zip

RUN pip install --no-cache-dir \
        cutadapt \
        multiqc \
        pandas \
        numpy \
        matplotlib \
        seaborn

ARG TRIMGALORE_VERSION=0.6.11
RUN wget -q https://github.com/FelixKrueger/TrimGalore/archive/${TRIMGALORE_VERSION}.tar.gz -O TrimGalore-${TRIMGALORE_VERSION}.tar.gz \
    && tar -xzf TrimGalore-${TRIMGALORE_VERSION}.tar.gz \
    && cp TrimGalore-${TRIMGALORE_VERSION}/trim_galore /usr/local/bin/ \
    && chmod +x /usr/local/bin/trim_galore \
    && rm -rf TrimGalore-${TRIMGALORE_VERSION} TrimGalore-${TRIMGALORE_VERSION}.tar.gz

ARG SUBREAD_VERSION=2.0.6
RUN wget -q https://sourceforge.net/projects/subread/files/subread-${SUBREAD_VERSION}/subread-${SUBREAD_VERSION}-Linux-x86_64.tar.gz/download -O subread-${SUBREAD_VERSION}-Linux-x86_64.tar.gz \
    && tar -xzf subread-${SUBREAD_VERSION}-Linux-x86_64.tar.gz \
    && mv subread-${SUBREAD_VERSION}-Linux-x86_64 /opt/subread \
    && ln -s /opt/subread/bin/featureCounts /usr/local/bin/featureCounts \
    && ln -s /opt/subread/bin/subread-align /usr/local/bin/subread-align \
    && rm -f subread-${SUBREAD_VERSION}-Linux-x86_64.tar.gz

ARG SRATOOLS_VERSION=3.0.10
RUN wget -q https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${SRATOOLS_VERSION}/sratoolkit.${SRATOOLS_VERSION}-ubuntu64.tar.gz \
    && tar -xzf sratoolkit.${SRATOOLS_VERSION}-ubuntu64.tar.gz \
    && mv sratoolkit.${SRATOOLS_VERSION}-ubuntu64 /opt/sratoolkit \
    && ln -s /opt/sratoolkit/bin/fasterq-dump /usr/local/bin/fasterq-dump \
    && ln -s /opt/sratoolkit/bin/prefetch /usr/local/bin/prefetch \
    && ln -s /opt/sratoolkit/bin/fastq-dump /usr/local/bin/fastq-dump \
    && rm -f sratoolkit.${SRATOOLS_VERSION}-ubuntu64.tar.gz

ARG R_VERSION=4.5.1
RUN cd /tmp \
    && wget -q https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz \
    && tar -xzf R-${R_VERSION}.tar.gz \
    && cd R-${R_VERSION} \
    && ./configure \
        --prefix=/opt/R/${R_VERSION} \
        --enable-R-shlib \
        --with-blas \
        --with-lapack \
    && make -j$(nproc) \
    && make install \
    && cd / \
    && rm -rf /tmp/R-${R_VERSION} /tmp/R-${R_VERSION}.tar.gz

ENV R_HOME=/opt/R/4.5.1/lib/R
ENV PATH=/opt/R/4.5.1/bin:${PATH}

RUN /opt/R/4.5.1/bin/Rscript /tmp/install_r451_packages.R \
    && rm -f /tmp/install_r451_packages.R

RUN echo "=== Tool versions ===" \
    && STAR --version \
    && samtools --version | head -1 \
    && fastqc --version \
    && featureCounts -v 2>&1 | head -1 \
    && trim_galore --version 2>&1 | head -5 \
    && multiqc --version \
    && fasterq-dump --version 2>&1 | head -1 \
    && /opt/R/4.5.1/bin/Rscript -e 'cat("R: ", as.character(getRversion()), "\n", sep=""); cat("BiocManager: ", as.character(packageVersion("BiocManager")), "\n", sep=""); cat("ComplexHeatmap: ", as.character(packageVersion("ComplexHeatmap")), "\n", sep=""); cat("DESeq2: ", as.character(packageVersion("DESeq2")), "\n", sep=""); cat("ggplot2: ", as.character(packageVersion("ggplot2")), "\n", sep=""); cat("RColorBrewer: ", as.character(packageVersion("RColorBrewer")), "\n", sep=""); cat("IRkernel: ", as.character(packageVersion("IRkernel")), "\n", sep="")' \
    && jupyter kernelspec list \
    && echo "All tools OK"

RUN mkdir -p /data/fastq \
             /data/fastq_trimmed \
             /data/reference \
             /data/star_index \
             /data/alignments \
             /data/counts \
             /data/fastqc_raw \
             /data/fastqc_trimmed \
             /data/multiqc_raw \
             /data/multiqc_trimmed \
             /data/multiqc_alignment \
             /notebooks \
    && chmod -R 777 /data /notebooks

WORKDIR /notebooks

COPY notebooks/ /notebooks/

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--notebook-dir=/notebooks", "--ServerApp.token=", "--ServerApp.password="]