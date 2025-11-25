#!/bin/bash

# Scan Terraform configurations with Trivy
# Usage: ./scripts/scan.sh [terraform|insecure|all]

set -e

TARGET="${1:-terraform}"

echo "🔍 Scanning Infrastructure as Code for security issues..."
echo ""

case $TARGET in
  terraform)
    echo "Scanning secure Terraform configuration..."
    trivy config terraform/ --config trivy.yaml | tee reports/trivy-secure.txt
    ;;
  insecure)
    echo "Scanning insecure Terraform configuration..."
    trivy config terraform-insecure/ --config trivy.yaml | tee reports/trivy-insecure.txt
    ;;
  all)
    echo "Scanning all Terraform configurations..."
    echo ""
    echo "=== Secure Configuration ==="
    trivy config terraform/ --config trivy.yaml | tee reports/trivy-secure.txt
    echo ""
    echo "=== Insecure Configuration ==="
    trivy config terraform-insecure/ --config trivy.yaml | tee reports/trivy-insecure.txt
    ;;
  *)
    echo "Usage: $0 [terraform|insecure|all]"
    exit 1
    ;;
esac

echo ""
echo "✅ Scan complete! Results saved to reports/"
