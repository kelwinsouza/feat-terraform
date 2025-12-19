# feat-terraform

Este projeto utiliza Terraform para provisionar uma infraestrutura básica na AWS, incluindo uma VPC, subnet, instância EC2 e configurações de segurança. É ideal para ambientes de desenvolvimento ou testes iniciais na nuvem.

## Funcionalidades

- **VPC e Rede**: Cria uma VPC com subnet pública, internet gateway e tabelas de roteamento para conectividade externa.
- **Instância EC2**: Provisiona uma instância t3.micro com Ubuntu, acessível via SSH.
- **Segurança**: Configura um security group que permite acesso SSH de um IP específico (configure conforme necessário).
- **Estado Remoto**: Utiliza backend S3 para armazenar o estado do Terraform de forma segura e compartilhada.

## Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [Terraform](https://www.terraform.io/downloads.html) (versão >= 1.0)
- [AWS CLI](https://aws.amazon.com/cli/) configurado com suas credenciais (use `aws configure` ou variáveis de ambiente como `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`)
- Uma chave SSH privada/pública (gerada localmente, ex.: `ssh-keygen -t rsa -b 2048 -f aws-key`)

**Atenção**: Nunca versione chaves privadas ou credenciais no repositório. Use o `.gitignore` para ignorar arquivos sensíveis como `aws-key`, `aws-key.pub`, `*.tfvars` e `plan.out`.

## Instalação e Configuração

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/seu-usuario/feat-terraform.git
   cd feat-terraform
   ```

2. **Configure suas credenciais AWS**:
   - Certifique-se de que o AWS CLI está configurado ou defina variáveis de ambiente.
   - O projeto usa a região `sa-east-1` (São Paulo). Altere se necessário no `main.tf`.

3. **Prepare as chaves SSH**:
   - Gere ou copie sua chave pública para `aws-key.pub` (não versione a privada).
   - Exemplo: `cp ~/.ssh/id_rsa.pub ./aws-key.pub`

4. **Personalize o security group** (opcional):
   - No `security.tf`, substitua o CIDR do ingress por seu IP público (ex.: `curl ifconfig.me` para obter).
   - Ou use variáveis Terraform para tornar isso dinâmico.

5. **Inicialize o Terraform**:
   ```bash
   terraform init
   ```

## Uso

1. **Planeje as mudanças**:
   ```bash
   terraform plan -out=plan.out
   ```

2. **Aplique a infraestrutura**:
   ```bash
   terraform apply plan.out
   ```

3. **Acesse a instância**:
   - Após a criação, use o IP público da instância (visível no output do Terraform ou console AWS).
   - Conecte via SSH: `ssh -i aws-key ubuntu@<public-ip>`

4. **Destrua a infraestrutura** (quando não precisar mais):
   ```bash
   terraform destroy
   ```

**Nota**: O estado é armazenado remotamente no S3 (`projeto-backups001`). Certifique-se de ter permissões para acessar o bucket.

## Estrutura do Projeto

- `main.tf`: Configuração principal do Terraform, providers e backend S3.
- `network.tf`: Recursos de rede (VPC, subnet, IGW, route table).
- `compute.tf`: Instância EC2 e key pair.
- `security.tf`: Security group para controle de acesso.
- `.gitignore`: Arquivos ignorados pelo Git (chaves, estado local, etc.).
- `LICENSE`: Licença MIT.

## Contribuição

Contribuições são bem-vindas! Siga estes passos:

1. Fork o projeto.
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`).
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`).
4. Push para a branch (`git push origin feature/nova-feature`).
5. Abra um Pull Request.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE) - veja o arquivo LICENSE para detalhes.

## Avisos de Segurança

- **Credenciais**: Nunca exponha chaves AWS ou SSH no código. Use variáveis de ambiente ou AWS IAM roles.
- **IPs**: O security group permite SSH de um IP fixo. Para produção, considere usar bastion hosts ou VPNs.
- **Custos**: Recursos AWS geram custos. Monitore no console AWS e destrua quando não usar.
- **Estado**: O backend S3 requer um bucket existente. Crie-o manualmente se necessário.

Para dúvidas ou issues, abra uma issue no GitHub.

