 variable "name" {
    description = "Name of the bucket"
    type = string
    default = "simple-bucket"
 }

 variable "location" {
    description = "Location of the bucket"
    type = string
    default = "EU"
 }

 variable "labels" {
    desdescription = "Labels in key/value pair for the bucket" 
    type = map(string)
    default = null
 }
