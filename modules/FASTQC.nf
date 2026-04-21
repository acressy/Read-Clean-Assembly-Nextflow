process FASTQC {
  conda 'envs/read-clean-asm.yml'
  publishDir "${params.outdir}/fastqc/${sample}", mode: 'copy'

  input:
    tuple val(sample), path(read1), path(read2)
  output:
    path "${sample}_R1_001_fastqc.zip"
    path "${sample}_R1_001_fastqc.html"
    path "${sample}_R2_001_fastqc.zip"
    path "${sample}_R2_001_fastqc.html"
  script:
    """
    fastqc ${read1} ${read2} -t 4
    """
}