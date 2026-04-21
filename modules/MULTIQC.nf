process MULTIQC {
  conda 'envs/read-clean-asm.yml'
  publishDir '${params.outdir}/multiqc', mode: 'copy'
  input:
    path reads
  output:
    path "
  script:
    """
    
    """
}