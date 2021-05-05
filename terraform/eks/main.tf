# Configure Cluster
resource "aws_iam_role" "eks_cluster" {
  name               = "eks-cluster"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
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
  name     = "eks_cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  vpc_config {
    subnet_ids              = [var.subnet_id]
    security_group_ids      = [var.security_group_id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }
}
## Configure Nodes
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
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}
###'''''''''''''''''''''''''''''''''''''''''''''''''''
resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "node_group"
  instance_types  = vars.instance_types
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = [var.subnet_id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}