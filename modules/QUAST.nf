process QUAST {
  conda 'envs/quast.yml'
  publishDir "${params.outdir}/quast", mode: 'copy'
  input:
    path assembly
  output:
    path "report.tsv"
    path "report.html"
    path "report.pdf"
  script:
    """
    quast ${assembly} -m ${params.quast_min_len} --threads ${params.quast_threads}
    """
}