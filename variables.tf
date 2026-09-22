variable "message" {
  type        = string
  description = "Greeting message echoed by the null_resource provisioner and written to the summary file."
  default     = "Hello from terraform-null-demo v1.1.0"
}

variable "environment" {
  type        = string
  description = "Deployment environment label written into the summary file (e.g. dev, staging, prod)."
  default     = "dev"
}

variable "output_dir" {
  type        = string
  description = "Local directory path where files are written. Must already exist."
  default     = "."
}

# --- New in v1.1.0 -------------------------------------------------------

variable "token_length" {
  type        = number
  description = "Length of the random alphanumeric token written to the summary and secret files."
  default     = 16
}

variable "sensitive_label" {
  type        = string
  description = "A sensitive label written only to the 0600 secret file, kept out of plain-text outputs."
  sensitive   = true
  default     = "change-me"
}

variable "tags" {
  type        = map(string)
  description = "Arbitrary key/value tags serialised as JSON into the summary file."
  default     = {}
}
