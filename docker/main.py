import os
import subprocess


def run_colabfold():
    input_fasta = "/app/input.fasta"
    output_dir = "/app/output"
    database_dir = "/database"

    # Esegui colabfold_search con il database locale
    search_cmd = f"colabfold_search --mmseqs /usr/local/bin/mmseqs {input_fasta} {database_dir} {output_dir}/msas"
    subprocess.run(search_cmd, shell=True, check=True)

    # Esegui colabfold_batch
    batch_cmd = f"colabfold_batch {output_dir}/msas {output_dir}"
    subprocess.run(batch_cmd, shell=True, check=True)


if __name__ == "__main__":
    run_colabfold()