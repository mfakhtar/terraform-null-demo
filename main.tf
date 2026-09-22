# -----------------------------------------------------------------------
# terraform-null-demo  —  v1.0.0
# TAG-BASED PMR MODULE
#
# Resources used:
#   - random_integer   : generates a unique numeric ID for each deployment
#   - null_resource    : simulates a provisioning step (echoes a greeting)
#   - local_file       : writes a summary file to the working directory
# -----------------------------------------------------------------------

# --- Unique run ID -------------------------------------------------------
resource "random_integer" "run_id" {
  min = 10000
  max = 99999
}

# --- Simulated provisioning step ----------------------------------------
resource "null_resource" "greet" {
  # Re-run whenever the message or the run_id changes
  triggers = {
    message = var.message
    run_id  = random_integer.run_id.result
  }

  provisioner "local-exec" {
    command = "echo '[terraform-null-demo] ${var.message} (run_id=${random_integer.run_id.result})'"
  }
}

# --- Write a summary file to the local working directory ----------------
resource "local_file" "summary" {
  filename        = "${var.output_dir}/demo-summary-${random_integer.run_id.result}.txt"
  content         = <<-EOT
    terraform-null-demo
    ===================
    environment : ${var.environment}
    message     : ${var.message}
    run_id      : ${random_integer.run_id.result}
    EOT
  file_permission = "0644"
}
