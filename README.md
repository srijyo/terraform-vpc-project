# terraform-vpc-project
complete production-style Terraform project using modules that creates:  ✅ VPC ✅ Public Subnet ✅ Private Subnet ✅ Internet Gateway ✅ NAT Gateway ✅ Route Tables ✅ Ubuntu EC2 (t2.micro) ✅ EC2 launched in the private subnet ✅ Private EC2 accesses Internet via NAT Gateway ✅ Modular Terraform structure ✅ Ready to push into GitHub and deploy from VS Code
terraform-vpc-project/
│
├── provider.tf
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
│
└── modules/
    ├── network/
    │    ├── main.tf
    │    ├── variables.tf
    │    └── outputs.tf
    │
    └── ec2/
         ├── main.tf
         ├── variables.tf
         └── outputs.tf
