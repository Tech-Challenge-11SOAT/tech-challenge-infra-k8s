# Tech Challenge – Infraestrutura Kubernetes (EKS)

Este repositório contém o código **Terraform** responsável por provisionar a infraestrutura de **Kubernetes (EKS)** utilizada no Tech Challenge da fase 3 da pós-graduação em Arquitetura de Software.

---

## Arquitetura

- **VPC** com subnets públicas e privadas.
- **Cluster EKS** (Amazon Elastic Kubernetes Service).
- **Node Group** para execução dos workloads.
- **Outputs** exportados para integração com outros repositórios:
  - `vpc_id`
  - `private_subnets`
  - `eks_node_sg`
  - `cluster_name`

---

## Estrutura do repositório

```
terraform/             # Código IaC do EKS e rede
  ├── vpc.tf
  ├── eks.tf
  ├── variables.tf
  ├── outputs.tf
  └── ...
.github/workflows/     # Pipelines de CI/CD
  ├── terraform-plan.yml
  └── terraform-apply.yml
```

---

## Workflows CI/CD

Este repositório possui automações no GitHub Actions:

- **Terraform Plan**  
  Executado em **Pull Requests** para a branch `develop`.  
  Valida e mostra as mudanças que seriam aplicadas na infraestrutura.

- **Terraform Apply**  
  Executado em **push** na branch `develop`.  
  Aplica automaticamente as alterações na AWS.

---

## Requisitos

- AWS com suporte a OIDC para GitHub Actions (role configurada).
- Bucket S3 configurados para backend remoto do Terraform.
- Terraform >= 1.6

---

## Como usar

1. Faça um fork/clone do repositório.
2. Crie uma branch a partir de `develop` para sua alteração:
   ```bash
   git checkout -b feature/minha-mudanca
   ```
3. Commit e abra um Pull Request → o **Terraform Plan** será executado.
4. Após aprovação/merge, o **Terraform Apply** será executado automaticamente.

---

## Integração com outros módulos

Este repositório expõe outputs que são consumidos por outros módulos:

- `tech-challenge-infra-db`: reutiliza a **VPC** e as **subnets privadas** para o RDS.
- `tech-challenge-back`: usa o **cluster_name** para aplicar os manifests da aplicação.

---

## Demonstração

Durante a entrega do Tech Challenge, este repositório será demonstrado em vídeo, evidenciando:
- Execução dos pipelines (`Plan` e `Apply`).
- Cluster EKS criado na AWS.
- Integração com os demais repositórios.