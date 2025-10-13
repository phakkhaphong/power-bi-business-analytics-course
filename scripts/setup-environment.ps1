# Power BI Business Analytics - Environment Setup Script
# Version: 2.0
# Author: 9Expert Training

param(
    [switch]$SkipPowerBI,
    [switch]$SkipData,
    [switch]$SkipTemplates,
    [string]$PowerBIVersion = "latest"
)

Write-Host "🚀 Power BI Business Analytics Environment Setup" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Green

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Warning "⚠️  This script should be run as Administrator for best results"
    Write-Host "Some features may not work properly without admin privileges" -ForegroundColor Yellow
}

# Function to check if command exists
function Test-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Function to download and install Power BI Desktop
function Install-PowerBIDesktop {
    param([string]$Version = "latest")
    
    Write-Host "📥 Installing Power BI Desktop..." -ForegroundColor Cyan
    
    try {
        if ($Version -eq "latest") {
            $url = "https://go.microsoft.com/fwlink/?LinkId=521662&clcid=0x409"
        } else {
            $url = "https://go.microsoft.com/fwlink/?LinkId=521662&clcid=0x409&ver=$Version"
        }
        
        $tempPath = "$env:TEMP\PowerBI-Setup.exe"
        Write-Host "Downloading from: $url" -ForegroundColor Gray
        
        Invoke-WebRequest -Uri $url -OutFile $tempPath -UseBasicParsing
        
        Write-Host "Installing Power BI Desktop..." -ForegroundColor Cyan
        Start-Process -FilePath $tempPath -ArgumentList "/quiet", "/norestart" -Wait
        
        Remove-Item $tempPath -Force
        Write-Host "✅ Power BI Desktop installed successfully" -ForegroundColor Green
        
    } catch {
        Write-Error "❌ Failed to install Power BI Desktop: $($_.Exception.Message)"
        return $false
    }
    
    return $true
}

# Function to download sample data
function Download-SampleData {
    Write-Host "📊 Setting up sample data..." -ForegroundColor Cyan
    
    $sampleDataPath = "datasets\sample"
    
    if (-not (Test-Path $sampleDataPath)) {
        New-Item -ItemType Directory -Path $sampleDataPath -Force | Out-Null
    }
    
    # Create sample data structure
    $sampleData = @{
        "SalesData.xlsx" = "Sample sales data with 10,000+ records"
        "Countries.csv" = "Country and continent data"
        "DateTable.xlsx" = "Comprehensive date table"
        "Clients.csv" = "Client information"
        "Products.csv" = "Product catalog"
        "FinancialData.xlsx" = "Financial metrics and KPIs"
    }
    
    foreach ($file in $sampleData.Keys) {
        $filePath = Join-Path $sampleDataPath $file
        if (-not (Test-Path $filePath)) {
            Write-Host "Creating $file..." -ForegroundColor Gray
            # In a real scenario, you would download or generate actual data
            # For now, we'll create placeholder files
            New-Item -ItemType File -Path $filePath -Force | Out-Null
            Set-Content -Path $filePath -Value "# $($sampleData[$file])"
        }
    }
    
    Write-Host "✅ Sample data setup completed" -ForegroundColor Green
}

# Function to setup Power BI templates
function Setup-Templates {
    Write-Host "📋 Setting up Power BI templates..." -ForegroundColor Cyan
    
    $templatesPath = "templates"
    
    if (-not (Test-Path $templatesPath)) {
        New-Item -ItemType Directory -Path $templatesPath -Force | Out-Null
    }
    
    # Create template files
    $templates = @{
        "Corporate-Theme.json" = "Corporate color theme"
        "Standard-Visuals.json" = "Standard visualization templates"
        "KPI-Template.pbix" = "KPI dashboard template"
        "Sales-Template.pbix" = "Sales dashboard template"
        "Financial-Template.pbix" = "Financial dashboard template"
    }
    
    foreach ($template in $templates.Keys) {
        $templatePath = Join-Path $templatesPath $template
        if (-not (Test-Path $templatePath)) {
            Write-Host "Creating $template..." -ForegroundColor Gray
            New-Item -ItemType File -Path $templatePath -Force | Out-Null
            Set-Content -Path $templatePath -Value "# $($templates[$template])"
        }
    }
    
    Write-Host "✅ Templates setup completed" -ForegroundColor Green
}

