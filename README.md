# non-admin-folder-permissions

Este script esta basado en la busqueda de permisos de usuarios no administradores, dentro de las carpetas de los servicios a los que son accesibles, en base al comando "Get-WmiObject Win32_Service | Select-Object DisplayName, PathName"

Para habilitar la ejecucion de scripts:
```
Set-ExecutionPolicy Bypass -Scope Process
```

Ejecutar powershell como administrador y correr el script:
```
./verificador.ps1
```

- - -

<h3>Ejemplo:</h3>
Dentro de un equipo se tiene al usuario "noble", perteneciente al grupo de usuarios no administradores llamados "Users" <br />

![image](https://github.com/ITSec-Chile/non-admin-folder-permissions/assets/43393014/14171fea-2783-42f7-8ac7-270dd29591e1)

Modificamos los permisos del grupo de usuario en el archivo "C:\Program Files\Windows Media Player\wmpnetwk.exe" con el siguiente comando:
```
icacls "C:\Program Files\Windows Media Player\wmpnetwk.exe" /grant Users:(RX)
```
![image](https://github.com/ITSec-Chile/non-admin-folder-permissions/assets/43393014/ad3128fd-9aaa-48bc-a92d-7af5682374b1)

De tal forma se comprueba que el script detecta los permisos de los usuarios no administradores en ese archivo:

![image](https://github.com/ITSec-Chile/non-admin-folder-permissions/assets/43393014/2d9a4a3f-5dfd-4267-b3d0-65a6f2d62cdc)
