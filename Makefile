# Compiling final html report - need to add other code!
report.html: report.Rmd code/render_report.R
	Rscript code/render_report.R
	
# PE Outputs
.PHONY: all_pe
all_pe: output/PE_output/PFbT_anova_tbl.rds \
        output/PE_output/PFbT_sum_tbl.rds \
        output/PE_output/PFbT_boxplot.rds \
        output/PE_output/PFbT_bar.rds

output/PE_output/PFbT_anova_tbl.rds \
output/PE_output/PFbT_sum_tbl.rds \
output/PE_output/PFbT_boxplot.rds \
output/PE_output/PFbT_bar.rds: code/PE_code/01_PE_code.R
	Rscript code/PE_code/01_PE_code.R

# Clean Command - needs to be edited to account for other folders
.PHONY: clean
clean:
	rm -f output/PE_output/*.rds && rm -f report.html && rm -f output/sl_output/*.rds

# Renv install command - delete #s once ready
#.PHONY: install
#install:
#	Rscript -e "renv::restore(prompt = FALSE)"