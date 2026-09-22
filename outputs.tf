output "run_id" {
  description = "Random integer generated for this deployment."
  value       = random_integer.run_id.result
}

output "summary_file_path" {
  description = "Absolute path of the summary file written by this module."
  value       = local_file.summary.filename
}

output "summary_content" {
  description = "Full text content of the generated summary file."
  value       = local_file.summary.content
}
