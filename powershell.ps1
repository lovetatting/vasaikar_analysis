# 0. Check prerequisites: git and docker
# --------------------------------------

# Check for git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Error: git is not installed. Please install git and try again."
    exit
}

# Check for docker
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Error: Docker is not installed. Please install Docker and try again."
    exit
}

# 1. Clone the repository to the current directory
# -----------------------------------------------
try {
    git clone git@github.com:lovetatting/vasaikar_analysis.git
} catch {
    Write-Error "Error: Failed to clone the repository."
    exit
}

# 2. Change directory to the repo
# -------------------------------
try {
    Set-Location -Path .\vasaikar_analysis
} catch {
    Write-Error "Error: Failed to navigate into the repository directory."
    exit
}

# 3. Optionally pull the Docker image
# -----------------------------------
try {
    docker pull ghcr.io/lovetatting/vasaikar_analysis:1.0
} catch {
    Write-Warning "Warning: Failed to pull the Docker image. It will be downloaded automatically in the next step."
}

# 4. Run the Docker image
# -----------------------
try {
    docker run -v "${PWD}\stage:/home/ruser/workdir" -w /home/ruser/workdir ghcr.io/lovetatting/vasaikar_analysis:1.0
} catch {
    Write-Error "Error: Failed to run the Docker image."
    exit
}

# 5. Check the output
# -------------------
Write-Output "Analysis complete. Check the 'stage' folder for output files and the rendered PDF (Vasaikar.pdf)."

