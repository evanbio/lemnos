#!/bin/bash
set -e

pip install -r requirements.txt

curl -LO "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz"
tar -xzf "quarto-${QUARTO_VERSION}-linux-amd64.tar.gz" -C /tmp/
export PATH=$PATH:/tmp/quarto-${QUARTO_VERSION}/bin

quarto render
