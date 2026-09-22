# -----------------------------------------------------------------------
# terraform-null-demo  —  v1.1.0
# TAG-BASED PMR MODULE
#
# Resources used:
#   - random_integer        : generates a unique numeric ID for each deployment
#   - random_string         : generates a short alphanumeric token  [NEW v1.1.0]
#   - null_resource         : simulates a provisioning step (echoes a greeting)
#   - local_file            : writes a plain-text summary file
#   - local_sensitive_file  : writes a file containing the token (mode 0600)  [NEW v1.1.0]
# -----------------------------------------------------------------------

# --- Unique run ID -------------------------------------------------------
resource "random_integer" "run_id" {
  min = 10000
  max = 99999
}

# --- Short alphanumeric token  [NEW v1.1.0] ------------------------------
resource "random_string" "token" {
  length  = var.token_length
  upper   = true
  lower   = true
  numeric = true
  special = false
}

# --- Simulated provisioning step ----------------------------------------
resource "null_resource" "greet" {
  # Re-run whenever the message, token, or run_id changes
  triggers = {
    message = var.message
    run_id  = random_integer.run_id.result
    token   = random_string.token.result
  }

  provisioner "local-exec" {
    command = "echo '[terraform-null-demo] ${var.message} (run_id=${random_integer.run_id.result} token=${random_string.token.result})'"
  }
}

# --- Write a plain-text summary file ------------------------------------
resource "local_file" "summary" {
  filename        = "${var.output_dir}/demo-summary-${random_integer.run_id.result}.txt"
  content         = <<-EOT
    terraform-null-demo
    ===================
    environment : ${var.environment}
    message     : ${var.message}
    run_id      : ${random_integer.run_id.result}
    token       : ${random_string.token.result}
    tags        : ${jsonencode(var.tags)}
    EOT
  file_permission = "0644"
}

# --- Write sensitive content to a 0600 file  [NEW v1.1.0] ---------------
resource "local_sensitive_file" "secret" {
  filename        = "${var.output_dir}/demo-secret-${random_integer.run_id.result}.txt"
  content         = <<-EOT
    terraform-null-demo — sensitive output
    ======================================
    run_id          : ${random_integer.run_id.result}
    token           : ${random_string.token.result}
    sensitive_label : ${var.sensitive_label}
    EOT
  file_permission = "0600"
}
