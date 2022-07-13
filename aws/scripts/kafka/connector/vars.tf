############################################################################################
#   SETTINGS
############################################################################################
variable "source_file_path" { type = string }
variable "destination_filename" { default = "connector" }
variable "destination_file_path" { default = "./connectors" }
variable "destination_file_permission" { default = "0755" }
