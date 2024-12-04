setwd("genome/gencode/")

# filter gtf file to include only genes before loading into R  ----
# awk '$3=="gene" {print}' gencode.v47.basic.annotation.gtf > genes.gtf
# wc -l genes.gtf 
# 78724 << confirm this number at genecode website
# Since I’m more comfortable with Tidyverse and R, I’m using them here. There might be a better way to do this.

library(tidyverse) 

df <- read_tsv("genes.gtf", col_names = F)

df$gene_id <- str_extract(df$X9, "(?<=gene_name\\s\")\\w+") # I want only gene_ids for BED file so I pulled these strings from the 9th field of GTF file

final_bed <- df |> select(X1, X4, X5, X7, gene_id) # corresponds to chr,start,end,strand,gene_id

write_tsv(final_bed, file = "genes.bed", quote = "none", col_names = FALSE)
