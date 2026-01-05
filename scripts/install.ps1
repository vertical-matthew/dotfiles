param(
  [string]$RepoDir = "$env:USERPROFILE\.dotfiles"
)

$ErrorActionPreference = "Stop"
$target = Join-Path $env:LOCALAPPDATA "nvim"

function WingetInstall($id) {
  & winget install --id $id -e --silent | Out-Null
}

# deps
WingetInstall "Neovim.Neovim"
WingetInstall "Git.Git"
WingetInstall "BurntSushi.ripgrep"
WingetInstall "sharkdp.fd"
WingetInstall "OpenJS.NodeJS.LTS"
WingetInstall "Python.Python.3.12"

# providers / LSP
& py -m pip install --user -U pynvim | Out-Null
& npm i -g pyright | Out-Null

# backup existing config (if real folder)
if (Test-Path $target -PathType Container) {
  $bak = "$target.bak.$(Get-Date -Format yyyyMMddHHmmss)"
  Move-Item $target $bak
}

# link repo\nvim -> %LOCALAPPDATA%\nvim using a Junction (no admin needed)
New-Item -ItemType Junction -Path $target -Target (Join-Path $RepoDir "nvim") | Out-Null

# plugin sync headless
& nvim --headless "+Lazy! sync" +qa

Write-Host "Done. Run: nvim"
