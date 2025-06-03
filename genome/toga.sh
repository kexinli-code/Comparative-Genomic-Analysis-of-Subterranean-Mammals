gff3ToGenePred $ref.gff3 ${ref_prefix}.genePred
genePredToBed ${ref_prefix}.genePred ${ref_prefix}.bed
toga.py --isoforms Isoforms.txt --nextflow_config_dir $toga_home/nextflow_config_files all_clean.chain ${ref_prefix}.bed target.2bit query.2bit
awk '{if (\$1 == "GENE" && \$3 == \"L\") print \$0 }' TOGA_project_on*/loss_summ_data.tsv
mut_index.py TOGA_project_on*/inact_mut_data.txt TOGA_project_on*/inact_mut_data.hdf5
