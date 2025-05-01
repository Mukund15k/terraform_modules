# 🛡️ Security Group Terraform Module

## 📌 Purpose
This module creates **highly configurable AWS Security Groups** with ingress and egress rules. It's reusable for EC2, RDS, ALB, Lambda, etc.

---

## 🧱 Resources Created
- `aws_security_group`

---

## 📥 Input Variables

| Name           | Type   | Description                                    | Default |
|----------------|--------|------------------------------------------------|---------|
| name           | string | Name of the security group                     | —       |
| description    | string | Security group description                     | —       |
| vpc_id         | string | VPC ID to associate the SG with                | —       |
| ingress_rules  | list   | List of ingress rule objects                   | `[]`    |
| egress_rules   | list   | List of egress rule objects                    | Allow all |
| environment    | string | Deployment environment (dev/stage/prod)        | `dev`   |

---

## 📤 Outputs

| Name              | Description              |
|-------------------|--------------------------|
| security_group_id | ID of the security group |

---

## 🔧 Example Usage

```hcl
module "sg_ec2" {
  source      = "./modules/security-group"
  name        = "mkx-ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = module.vpc.vpc_id
  environment = "dev"

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH Access"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP Access"
    }
  ]
}
