library(pacman)
library(rmarkdown)

# use this function before knitting each notebook to 'unload' packages (except base R packages)
unload_pkgs <- function() p_unload(setdiff(p_loaded(),c("pacman","rmarkdown")), character.only = TRUE)#

# function for automated knitting of a single notebook
# name: character; the name of the notebook to be knitted (without .Rmd extension)

# input_data: character; the name of .Rds file generated by 'data_prep_XXX.R' script

# suffix: character; suffix used in notebook output file (html and rda) names

# load_outputdata: boolean, if TRUE, then intermediate data sets used in plotting, DEA will not be created, but loaded

# save_outputdata: boolean, if TRUE, then intermediate data sets used in plotting, DEA will be saved as .rda file for later use. 
#                  The name of the file goes, e.g., as follows "datadriven_unit_outdata<SUFFIX>.rda"

# subsample: numeric; 0 means all proteins, e.g. 50 means that 50 proteins will be randomly sampled.
#            subsample should be an integer >=0; if a very small number is specified, some errors may occurs (e.g. in normalization or DEA)

knit_notebook <- function(name, input_data, suffix='', load_outputdata=LOAD, save_outputdata=SAVE, subsample=0){
  notebook.params=list(input_data_p=input_data, suffix_p=suffix, load_outputdata_p=load_outputdata, save_outputdata_p=save_outputdata, subsample_p=subsample)
  if (suffix=='') tmp=name else tmp=paste0(name, '_', suffix)
  render(input = paste0(name,".Rmd"), 
         output_file = file.path(dirname(paste0(name,".Rmd")), tmp),
         params=notebook.params)
}

# first you need to run 'data_prep_XXX.R' script to process your raw data and save the resulting data
# as 'input_data_XXX.Rds' used in knitting the notebooks

# suffix to be added to when creating the html report and .rda file with output data. 
SUFFIX = ''
# e.g. SUFFIX = 'msstatstmt' lead to "datadriven_unit_msstatstmt.html" and "datadriven_unit_outdata_msstatstmt.rda"

# path to the processed input data that should be created by running earlier the data/data_prep.R script
INPUT_DATA = 'data/input_data.rds'

SAVE=TRUE

LOAD=FALSE

SUBSAMPLE=0

VARIABLES_TO_KEEP = c('VARIABLES_TO_KEEP', 'unload_pkgs', 'knit_notebook', 'INPUT_DATA', 'SUFFIX', 'SAVE', 'LOAD', 'SUBSAMPLE')

# knit all the notebooks specified below
rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook('intro', input_data=INPUT_DATA)

#### data-driven notebooks ####
rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("datadriven_unit", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE) 

rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("datadriven_summarization", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE) 

rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("datadriven_normalization", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE) 

rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("datadriven_DEA", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE) 

#### model-based notebooks ####
rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("modelbased_unit", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE) 

rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("modelbased_summarization", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE) 

rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("modelbased_normalization", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE)  

rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("modelbased_DEA", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE) 

#### other notebooks ####
rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("compare_defaults", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE) 

rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("CONSTANd_vs_medianSweeping", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE)  

rm(list=setdiff(ls(),VARIABLES_TO_KEEP)); unload_pkgs(); 
knit_notebook("datadriven_unit_rawratio", input_data=INPUT_DATA, suffix=SUFFIX, load_outputdata=LOAD, save_outputdata=SAVE, subsample=SUBSAMPLE) 
