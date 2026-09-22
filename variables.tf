variable "message" {
  type        = string
  description = "Greeting message echoed by the null_resource provisioner and written to the summary file."
  default     = "Hello from terraform-null-demo v1.0.0"
}

variable "environment" {
  type        = string
  description = "Deployment environment label written into the summary file (e.g. dev, staging, prod)."
  default     = "dev"
}

variable "output_dir" {
  type        = string
  description = "Local directory path where the summary file is written. Must already exist."
  default     = "."
}
