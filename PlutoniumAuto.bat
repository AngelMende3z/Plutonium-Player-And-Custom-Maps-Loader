@echo off
setlocal enabledelayedexpansion

set "logFile=instalacion_plutonium.log"

del "%logFile%" 2>nul

echo =========================================== >> "%logFile%"
echo Log de Instalación de Plutonium >> "%logFile%"
echo Fecha: %date% >> "%logFile%"
echo Hora: %time% >> "%logFile%"
echo =========================================== >> "%logFile%"
echo. >> "%logFile%"

chcp 65001 > nul

echo Script iniciado con exito.
echo Script iniciado con exito. >> "%logFile%"

echo.
echo Configurando rutas...
echo. >> "%logFile%"
echo Configurando rutas... >> "%logFile%"
set "plutoniumStorage=%localappdata%\Plutonium\storage"
set "uiMpMenusDir=%plutoniumStorage%\t6\raw\ui_mp\t6\menus"
set "zmScriptsDir=%plutoniumStorage%\t6\scripts\zm"
set "plutoniumLauncher=%localappdata%\Plutonium\bin\plutonium-launcher-win32.exe"

echo.
echo Verificando y copiando privategamelobby_project.lua desde LobbyEdit...
echo. >> "%logFile%"
echo Verificando y copiando privategamelobby_project.lua desde LobbyEdit... >> "%logFile%"

set "sourceLuaFile=%CD%\LobbyEdit\privategamelobby_project.lua"
set "destLuaFile=%uiMpMenusDir%\privategamelobby_project.lua"

:: Comprueba si el archivo de destino existe antes de compararlo
if exist "%destLuaFile%" (
    :: Compara el archivo de origen con el de destino
    fc /b "%sourceLuaFile%" "%destLuaFile%" > nul
    if %errorlevel% equ 0 (
        echo El archivo privategamelobby_project.lua es idéntico, no se reemplaza.
        echo El archivo privategamelobby_project.lua es idéntico, no se reemplaza. >> "%logFile%"
    ) else (
        echo El archivo privategamelobby_project.lua es diferente, se reemplaza.
        echo El archivo privategamelobby_project.lua es diferente, se reemplaza. >> "%logFile%"
        xcopy /i "%sourceLuaFile%" "%uiMpMenusDir%" /y > nul 2>&1 >> "%logFile%"
    )
) else (
    echo El archivo privategamelobby_project.lua no existe en el destino, se copia.
    echo El archivo privategamelobby_project.lua no existe en el destino, se copia. >> "%logFile%"
    xcopy /i "%sourceLuaFile%" "%uiMpMenusDir%" /y > nul 2>&1 >> "%logFile%"
)

echo.
echo Verificando y copiando carpeta 'scripts'...
echo. >> "%logFile%"
echo Verificando y copiando carpeta 'scripts'... >> "%logFile%"

set "sourceScriptsDir=%CD%\scripts"
set "destScriptsDir=%zmScriptsDir%"

:: Para carpetas, la comparación es más compleja. Una forma simple es verificar si la carpeta de destino existe.
:: Si existe, podemos borrarla y copiar, o usar xcopy con /d para solo copiar archivos más nuevos.
:: Para una verificación estricta de "igualdad de contenido", necesitaríamos comparar cada archivo individualmente o sus hashes,
:: lo cual es mucho más complejo en Batch. Optaremos por un reemplazo condicional o xcopy /d.

:: Opción 1: Si quieres verificar si ALGO ha cambiado y copiar solo lo más nuevo (recomendado para carpetas)
:: xcopy /d /i /e /y para copiar solo archivos más nuevos y sobrescribir si el origen es más reciente
echo Usando xcopy /d para copiar solo archivos mas nuevos o modificados en la carpeta 'scripts'.
echo Usando xcopy /d para copiar solo archivos mas nuevos o modificados en la carpeta 'scripts'. >> "%logFile%"
xcopy /d /i /e "%sourceScriptsDir%" "%destScriptsDir%" /y > nul 2>&1 >> "%logFile%"
if %errorlevel% equ 0 (
    echo La carpeta 'scripts' ha sido actualizada si habia cambios.
    echo La carpeta 'scripts' ha sido actualizada si habia cambios. >> "%logFile%"
) else (
    echo No se encontraron cambios en la carpeta 'scripts' o hubo un error al copiar.
    echo No se encontraron cambios en la carpeta 'scripts' o hubo un error al copiar. >> "%logFile%"
)


:: Opción 2: Si quieres comparar contenido exacto de CADA ARCHIVO en las carpetas y solo copiar si son diferentes (MUCHO MÁS COMPLEJO EN BATCH)
:: Esta opción no está implementada aquí por su complejidad, pero se menciona para aclarar.
:: Requeriría un bucle para cada archivo y una comparación hash o fc para cada uno.

echo.
echo Instalacion completada. Script por elmendezzzzz
echo. >> "%logFile%"
echo Instalacion completada. Script por elmendezzzzz >> "%logFile%"
timeout 2 > nul

echo.
echo Iniciando Plutonium...
echo. >> "%logFile%"
echo Iniciando Plutonium... >> "%logFile%"
timeout 3 > nul

start "" "%plutoniumLauncher%"

echo.
echo Proceso finalizado.
echo. >> "%logFile%"
echo Proceso finalizado. >> "%logFile%"

endlocal