# Function to setup development environment
function Setup-DevelopmentEnvironment {
    Write-Host "🔧 Setting up development environment..." -ForegroundColor Cyan
    
    # Check for Git
    if (Test-Command "git") {
        Write-Host "✅ Git is installed" -ForegroundColor Green
    } else {
        Write-Warning "⚠️  Git is not installed. Please install Git for version control."
    }
    
    # Check for VS Code
    if (Test-Command "code") {
        Write-Host "✅ VS Code is installed" -ForegroundColor Green
    } else {
        Write-Warning "⚠️  VS Code is not installed. Consider installing for better development experience."
    }
    
    # Check for PowerShell 5.1+
    $psVersion = $PSVersionTable.PSVersion
    if ($psVersion.Major -ge 5) {
        Write-Host "✅ PowerShell $($psVersion.ToString()) is installed" -ForegroundColor Green
    } else {
        Write-Warning "⚠️  PowerShell version is $($psVersion.ToString()). Version 5.1+ is recommended."
    }
    
    # Setup PowerShell modules
    $modules = @("PowerBI-Cmdlets", "ImportExcel", "PSReadLine")
    
    foreach ($module in $modules) {
        try {
            if (Get-Module -ListAvailable -Name $module) {
                Write-Host "✅ $module module is available" -ForegroundColor Green
            } else {
                Write-Host "Installing $module module..." -ForegroundColor Gray
                Install-Module -Name $module -Force -Scope CurrentUser
                Write-Host "✅ $module module installed" -ForegroundColor Green
            }
        } catch {
            Write-Warning "⚠️  Could not install $module module: $($_.Exception.Message)"
        }
    }
}

# Function to validate environment
function Test-Environment {
    Write-Host "🔍 Validating environment..." -ForegroundColor Cyan
    
    $issues = @()
    
    # Check Power BI Desktop
    $powerBIPath = Get-ChildItem -Path "C:\Program Files\Microsoft Power BI Desktop" -ErrorAction SilentlyContinue
    if (-not $powerBIPath) {
        $issues += "Power BI Desktop not found in standard location"
    }
    
    # Check sample data
    if (-not (Test-Path "datasets\sample")) {
        $issues += "Sample data directory not found"
    }
    
    # Check templates
    if (-not (Test-Path "templates")) {
        $issues += "Templates directory not found"
    }
    
    if ($issues.Count -eq 0) {
        Write-Host "✅ Environment validation passed" -ForegroundColor Green
        return $true
    } else {
        Write-Host "❌ Environment validation failed:" -ForegroundColor Red
        foreach ($issue in $issues) {
            Write-Host "  - $issue" -ForegroundColor Red
        }
        return $false
    }
}

# Main execution
try {
    Write-Host "Starting environment setup..." -ForegroundColor Green
    
    # Install Power BI Desktop
    if (-not $SkipPowerBI) {
        Install-PowerBIDesktop -Version $PowerBIVersion
    } else {
        Write-Host "⏭️  Skipping Power BI Desktop installation" -ForegroundColor Yellow
    }
    
    # Setup sample data
    if (-not $SkipData) {
        Download-SampleData
    } else {
        Write-Host "⏭️  Skipping sample data setup" -ForegroundColor Yellow
    }
    
    # Setup templates
    if (-not $SkipTemplates) {
        Setup-Templates
    } else {
        Write-Host "⏭️  Skipping templates setup" -ForegroundColor Yellow
    }
    
    # Setup development environment
    Setup-DevelopmentEnvironment
    
    # Validate environment
    $isValid = Test-Environment
    
    if ($isValid) {
        Write-Host ""
        Write-Host "🎉 Environment setup completed successfully!" -ForegroundColor Green
        Write-Host "You can now start learning Power BI Business Analytics" -ForegroundColor Green
        Write-Host ""
        Write-Host "Next steps:" -ForegroundColor Cyan
        Write-Host "1. Open Power BI Desktop" -ForegroundColor White
        Write-Host "2. Start with Module 1: Power BI Ecosystem" -ForegroundColor White
        Write-Host "3. Follow the learning path in README.md" -ForegroundColor White
    } else {
        Write-Host ""
        Write-Host "⚠️  Environment setup completed with issues" -ForegroundColor Yellow
        Write-Host "Please review the issues above and resolve them manually" -ForegroundColor Yellow
    }
    
} catch {
    Write-Error "❌ Setup failed: $($_.Exception.Message)"
    exit 1
}

Write-Host ""
Write-Host "Setup completed at $(Get-Date)" -ForegroundColor Gray
