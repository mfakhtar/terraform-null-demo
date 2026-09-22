# terraform-null-demo

A lightweight Terraform module that demonstrates core PMR concepts using only provider-agnostic resources — no cloud credentials needed.

**Resources:** `random_integer` · `null_resource` · `local_file`

---

## Publishing method — Tag-based

This module lives at the **repository root**. TFE/HCP Terraform detects every semver Git tag and registers it as a new module version automatically.

| Version | What changed |
|---|---|
| `v1.0.0` | Initial release — random ID, null provisioner, local summary file |
| `v1.1.0` | *(planned)* Add `local_sensitive_file` output variant |
| `v2.0.0` | *(planned)* Breaking — rename `output_dir` → `output_path` |

### Push a new version

```bash
# bump and tag
git add .
git commit -m "feat: describe your change"
git tag v1.0.0
git push origin main
git push origin v1.0.0
```

TFE picks up `v1.0.0` within seconds and publishes it to the PMR.

---

## Repository name

```
terraform-null-demo
```

TFE parses this as:
- **Module name:** `demo`
- **Provider:** `null`

---

## Usage

### From TFE / HCP Terraform Private Registry

```hcl
module "demo" {
  source  = "<TFE_HOSTNAME>/<ORG>/demo/null"
  version = "1.0.0"

  message     = "Hello from my workspace"
  environment = "dev"
  output_dir  = "/tmp"
}
```

### Direct from Git — HTTPS

```hcl
module "demo" {
  source = "git::https://github.com/<owner>/terraform-null-demo.git?ref=v1.0.0"

  message     = "Hello from my workspace"
  environment = "dev"
  output_dir  = "/tmp"
}
```

### Direct from Git — SSH

```hcl
module "demo" {
  source = "git::ssh://git@github.com/<owner>/terraform-null-demo.git?ref=v1.0.0"

  message     = "Hello from my workspace"
  environment = "dev"
  output_dir  = "/tmp"
}
```

---

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.9 |
| hashicorp/null | ~> 3.2 |
| hashicorp/random | ~> 3.7 |
| hashicorp/local | ~> 2.5 |

## Inputs

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `message` | Greeting message echoed and written to the summary file | `string` | `"Hello from terraform-null-demo v1.0.0"` | no |
| `environment` | Deployment environment label | `string` | `"dev"` | no |
| `output_dir` | Local directory where the summary file is written | `string` | `"."` | no |

## Outputs

| Name | Description |
|---|---|
| `run_id` | Random integer generated for this run |
| `summary_file_path` | Path of the written summary file |
| `summary_content` | Full text content of the summary file |
