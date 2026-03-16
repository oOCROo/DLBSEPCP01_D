# ============================================================
# providers.tf – AWS-Provider und Terraform-Versionskonfiguration
# ============================================================
# Hinweis: AWS-Zugangsdaten werden NIEMALS im Code gespeichert.
# Die Authentifizierung erfolgt über lokale Umgebungsvariablen:
#   export AWS_ACCESS_KEY_ID="<your-access-key>"
#   export AWS_SECRET_ACCESS_KEY="<your-secret-key>"
# Alternativ: AWS CLI Profil (~/.aws/credentials)
# ============================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "GlobalTrails-Cloud"
      Environment = "PoC"
      ManagedBy   = "Terraform"
    }
  }
}
