# Obfuscator

## Descripción

Obfuscator es una herramienta diseñada para ofuscar código JavaScript, proporcionando versiones específicas para diferentes plataformas. Esta herramienta utiliza `javascript-obfuscator` para proteger el código fuente.

## Plataformas Soportadas

- **Linux**: Probado en Debian 13.3
- **Windows**: Probado en Windows 11

## Prerrequisitos

### Linux

- Instalar `rsync`
- Instalar `pnpm` globalmente: `pnpm install -g javascript-obfuscator`

### Windows

- Instalar `pnpm` globalmente: `pnpm install -g javascript-obfuscator`

## Archivos

- `Linux/obfuscator.sh`: Script para ejecutar el ofuscador en Linux.
- `Windows/obfuscator.ps1`: Script de PowerShell para ejecutar el ofuscador en Windows.
- `Windows/obfuscator.exe`: Ejecutable para Windows.

## Uso

Ejecuta el script correspondiente a tu plataforma para ofuscar archivos JavaScript. Asegúrate de tener instalados los prerrequisitos antes de usar la herramienta.

## Licencia

Este proyecto está bajo la licencia especificada en el archivo `LICENSE`.
