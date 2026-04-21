#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Read_clean_asm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Github : https://github.com/acressy/read_clean_asm
    Author: Abigail Cressy
----------------------------------------------------------------------------------------
*/

//
// HELP MESSAGE
//

def helpMessage() {
    log.info"""
    =========================================
     Read Clean Assembly
    =========================================
    Usage:
    nextflow run main.nf -with-conda --input_path <path>

    Required arguments:
        --input_path                  Path to the input directory containing RNA-seq data

    """.stripIndent()
}
// END OF HELP MESSAGE

// Show help message
if (params.help) {
    helpMessage()
    exit 0
}

// IMPORT MODULES
include { FASTQC } from './modules/FASTQC.nf'
// include { MULTIQC } from './modules/MULTIQC.nf'
include { FASTP } from './modules/FASTP.nf'
include { SKESA } from './modules/SKESA.nf'
include { QUAST } from './modules/QUAST.nf'

workflow {

    // check quality pre-trimming
    reads_ch = Channel.fromFilePairs("$params.input_path/*_R{1,2}_001.fastq.gz", flat: true)
    
    raw_qual = FASTQC(reads_ch)

    // Trim
    fastp_out = FASTP(reads_ch)

    // If SKESA expects tuple(val(sample), path(r1), path(r2)), map out json/html:
    skesa_in = fastp_out.map { sample, r1, r2, json, html -> tuple(sample, r1, r2) }

    // Assemble
    assembled_ch = SKESA(skesa_in)

    // Check assembly quality
    QUAST(assembled_ch)
}