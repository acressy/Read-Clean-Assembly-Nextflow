process FASTP {
    conda 'envs/read-clean-asm.yml'
    publishDir "${params.outdir}/trimmed/${sample}", mode: 'copy'
  input:
    tuple val(sample), path(read1), path(read2)
  output:
    tuple val(sample), path("${sample}.R1.fq.gz"), path("${sample}.R2.fq.gz"), path("${sample}.json"), path("${sample}.html")
  script:
    """
    fastp \
        -i "${read1}" \
        -I "${read2}" \
        -o "${sample}.R1.fq.gz" \
        -O "${sample}.R2.fq.gz" \
        --json "${sample}.json" \
        --html "${sample}.html"
    """
}