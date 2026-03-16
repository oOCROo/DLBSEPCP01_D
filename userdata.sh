#!/bin/bash
# ============================================================
# userdata.sh – EC2-Bootstrapping-Skript
# ============================================================
# DSGVO-Hinweis: Dieses Skript dient ausschliesslich dem
# Bootstrapping des Webservers. Es werden KEINE Nutzerdaten
# gesammelt, gespeichert oder verarbeitet. Es enthaelt KEINE
# fest codierten Passwoerter oder Zugangsdaten.
# ============================================================

set -e

# System aktualisieren
yum update -y

# Apache Webserver installieren und starten
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Platzhalter-HTML-Seite erstellen
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GlobalTrails GmbH</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #1a5276, #2ecc71);
            color: #fff;
        }
        .container {
            text-align: center;
            padding: 2rem;
        }
        h1 { font-size: 2.5rem; margin-bottom: 0.5rem; }
        p  { font-size: 1.2rem; opacity: 0.9; }
        .status {
            margin-top: 1rem;
            padding: 0.5rem 1rem;
            background: rgba(255,255,255,0.2);
            border-radius: 8px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>GlobalTrails GmbH</h1>
        <p>Hochverfuegbare Cloud-Infrastruktur – Proof of Concept</p>
        <div class="status">
            Status: Aktiv | Region: eu-central-1 | Auto Scaling: Enabled
        </div>
    </div>
</body>
</html>
EOF

echo "Bootstrapping abgeschlossen – $(date)" >> /var/log/userdata.log
