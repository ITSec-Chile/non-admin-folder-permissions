function CheckAdminFoldersPermissions {
    # Obtener la lista de servicios y sus rutas (PathName)
    $services = Get-WmiObject Win32_Service | Select-Object DisplayName, PathName

    $administratorsGroup = Get-WmiObject Win32_Group | Where-Object { $_.SID -match 'S-1-5-32-544' } | Select-Object -ExpandProperty Name
    $nonAdminGroup = "Users"  # Reemplazar con el nombre del grupo de no administradores

    foreach ($service in $services) {
        # Extraer la ruta de PathName (PathName está en formato: "C:\Ruta\AL\Servicio.exe")
        $path = $service.PathName -replace '^"(.*)".*$', '$1'
        if (Test-Path $path) { # Para verificar que la ruta de path existe
            try{ # Para evitar el error con lineas rojas
                $acl = Get-Acl -Path $path
                $acl.Access | ForEach-Object {
                    $user = $_.IdentityReference.Translate([System.Security.Principal.NTAccount]).Value
                    if ($user -notlike "*\$administratorsGroup" -and $user -like "*\$nonAdminGroup") {
                        $permissions = $_.FileSystemRights
                        $permissionString = [System.Security.AccessControl.FileSystemRights]$permissions
                        Write-Host "Carpeta: '$path' --- Servicio: $($service.DisplayName)"
                        Write-Host "   Permiso de Usuarios no admin en la carpeta: $permissionString"
                        
                    }
                }
            } catch {
                Write-Host "Error al acceder a la carpeta del servicio: $($service.DisplayName)"
            }
        }
    }
}

Write-Host "Los Usuarios no administradores puede acceder a los siguientes servicios:"
CheckAdminFoldersPermissions
