#!/bin/bash

# Funzione per il download dei pesi di ColabFold
download_weights() {
    echo "Downloading ColabFold weights..."
    python3 << EOF
from colabfold.download import default_data_dir, download_alphafold_params
from colabfold.utils import setup_logging
import os

os.makedirs('/app/logs', exist_ok=True)
setup_logging('/app/logs/setup.log')
download_alphafold_params(default_data_dir)
EOF
    echo "ColabFold weights downloaded."
}

# Funzione per l'esecuzione di ColabFold
run_colabfold() {
    echo "Running ColabFold..."
    INPUT_FASTA="/app/input.fasta"
    OUTPUT_DIR="/app/output"
    DATABASE_DIR="/database"

    # Crea la directory di output se non esiste
    mkdir -p $OUTPUT_DIR

    # Esegui colabfold_search con il database locale
    colabfold_search --mmseqs /usr/local/bin/mmseqs $INPUT_FASTA $DATABASE_DIR $OUTPUT_DIR/msas

    # Esegui colabfold_batch
    colabfold_batch $OUTPUT_DIR/msas $OUTPUT_DIR

    echo "ColabFold execution completed. Results are in $OUTPUT_DIR"
}

# Scarica i pesi se non sono già presenti
if [ ! -d "/app/colabfold_params" ]; then
    download_weights
fi

# Esegui ColabFold
run_colabfold