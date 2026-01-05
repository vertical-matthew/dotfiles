param(
  [string]$RepoDir = "$env:USERPROFILE\.dotfiles"
)

$ErrorActionPreference = "Stop"

function WingetInstall([string]$id) {
  if (Get-Command winget -ErrorAction SilentlyContinue) {
    & winget install --id $id -e --silent | Out-Null
  } else {
    throw "winget not found. Install App Installer from Microsoft Store."
  }
}

$repoNvim = Join-Path $RepoDir "nvim"
$target = Join-Path $env:LOCALAPPDATA "nvim"

# Validate repo structure
$initLua = Join-Path $repoNvim "init.lua"
if (-not (Test-Path $initLua -PathType Leaf)) {
  throw "Expected Neovim config not found: $initLua`nYour repo must contain: dotfiles\nvim\init.lua"
}

# Dependencies
WingetInstall "Neovim.Neovim"
WingetInstall "Git.Git"
WingetInstall "BurntSushi.ripgrep"
WingetInstall "sharkdp.fd"
WingetInstall "OpenJS.NodeJS.LTS"
WingetInstall "Python.Python.3.12"

# Providers / LSP
& py -m pip install --user -U pynvim | Out-Null
& npm i -g pyright | Out-Null

# Replace existing config (backup if it's a real folder)
if (Test-Path $target) {
  $item = Get-Item $target -Force
  if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
    # junction/symlink
    Remove-Item -Recurse -Force $target
  } else {
    # real folder -> backup
    $bak = "$target.bak.$(Get-Date -Format yyyyMMddHHmmss)"
    Move-Item $target $bak
  }
}

# Create junction (no admin needed)
New-Item -ItemType Junction -Path $target -Target $repoNvim | Out-Null

# Plugin sync headless (no bang; works with Lazy)
& nvim --headless "+Lazy sync" +qa

Write-Host "Done. Run: nvim"
