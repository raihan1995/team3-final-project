provider "aws" {
  access_key = AKIA5VSD3IAO4DOD6STN
  secret_key = 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
  region     = "eu-west-2"
}

resource "aws_iam_role" "eks_cluster" {
  name               = "eks-cluster"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement" : [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}
resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}
resource "aws_eks_cluster" "eks" {
  name     = "our_cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids             = [var.sub1, var.sub2]
    security_group_ids     = [var.sg_id]
    endpoint_public_access = true
  }
}

resource "aws_iam_role" "eks_nodes" {
  name               = "eks-node-group"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
