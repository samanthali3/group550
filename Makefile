.PHONY: all
all: report.html

# Compiling final html report - need to add other code!
report.html: report.Rmd code/render_report.R \
all_pe all_sl all_em all_mm
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
	
# SL Outputs
.PHONY: all_sl
all_sl: output/sl_output/boxplot.rds \
        output/sl_output/table_one.rds \
        output/sl_output/tukey_table.rds

output/sl_output/table_one.rds \
output/sl_output/tukey_table.rds: code/sl_code/01_sl_table.R
	Rscript code/sl_code/01_sl_table.R

output/sl_output/boxplot.rds: code/sl_code/02_sl_plot.R
	Rscript code/sl_code/02_sl_plot.R
	
#EM Outputs
.PHONY: all_em clean_em

all_em: output/em_output/table1_summary.csv \
        output/em_output/chi_square_results.csv \
        output/em_output/chi_square_table.csv \
        output/em_output/Position_AS_barchart.png

output/em_output/table1_summary.csv \
output/em_output/chi_square_results.csv \
output/em_output/chi_square_table.csv \
output/em_output/Position_AS_barchart.png: code/code_em/em_code_01.R
	Rscript code/code_em/em_code_01.R

#MM Outputs
.PHONY: all_mm

all_mm: output/output_mm/summary_3p_mm.rds \
             output/output_mm/summary_ft_mm.rds \
             output/output_mm/scatterplot_3pbgs_mm.rds \
             output/output_mm/scatterplot_ftbgs_mm.rds

output/output_mm/summary_3p_mm.rds \
output/output_mm/summary_ft_mm.rds \
output/output_mm/scatterplot_3p_mm.rds \
output/output_mm/scatterplot_ft_mm.rds: code/code_mm/code_mm.R
	Rscript code/code_mm/code_mm.R
	
# Clean Command
.PHONY: clean
clean:
	rm -f output/PE_output/*.rds && rm -f report.html \
	&& rm -f output/sl_output/*.rds \
	&& rm -f output/em_output/*csv && rm -f output/em_output/*.png \
	&& rm -f output/output_mm/*rds

# Renv install command
.PHONY: install
install:
Rscript -e "renv::restore(prompt = FALSE)"
