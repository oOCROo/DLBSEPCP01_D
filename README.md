# GlobalTrails GmbH - Cloud Infrastructure (PoC)

Dieses Repository enthält den Infrastructure as Code (IaC) für die hochverfügbare und globale Landingpage der GlobalTrails GmbH. Die Architektur wird vollständig automatisiert über **Terraform** auf Amazon Web Services (AWS) bereitgestellt.

## Architektur-Übersicht

Die Infrastruktur implementiert ein hybrides Routing-Modell mit Fokus auf Performance, Kosteneffizienz (AWS Free Tier) und strikter Sicherheit:
* **Amazon CloudFront:** Globales Content Delivery Network (CDN).
* **Amazon S3:** Speicherung statischer Assets (Zugriff strikt über Origin Access Control / OAC gesichert).
* **Application Load Balancer (ALB) & EC2 Auto Scaling Group:** Verarbeitung dynamischer Anfragen über zwei Availability Zones (eu-central-1a, eu-central-1b).
* **Security:** Striktes Least-Privilege-Prinzip. Keine öffentlichen IPs für EC2, SSH-Zugriff restriktiv auf spezifische Administrator-IPs begrenzt.

## Voraussetzungen

Um das Deployment durchzuführen, müssen folgende Voraussetzungen auf dem lokalen System erfüllt sein:
1. **Terraform** (Version >= 1.5.0) ist installiert.
2. **AWS CLI** ist installiert und konfiguriert (`aws configure` mit gültigen Access- und Secret-Keys).
3. Ein lokales **SSH-Schlüsselpaar** ist vorhanden (Standardpfad: `~/.ssh/id_rsa.pub`). Falls nicht vorhanden, kann es generiert werden mit:
   ```bash
   ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa

Deployment-Schritte
1. Initialisierung
Lädt den benötigten AWS-Provider herunter und initialisiert das Terraform-Backend:

Bash
terraform init

2. Planung & Validierung
Prüft die Konfiguration und zeigt die Ressourcen an, die erstellt werden.
Wichtiger Sicherheitshinweis: Die Variable admin_ip MUSS überschrieben werden. Terraform blockiert das Deployment, wenn versucht wird, 0.0.0.0/0 (globalen Zugriff) zu verwenden!

Bash
terraform plan -var="admin_ip=DEINE.AKTUELLE.IP.ADRESSE/32"

3. Ausrollen (Apply)
Erstellt die Infrastruktur auf AWS. Der Vorgang kann ca. 3-5 Minuten dauern (insbesondere die CloudFront-Distribution benötigt etwas Zeit).

Bash
terraform apply -var="admin_ip=DEINE.AKTUELLE.IP.ADRESSE/32"

Outputs
Nach erfolgreichem Deployment gibt Terraform folgende Werte in der Konsole aus:

cloudfront_url: Die finale, globale URL der Landingpage (Hauptzugriffspunkt).

alb_dns_name: Der direkte interne DNS-Name des Load Balancers.

s3_bucket_name: Der Name des erstellten Buckets für statische Inhalte.

asg_name & vpc_id: Identifikatoren für administrative Zwecke.

Cleanup (Ressourcen löschen)
Um nach dem Proof of Concept (PoC) unnötige AWS-Kosten zu vermeiden, sollte die Infrastruktur vollständig abgebaut werden:

Bash
terraform destroy -var="admin_ip=DEINE.AKTUELLE.IP.ADRESSE/32"

DSGVO & Compliance Hinweis
Das mitgelieferte userdata.sh-Skript dient ausschließlich dem technischen Bootstrapping der EC2-Instanzen. Es werden keine Nutzerdaten gesammelt und keine sensiblen Secrets oder Zugangsdaten auf den flüchtigen Instanzen gespeichert.
