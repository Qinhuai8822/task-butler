# Task Butler deploy script (Windows PowerShell)
# Usage:
#   .\deploy.ps1                (interactive menu)
#   .\deploy.ps1 -Target claude [-Path .]
#   .\deploy.ps1 -Target agents [-Path .]
#   .\deploy.ps1 -Target chatgpt        (copies profile to clipboard)
#   .\deploy.ps1 -Target generic -Path <file>
#   .\deploy.ps1 -Target uninstall -Path <file-with-block>
# Compatible with Windows PowerShell 5.1+

param(
    [string]$Target = "",
    [string]$Path = ""
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$BEGIN = "# ---- task-butler BEGIN ----"
$END   = "# ---- task-butler END ----"

function Get-Block([string]$profileFile) {
    # content between the LAST TWO "--------" marker lines
    # (works for single-block profiles and for chatgpt's two-box profile,
    #  where the block we want to paste is the last one)
    $lines = Get-Content $profileFile -Encoding UTF8
    $marks = @($lines | Select-String -SimpleMatch "--------" | ForEach-Object { $_.LineNumber })
    if ($marks.Count -lt 2) { throw "Profile $profileFile has no content block." }
    $first = $marks[-2]; $last = $marks[-1]
    return ($lines[($first)..($last - 2)] -join "`n")
}

function Update-File([string]$file, [string]$block) {
    $dir = Split-Path -Parent $file
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    $existing = ""
    if (Test-Path $file) { $existing = Get-Content $file -Raw -Encoding UTF8 }
    $blockFull = "$BEGIN`n$block`n$END"
    if ($existing -match [regex]::Escape($BEGIN)) {
        # replace existing block
        $pattern = "(?s)\$([regex]::Escape($BEGIN)).*?$( [regex]::Escape($END) )"
        $new = $existing -replace $pattern, $blockFull
        Set-Content $file $new -Encoding UTF8
        Write-Host "Updated task-butler block in: $file"
    } else {
        $sep = ""
        if ($existing.Trim().Length -gt 0) { $sep = "`n`n" }
        Set-Content $file ($existing.TrimEnd() + $sep + $blockFull + "`n") -Encoding UTF8
        Write-Host "Appended task-butler block to: $file"
    }
}

function Remove-Block([string]$file) {
    if (-not (Test-Path $file)) { Write-Host "File not found: $file"; return }
    $raw = Get-Content $file -Raw -Encoding UTF8
    $pattern = "(?s)\s*$([regex]::Escape($BEGIN)).*?$([regex]::Escape($END))"
    $new = $raw -replace $pattern, ""
    Set-Content $file $new -Encoding UTF8
    Write-Host "Removed task-butler block from: $file"
}

if ($Target -eq "") {
    Write-Host "Task Butler deploy - choose a target:"
    Write-Host "  1) claude    - append block to CLAUDE.md (project or ~\.claude\CLAUDE.md)"
    Write-Host "  2) agents    - append block to AGENTS.md (Cursor/Codex/Cline/Gemini CLI)"
    Write-Host "  3) chatgpt   - copy Custom Instructions to clipboard"
    Write-Host "  4) generic   - append block to a file you specify"
    Write-Host "  5) uninstall - remove block from a file you specify"
    $choice = Read-Host "Select 1-5"
    switch ($choice) {
        "1" { $Target = "claude" }
        "2" { $Target = "agents" }
        "3" { $Target = "chatgpt" }
        "4" { $Target = "generic" }
        "5" { $Target = "uninstall" }
        default { throw "Invalid choice." }
    }
}

switch ($Target) {
    "claude" {
        $file = if ($Path -ne "") { $Path } else { Join-Path (Get-Location) "CLAUDE.md" }
        Update-File $file (Get-Block (Join-Path $root "profiles\claude.md"))
    }
    "agents" {
        $file = if ($Path -ne "") { $Path } else { Join-Path (Get-Location) "AGENTS.md" }
        Update-File $file (Get-Block (Join-Path $root "profiles\cli-agents.md"))
    }
    "chatgpt" {
        $profile = Get-Content (Join-Path $root "profiles\chatgpt.md") -Raw -Encoding UTF8
        $block = Get-Block (Join-Path $root "profiles\chatgpt.md")
        Set-Clipboard -Value $block
        Write-Host "Box-2 content copied to clipboard."
        Write-Host "Open ChatGPT Settings > Customization > Custom Instructions,"
        Write-Host "paste into the 'How would you like ChatGPT to respond?' box."
        Write-Host "(Box-1 text is in profiles/chatgpt.md)"
    }
    "generic" {
        if ($Path -eq "") { $Path = Read-Host "Target file path" }
        Update-File $Path (Get-Block (Join-Path $root "profiles\generic.md"))
    }
    "uninstall" {
        if ($Path -eq "") { $Path = Read-Host "File path to remove block from" }
        Remove-Block $Path
    }
    default { throw "Unknown target: $Target (use claude|agents|chatgpt|generic|uninstall)" }
}

Write-Host "Done."
