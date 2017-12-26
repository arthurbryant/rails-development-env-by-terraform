variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
    default = "ap-northeast-1"
}

variable "ssh_private_key" {
    default = "~/.ssh/feng/key-pair-production.pem"
}

variable "count" {
    default = 1
}

variable "env" {
    default = "pro"
}
