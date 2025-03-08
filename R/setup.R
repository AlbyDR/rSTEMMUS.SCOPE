#' setup
#'
#' This is a function to prepare input folders and set-up path and files for a new run of STEMMUS_SCOPE/Matlab simulations.
#' The input structure is created in the ../input/runs/site_name_inputs.
#' @param STEMMUS_SCOPE_dir the path to the STEMMUS_SCOPE downloaded folder, example: "D:/models/STEMMUS_SCOPE/".
#' @param StartTime a start datetime to the simulations/initial conditions in this format "2023-01-01T01:00".
#' @param EndTime a final datetime to end the simulations in the same format "2023-05-01T23:00".
#' @param site_name a short name for the site or location of the run.
#' @param output_name the default is the site_name (with _) and the datatime from the Sys.time() funtion.
#' @return It return a message "done!". A set of files from the simulation will be save on the SCOPE directory/output/simulation_name
#' @examples
#'
#'
#' EC data----
#'
#' input_folder(STEMMUS_SCOPE_dir = "D:/model/STEMMUS_SCOPE/",
#'             StartTime = "2023-06-01T00:00",
#'            EndTime = "2023-11-30T23:00",
#'             site_name = "DE-HoH",
#'             run_name = "ECdata_36",
#'             output_name = format(Sys.time(), "%Y%b%d_%H%M"))
#'
#'
#' site names
#'site_CRN_names <- c(paste0("DE-C0",1:9), paste0("DE-C",10:19))

#'for (i in 1:19) {
#'input_folder(STEMMUS_SCOPE_dir = "D:/model/STEMMUS_SCOPE/",
#'            StartTime = "2023-06-01T00:00",
#'            EndTime = "2023-11-30T23:00",
#'            site_name = site_CRN_names[i],
#'            run_name = "DWD_36",
#'            output_name = format(Sys.time(), "%Y%b%d_%H%M"))
#'}
#'
#' @export
#'
input_folder <- function(
    STEMMUS_SCOPE_dir = "D:/model/STEMMUS_SCOPE/",
    StartTime = NA,
    EndTime = NA,
    site_name = NA,
    run_name = NA,
    output_name = format(Sys.time(), "%Y%b%d_%H%M")

){

  # create the config file with the paths fro the input files ----
  config <- c(
    paste0("WorkDir=", STEMMUS_SCOPE_dir),
    paste0("directional=", STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/directional/"),
    paste0("fluspect_parameters=", STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/fluspect_parameters/"),
    paste0("leafangles=", STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/leafangles/"),
    paste0("radiationdata=", STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/radiationdata/"),
    paste0("soil_spectrum=", STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/soil_spectrum/"),
    paste0("input_data=", STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/input_data.xlsx"),
    paste0("InitialConditionPath=", STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/"),
    paste0("StartTime=", StartTime),
    paste0("EndTime=", EndTime),
    paste0("InputPath=", STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/"),
    paste0("OutputPath=", STEMMUS_SCOPE_dir,"output/", site_name, "_", run_name, output_name, "/")
  )

  # create a directory for the new run in the STEMMUS_SCOPE directory ../input/runs/ ----
  dir.create(paste0(STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name))

  # copy general input files to the new directory ----
  file.copy(from=paste0(STEMMUS_SCOPE_dir,"input/directional/"),
            to=paste0(STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/"),
            overwrite = TRUE, recursive = TRUE, copy.mode = TRUE, copy.date = TRUE)

  file.copy(from=paste0(STEMMUS_SCOPE_dir,"input/fluspect_parameters/"),
            to=paste0(STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/"),
            overwrite = TRUE, recursive = TRUE, copy.mode = TRUE, copy.date = TRUE)

  file.copy(from=paste0(STEMMUS_SCOPE_dir,"input/leafangles/"),
            to=paste0(STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/"),
            overwrite = TRUE, recursive = TRUE, copy.mode = TRUE, copy.date = TRUE)

  file.copy(from=paste0(STEMMUS_SCOPE_dir,"input/radiationdata/"),
            to=paste0(STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/"),
            overwrite = TRUE, recursive = TRUE, copy.mode = TRUE, copy.date = TRUE)

  file.copy(from=paste0(STEMMUS_SCOPE_dir,"input/soil_spectrum/"),
            to=paste0(STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/"),
            overwrite = TRUE, recursive = TRUE, copy.mode = TRUE, copy.date = TRUE)

  filespath <- c(paste0(STEMMUS_SCOPE_dir,"input/input_data.xlsx"),
                 paste0(STEMMUS_SCOPE_dir,"input/soil_init.mat"),
                 paste0(STEMMUS_SCOPE_dir,"input/forcing_globals.mat"),
                 paste0(STEMMUS_SCOPE_dir,"input/soil_parameters.mat"))

  file.copy(filespath,
            to=paste0(STEMMUS_SCOPE_dir,"input/runs/", site_name, "_", run_name, "/"),
            overwrite = TRUE, recursive = FALSE, copy.mode = TRUE, copy.date = TRUE)

  # write the config file into the new folder input directory ----
  write.table(config, file = paste0(STEMMUS_SCOPE_dir, "input/runs/", site_name,  "_", run_name, "/", site_name, "_", run_name,"_", "config.txt"),
              quote = FALSE, col.names = FALSE, row.names = FALSE)

  # create MATLAB path to find the new input directory ----
  CFG = paste0(STEMMUS_SCOPE_dir, "input/runs/", site_name, "_", run_name, "/", site_name,"_", run_name, "_", "config.txt")

  # write the one line text file into the run directory ----
  #(it will be overwrite every time the input folder or run_STEMMUS_SCOPE is run)
  write.table(CFG, file = paste0(STEMMUS_SCOPE_dir, "input/runs/", "path.txt"),
              sep = " ", col.names = F, row.names = F, quote = F, eol = "", append=F)

  return(print(paste0("The input folder ", site_name, "_", run_name, " was created in the folder input/runs.")  ))
}

