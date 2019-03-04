FROM r-base

MAINTAINER Michele Mastrogiovanni <michele.mastrogiovanni@gmail.com>

RUN apt-get update && \
        apt-get install -y --no-install-recommends \
        curl \
        libcurl4-openssl-dev \
        openjdk-8-jdk \
        texlive-full \
	expat libexpat1-dev zlib1g-dev \ 
        pandoc \
        xzdec

# COPY texlive.tar.gz /texlive.tar.gz
# COPY texlive.tar.gzaa /texlive.tar.gzaa
# COPY texlive.tar.gzab /texlive.tar.gzab
# RUN cd / && cat x* | tar -xvzf -
#RUN cd / && wget https://www.dropbox.com/s/xrtgsnzkvxhwvap/texlive.tar.gz?dl=0 && tar -xvzf texlive.tar.gz

RUN Rscript -e 'install.packages("webutils")' && \
        Rscript -e 'install.packages("jug")' && \
        Rscript -e 'install.packages("gdata")' && \
        Rscript -e 'install.packages("dplyr")' && \
        Rscript -e 'install.packages("knitr")' && \
        Rscript -e 'install.packages("ggplot2")' && \
        Rscript -e 'install.packages("rmarkdown")'

ENV PERL5LIB /usr/local/lib/x86_64-linux-gnu/perl/5.26.2 
ENV PERL_MM_USE_DEFAULT 1
ENV INSTALL_BASE /usr/local/lib/x86_64-linux-gnu/perl/5.26.2/
RUN perl -MCPAN -e 'install Spreadsheet::ParseXLSX'

# Java support
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN R CMD javareconf

# # XLSX parser java-based
RUN Rscript -e 'install.packages("XLConnect")'

# Latex package import
# RUN tlmgr install collection-fontsrecommended

RUN tlmgr init-usertree && \
        tlmgr install ec && \
        tlmgr install titling

