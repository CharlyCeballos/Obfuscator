[200~#!/bin/bash

# Script en Bash para listar carpetas, elegir una, y ejecutar comandos en Ubuntu

# Obtener el directorio actual
current_dir=$(pwd)

# Listar carpetas en el directorio actual
folders=($(ls -d */ 2>/dev/null | sed 's|/$||'))

if [ ${#folders[@]} -eq 0 ]; then
    echo "No se encontraron carpetas."
    read -p "Presiona Enter para salir"
    exit 1
fi

echo "Listando carpetas en el directorio actual:"
for i in "${!folders[@]}"; do
    echo "$((i + 1)). ${folders[$i]}"
done

# Pedir selección de carpeta (original_proyect)
read -p "Elige el numero de la carpeta (proyecto original_proyect): " choice

if [[ -z "$choice" || ! "$choice" =~ ^[0-9]+$ || "$choice" -lt 1 || "$choice" -gt ${#folders[@]} ]]; then
    echo "Numero invalido."
    read -p "Presiona Enter para salir"
    exit 1
fi

original_proyect="${folders[$((choice - 1))]}"
echo "Has elegido: $original_proyect"

# Pedir nombre para obfuscated_proyect
read -p "Ingresa el nombre para la carpeta final (obfuscated_proyect): " obfuscated_proyect

if [[ -z "$obfuscated_proyect" ]]; then
    echo "Nombre invalido."
    read -p "Presiona Enter para salir"
    exit 1
fi

echo "Ejecutando comandos..."

# Comando 1: rsync -av --exclude=node_modules --exclude=.git ./original_proyect/ ./obfuscated_proyect/
rsync -av --exclude=node_modules --exclude=.git "./$original_proyect/" "./$obfuscated_proyect/"
read -p "Presiona Enter para continuar"

# Comando 2: javascript-obfuscator ./obfuscated_proyect --exclude=**/routes/** --output ./obfuscated_proyect_obfuscated --compact true
javascript-obfuscator "./$obfuscated_proyect" --exclude=**/routes/** --output "./${obfuscated_proyect}_obfuscated" --compact true
read -p "Presiona Enter para continuar"

# Comando 3: rsync -av --exclude='*.js' ./obfuscated_proyect/ ./obfuscated_proyect_obfuscated/
rsync -av --exclude='*.js' "./$obfuscated_proyect/" "./${obfuscated_proyect}_obfuscated/"
read -p "Presiona Enter para continuar"

# Comando 4: rsync -av ./obfuscated_proyect_obfuscated/ ./obfuscated_proyect/
rsync -av "./${obfuscated_proyect}_obfuscated/" "./$obfuscated_proyect/"
read -p "Presiona Enter para continuar"

# Comando 5: rm -rf ./obfuscated_proyect_obfuscated
rm -rf "./${obfuscated_proyect}_obfuscated"
read -p "Presiona Enter para continuar"

echo "Proceso completado."
