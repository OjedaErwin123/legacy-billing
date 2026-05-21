resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.iam_instance_profile

  user_data = <<-USERDATA
    #!/bin/bash
    set -e
    yum update -y
    curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
    yum install -y nodejs
    mkdir -p /app
    cd /app
    cat > package.json << 'PKGJSON'
{
  "name": "legacy-billing",
  "version": "1.0.0",
  "main": "app.js",
  "scripts": { "start": "node app.js" },
  "dependencies": { "express": "^4.19.2" }
}
PKGJSON
    cat > app.js << 'APPJS'
const express = require('express');
const app = express();
app.get('/', (req, res) => res.json({ status: 'ONLINE', service: 'legacy-billing' }));
app.listen(3000, () => console.log('Running on port 3000'));
APPJS
    npm install
    nohup node app.js > /app/app.log 2>&1 &
  USERDATA

  tags = {
    Name = "legacy-billing-server"
  }
}
