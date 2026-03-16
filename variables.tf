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

variable "vpc_cidr" {
  description = "CIDR-Block fuer die VPC"
  type        = string
  default     = "10.0.0.0/16"
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
  default     = "0.0.0.0/0" # In Produktion: spezifische Admin-IP verwenden
}

variable "s3_bucket_name" {
  description = "Name des S3-Buckets fuer statische Inhalte"
  type        = string
  default     = "globaltrails-static-assets"
}
