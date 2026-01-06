# scripts/install.ps1
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)]
  [string]$RepoDir
)

$ErrorActionPreference = "Stop"

function Write-Info($msg) { Write-Host "[dotfiles] $msg" -ForegroundColor Cyan }
function Write-Warn($msg) { Write-Warning "[dotfiles] $msg" }

function Ensure-WingetPackage([string]$Id) {
  if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Warn "winget not found. Install '$Id' manually."
    return
  }
  Write-Info "Ensuring winget package: $Id"
  winget install --id $Id -e --silent --accept-source-agreements --accept-package-agreements | Out-Host
}

function Ensure-Dir([string]$Path) {
  if (-not (Test-Path $Path)) {
    New-Item -ItemType Directory -Path $Path | Out-Null
  }
}

# 1) Install external deps (fixes your ripgrep miss)
Ensure-WingetPackage "Git.Git"
Ensure-WingetPackage "Neovim.Neovim"
Ensure-WingetPackage "BurntSushi.ripgrep"
Ensure-WingetPackage "sharkdp.fd"
Ensure-WingetPackage "zig.zig"
Ensure-WingetPackage "OpenJS.NodeJS.LTS"

# 2) Python provider + formatters (optional but makes <leader>0 useful for python)
if (Get-Command python -ErrorAction SilentlyContinue) {
  Write-Info "Installing python deps (pynvim, black, isort)"
  python -m pip install --user --upgrade pynvim black isort | Out-Host
} else {
  Write-Warn "python not found; skipping pynvim/black/isort"
}

# 3) Link Neovim config
$source = Join-Path $RepoDir "nvim"
if (-not (Test-Path $source)) {
  throw "Missing '$source'. Repo must contain a 'nvim' folder."
}

$target = Join-Path $env:LOCALAPPDATA "nvim"
Ensure-Dir $env:LOCALAPPDATA

if (Test-Path $target) {
  $item = Get-Item $target -Force
  if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
    Write-Info "Removing existing junction: $target"
    Remove-Item $target -Force
  } else {
    $bak = "$target.bak.$(Get-Date -Format yyyyMMddHHmmss)"
    Write-Info "Backing up existing config to: $bak"
    Rename-Item $target $bak
  }
}

Write-Info "Creating junction: $target -> $source"
New-Item -ItemType Junction -Path $target -Target $source | Out-Null

# 4) Headless plugin install
if (Get-Command nvim -ErrorAction SilentlyContinue) {
  Write-Info "Running Lazy sync (headless)"
  nvim --headless "+Lazy sync" +qa | Out-Host
  Write-Info "Done. Start nvim normally: nvim"
} else {
  Write-Warn "nvim not found on PATH yet. Open a new terminal and run: nvim"
}
