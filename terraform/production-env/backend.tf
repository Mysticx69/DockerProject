terraform {
  backend "s3" {
    bucket = "dockerprojectcpe"
    key    = "DockerProject/backup_Tfstate"
    region = "us-east-1"
  }
}
