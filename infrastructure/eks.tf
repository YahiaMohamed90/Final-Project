# ------------------
#  IAM Role for EKS
# ------------------


resource "aws_iam_role" "eksrole" {
  name = "eks-cluster-role"

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




resource "aws_iam_role_policy_attachment" "eksrole-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eksrole.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "eksrole-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eksrole.name
}



resource "aws_eks_cluster" "yahia-eks" {
  name     = var.eks_cluster
  role_arn = aws_iam_role.eksrole.arn

  vpc_config {
    subnet_ids = [module.network.public_subnet_id_1, module.network.public_subnet_id_2]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eksrole-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eksrole-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.yahia-eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.yahia-eks.certificate_authority[0].data
}




# ----------------
# Enabling IAM Role for Service Account 
# ----------------


data "tls_certificate" "ekstls" {
  url = aws_eks_cluster.yahia-eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eksopidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.ekstls.certificates[*].sha1_fingerprint
  url             = aws_eks_cluster.yahia-eks.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "eksdoc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eksopidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eksopidc.arn]
      type        = "Federated"
    }
  }
}


