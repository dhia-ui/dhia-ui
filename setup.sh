#!/bin/bash
# Deploy the new GitHub profile README + assets
# Usage: place this script in the same folder as README.md and assets/,
# then run: bash setup.sh

set -e

GITHUB_USER="dhia-ui"
REPO_DIR="${GITHUB_USER}-profile-readme"

echo "==> Cloning your profile repo (github.com/${GITHUB_USER}/${GITHUB_USER})..."
git clone "https://github.com/${GITHUB_USER}/${GITHUB_USER}.git" "$REPO_DIR" || {
  echo "Repo doesn't exist yet. Create it first:"
  echo "  1. Go to https://github.com/new"
  echo "  2. Repository name MUST be exactly: ${GITHUB_USER}"
  echo "  3. Make it Public, check 'Add a README file', then create it."
  echo "  4. Re-run this script."
  exit 1
}

echo "==> Copying files in..."
mkdir -p "${REPO_DIR}/assets"
cp README.md "${REPO_DIR}/README.md"
cp assets/visual-map.gif "${REPO_DIR}/assets/visual-map.gif"
cp assets/system-info.png "${REPO_DIR}/assets/system-info.png"
cp assets/projects-grid.png "${REPO_DIR}/assets/projects-grid.png"

cd "$REPO_DIR"
echo "==> Committing and pushing..."
git add README.md assets/visual-map.gif assets/system-info.png assets/projects-grid.png
git commit -m "Redesign profile README: terminal theme + particle-to-photo reveal"
git push origin main || git push origin master

echo "==> Done. Check https://github.com/${GITHUB_USER}"
