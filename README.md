# legacy-billing

## Descripción
Sistema Legacy de Facturación desplegado en AWS Academy mediante pipeline CI/CD.

## Arquitectura CI/CD

### Integración Continua (CI)
- Pipeline configurado en `.github/workflows/ci.yml`
- Se dispara en push/pull_request a la rama `develop`
- Instala dependencias, ejecuta pruebas con Node.js 20 y genera artefacto

### Despliegue Continuo (CD)
- Pipeline configurado en `.github/workflows/cd.yml`
- Se dispara en push a la rama `main`
- Ejecuta `terraform init`, `terraform plan` y `terraform apply` automáticamente
- Aprovisiona infraestructura en AWS Academy (us-east-1)

## Infraestructura Terraform (Modular)
terraform/
├── main.tf          # Orquestador de módulos
├── providers.tf     # Proveedor AWS y backend S3
├── variables.tf     # Variables globales
├── outputs.tf       # Output IP pública
└── modules/
├── network/     # Security Group (puerto 3000, IP restringida /32)
└── compute/     # Instancia EC2 con user_data
## URL de Validación
http://98.92.185.103:3000
