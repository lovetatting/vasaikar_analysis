# Setup

For manual copy and pasting, follow below. The file unix may be sourced on a unix machine (bash) as
well. .

```
# clone repo to current directory
git clone git@github.com:lovetatting/vasaikar_analysis.git

# change directory to the repo
cd vasaikar_analysis

# pull docker image. The image is 6GB. Can also skip to next step as
# it will be downloaded automatically.  
docker pull ghcr.io/lovetatting/vasaikar_analysis:1.0


# pwd should be the current directory of the README file. 
# the folder 'stage' is volume mounted to the container and,
#   1) contains the RMarkdown script and source data,
#   2) will contain any output files

docker run -v $(pwd)/stage:/home/ruser/workdir -w /home/ruser/workdir ghcr.io/lovetatting/vasaikar_analysis:1.0

# In the folder 'stage', analysis output files and the rendered pdf can be found (Vasaikar.pdf).
 

```
