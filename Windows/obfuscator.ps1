# Script en PowerShell para listar carpetas, elegir una, y ejecutar comandos

# Obtener el directorio actual
$currentDir = Get-Location

# Listar carpetas en el directorio actual
$folders = Get-ChildItem -Directory | Select-Object -ExpandProperty Name

if ($folders.Count -eq 0) {
    Write-Host "No se encontraron carpetas."
    Read-Host "Presiona Enter para salir"
    exit
}

Write-Host "Listando carpetas en el directorio actual:"
for ($i = 0; $i -lt $folders.Count; $i++) {
    Write-Host "$($i + 1). $($folders[$i])"
}

# Pedir selección de carpeta (original_proyect)
$choice = Read-Host "Elige el numero de la carpeta (proyecto original_proyect)"

if ([string]::IsNullOrWhiteSpace($choice) -or -not [int]::TryParse($choice, [ref]$null) -or [int]$choice -lt 1 -or [int]$choice -gt $folders.Count) {
    Write-Host "Numero invalido."
    Read-Host "Presiona Enter para salir"
    exit
}

$original_proyect = $folders[[int]$choice - 1]
Write-Host "Has elegido: $original_proyect"

# Pedir nombre para obfuscated_proyect
$obfuscated_proyect = Read-Host "Ingresa el nombre para la carpeta final (obfuscated_proyect)"

if ([string]::IsNullOrWhiteSpace($obfuscated_proyect)) {
    Write-Host "Nombre invalido."
    Read-Host "Presiona Enter para salir"
    exit
}

Write-Host "Ejecutando comandos..."

# Comando 1: robocopy .\original_proyect .\obfuscated_proyect /E /XD node_modules .git
& robocopy ".\$original_proyect" ".\$obfuscated_proyect" /E /XD node_modules .git
Read-Host "Presiona Enter para continuar"

# Comando 2: javascript-obfuscator .\obfuscated_proyect --exclude=**/routes/** --output .\obfuscated_proyect_obfuscated --compact true
& javascript-obfuscator ".\$obfuscated_proyect" --exclude=**/routes/** --output ".\${obfuscated_proyect}_obfuscated" --compact true
Read-Host "Presiona Enter para continuar"

# Comando 3: robocopy .\obfuscated_proyect .\obfuscated_proyect_obfuscated /E /XF *.js
& robocopy ".\$obfuscated_proyect" ".\${obfuscated_proyect}_obfuscated" /E /XF *.js
Read-Host "Presiona Enter para continuar"

# Comando 4: robocopy .\obfuscated_proyect_obfuscated .\obfuscated_proyect /E
& robocopy ".\${obfuscated_proyect}_obfuscated" ".\$obfuscated_proyect" /E
Read-Host "Presiona Enter para continuar"

# Comando 5: rmdir -Recurse -Force obfuscated_proyect_obfuscated
Remove-Item -Recurse -Force ".\${obfuscated_proyect}_obfuscated"
Read-Host "Presiona Enter para continuar"

Write-Host "Proceso completado."
