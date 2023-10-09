# Setup

```
# pull docker image. The image is 6GB. 
docker pull ghcr.io/lovetatting/vasaikar_analysis:1.0


# pwd should be the current directory of the README file. 
# the folder 'stage' is volume mounted to the container and,
#   1) contains the RMarkdown script and source data,
#   2) will contain any output files

docker run -v $(pwd)/stage:/home/ruser/workdir -w /home/ruser/workdir ghcr.io/lovetatting/vasaikar_analysis:1.0


```
