variable "environment" {
  type    = string
  default = "dev"
}

variable "pubsub1" {
  type    = string
  default = "subnet-071e332b54da32cc9"
}

variable "pubsub2" {
  type    = string
  default = "subnet-09f144d5e42c49f69"
}

variable "eksIAMRole" {
  type    = string
  default = "DevEKSCluster"
}

variable "EKSClusterName" {
  type    = string
  default = "DevEKS"
}

variable "k8sVersion" {
  type    = string
  default = "1.26"
}

variable "workerNodeIAM" {
  type    = string
  default = "DevWorkerNodes"
}

variable "max_size" {
  type    = string
  default = 4
}

variable "desired_size" {
  type    = string
  default = 3
}
variable "min_size" {
  type    = string
  default = 3
}

variable "instanceType" {
  type    = list(any)
  default = ["t3.medium"]
}

