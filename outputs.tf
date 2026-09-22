output "run_id" {
  description = "Random integer generated for this deployment."
  value       = random_integer.run_id.result
}

output "summary_file_path" {
  description = "Path of the plain-text summary file written by this module."
  value       = local_file.summary.filename
}

output "summary_content" {
  description = "Full text content of the plain-text summary file."
  value       = local_file.summary.content
}

# --- New in v1.1.0 -------------------------------------------------------

output "token" {
  description = "Generated alphanumeric token (not sensitive — safe to use as a correlation ID)."
  value       = random_string.token.result
}

output "secret_file_path" {
  description = "Path of the 0600 sensitive file written by this module."
  value       = local_sensitive_file.secret.filename
}
