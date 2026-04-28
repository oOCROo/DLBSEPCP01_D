# ============================================================
# variables.tf – Zentrale Variablendefinitionen
# ============================================================

variable "aws_region" {
  description = "AWS-Region fuer das Deployment"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Projektname fuer die Ressourcen-Benennung"
  type        = string
  default     = "globaltrails"
}

variable "environment" {
  description = "Deployment-Umgebung (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Die Umgebung muss 'dev', 'staging' oder 'prod' sein."
  }
}

variable "vpc_cidr" {
  description = "CIDR-Block fuer die VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "Der Wert fuer vpc_cidr muss ein gueltiger CIDR-Block sein (z. B. 10.0.0.0/16)."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR-Bloecke fuer die oeffentlichen Subnetze (mind. 2 AZs)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones fuer Hochverfuegbarkeit"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "instance_type" {
  description = "EC2-Instanztyp (Free Tier: t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image ID (Amazon Linux 2023)"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "min_instances" {
  description = "Minimale Anzahl EC2-Instanzen in der Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_instances" {
  description = "Maximale Anzahl EC2-Instanzen in der Auto Scaling Group"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Gewuenschte Anzahl EC2-Instanzen"
  type        = number
  default     = 2
}

variable "ssh_public_key_path" {
  description = "Pfad zum oeffentlichen SSH-Schluessel fuer EC2-Zugriff"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "admin_ip" {
  description = "IP-Adresse des Administrators fuer SSH-Zugriff (CIDR)"
  type        = string
  default     = "192.168.1.100/32" # Dummy-IP, in Prod durch echte VPN/Admin-IP ersetzen

  validation {
    condition     = can(cidrnetmask(var.admin_ip)) && var.admin_ip != "0.0.0.0/0"
    error_message = "Die admin_ip darf aus Sicherheitsgruenden nicht 0.0.0.0/0 sein und muss gueltiges CIDR-Format haben."
  }
}

variable "s3_bucket_name" {
  description = "Name des S3-Buckets fuer statische Inhalte"
  type        = string
  default     = "globaltrails-static-assets"

  validation {
    condition     = length(var.s3_bucket_name) >= 3 && length(var.s3_bucket_name) <= 63 && can(regex("^[a-z0-9.-]+$", var.s3_bucket_name))
    error_message = "Der S3-Bucket-Name darf nur Kleinbuchstaben, Zahlen, Punkte und Bindestriche enthalten."
  }
}