resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.iam_instance_profile

  user_data = <<-USERDATA
    #!/bin/bash
    yum update -y
    yum install -y nodejs npm
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
    app.listen(${var.app_port}, () => console.log('Running on port ${var.app_port}'));
    APPJS
    npm install
    node app.js &
  USERDATA

  tags = {
    Name = "legacy-billing-server"
  }
}
