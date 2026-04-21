process SKESA {
  conda 'envs/read-clean-asm.yml'
  publishDir "${params.outdir}/assembly", mode: 'copy'

  input:
    tuple val(sample), path(read1), path(read2)
  output:
    path "${sample}.fna"
  script:
    """
    skesa \
      --reads "${read1}","${read2}" \
      --cores ${params.skesa_cores} \
      --min_contig ${params.skesa_min_contig} \
      --contigs_out "${sample}.fna"
    """
}