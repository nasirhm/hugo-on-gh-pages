# Displaying versions
node -v
hugo version

# Get Github auth
if [ -z "${GITHUB_TOKEN}"] && [ -z "${GITHUB_REPO}" ]; then
    echo "Either Github Token or Github Repo is missing." /
    echo "You can set it in Github Secrets as GITHUB_TOKEN GITHUB_REPO variables."
    exit 1
fi

# Check if a Branch is Provided or proceed with master
if [-z "${GITHUB_BRANCH}"]; then 
    GITHUB_BRANCH = "master"
    echo "Github Branch is set to ${GITHUB_BRANCH}"
fi

# Git work
git clone https://${GITHUB_TOKEN}@github.com/${GITHUB_REPO}.git
git checkout hugo-raw 

# Generating Deploy site
hugo -d ready-to-deploy/

# Adding the folder files into the master branch
cd ready-to-deploy/

git checkout master

git add *

git commit -m "Website Deploying"

echo "Website Deploying"

git push origin ${GITHUB_BRANCH}

echo "Deployed"
