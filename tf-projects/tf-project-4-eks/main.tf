data "aws_vpc" "eks-vpc" {
  id = "vpc-001f765df7882f3ae"
}

data "aws_subnet" "eks-subnet-1" {
  id = "subnet-00334d88a0d307052"
}

data "aws_subnet" "eks-subnet-2" {
  id = "subnet-0d0421ae0e97af15b"
}

data "aws_subnet" "eks-subnet-3" {
  id = "subnet-0af328e3060589e73"
}

data "aws_subnet" "eks-subnet-4" {
  id = "subnet-0d57ef6be4dc9c7c8"
}

data "aws_iam_role" "eks-cluster-role-1" {
  name = "eks-practice-cluster-role"
}

data "aws_iam_role" "eks-cluster-node-role" {
  name = "eks-cluster-node-1"
}

resource "aws_eks_cluster" "eks-practice-tf" {
  name     = "eks-practice-tf"
  role_arn = data.aws_iam_role.eks-cluster-role-1.arn
  vpc_config {
    subnet_ids = [data.aws_subnet.eks-subnet-1.id, data.aws_subnet.eks-subnet-2.id, data.aws_subnet.eks-subnet-3.id, data.aws_subnet.eks-subnet-4.id]
  }
}

resource "aws_eks_node_group" "eks-practice-node-group" {
  cluster_name    = aws_eks_cluster.eks-practice-tf.name
  node_group_name = "eks-practice-node-group"
  node_role_arn   = data.aws_iam_role.eks-cluster-role-1.arn
  subnet_ids      = [data.aws_subnet.eks-subnet-1.id, data.aws_subnet.eks-subnet-2.id, data.aws_subnet.eks-subnet-3.id, data.aws_subnet.eks-subnet-4.id]
  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

}



