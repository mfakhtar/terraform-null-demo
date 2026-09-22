# terraform-null-demo

A lightweight Terraform module that demonstrates core PMR concepts using only provider-agnostic resources — no cloud credentials needed.

**Resources:** `random_integer` · `random_string` · `null_resource` · `local_file` · `local_sensitive_file`

---

## Publishing method — Tag-based

This module lives at the **repository root**. TFE/HCP Terraform detects every semver Git tag and registers it as a new module version automatically.

| Version | What changed |
|---|---|
| `v1.0.0` | Initial release — random ID, null provisioner, plain-text summary file |
| `v1.1.0` | **Current** — adds `random_string` token, `local_sensitive_file` (0600), `tags` and `sensitive_label` inputs |
| `v2.0.0` | *(planned)* Breaking — rename `output_dir` → `output_path` |

### Push a new version

```bash
git add .
git commit -m "feat: describe your change"
git tag vX.Y.Z
git push origin main
git push origin vX.Y.Z
```

TFE picks up the tag within seconds and publishes it to the PMR.

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
  version = "1.1.0"

  message         = "Hello from my workspace"
  environment     = "staging"
  output_dir      = "/tmp"
  token_length    = 20
  sensitive_label = "my-secret-value"   # passed via TF_VAR_ or workspace variable (sensitive)
  tags = {
    team    = "platform"
    project = "demo"
  }
}
```

### Direct from Git — HTTPS

```hcl
module "demo" {
  source = "git::https://github.com/<owner>/terraform-null-demo.git?ref=v1.1.0"

  message      = "Hello from my workspace"
  environment  = "staging"
  output_dir   = "/tmp"
}
```

### Direct from Git — SSH

```hcl
module "demo" {
  source = "git::ssh://git@github.com/<owner>/terraform-null-demo.git?ref=v1.1.0"

  message      = "Hello from my workspace"
  environment  = "staging"
  output_dir   = "/tmp"
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

| Name | Description | Type | Default | Required | Since |
|---|---|---|---|---|---|
| `message` | Greeting message echoed and written to the summary file | `string` | `"Hello from terraform-null-demo v1.1.0"` | no | v1.0.0 |
| `environment` | Deployment environment label | `string` | `"dev"` | no | v1.0.0 |
| `output_dir` | Local directory where files are written | `string` | `"."` | no | v1.0.0 |
| `token_length` | Length of the random alphanumeric token | `number` | `16` | no | **v1.1.0** |
| `sensitive_label` | Sensitive label written only to the 0600 secret file | `string` | `"change-me"` | no | **v1.1.0** |
| `tags` | Key/value tags serialised as JSON into the summary file | `map(string)` | `{}` | no | **v1.1.0** |

## Outputs

| Name | Description | Since |
|---|---|---|
| `run_id` | Random integer generated for this run | v1.0.0 |
| `summary_file_path` | Path of the plain-text summary file | v1.0.0 |
| `summary_content` | Full text content of the plain-text summary file | v1.0.0 |
| `token` | Generated alphanumeric token | **v1.1.0** |
| `secret_file_path` | Path of the 0600 sensitive file | **v1.1.0** |
