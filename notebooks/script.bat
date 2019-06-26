@echo off
chcp 28591 > nul
jupyter nbconvert --config jekyll
echo.
echo Conversion terminée
echo.
python move.py
echo.
echo Déplacement terminée
echo.

WHERE git > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
	ECHO Actualisation automatique impossible : Git non installé. Pensez à  actualiser le dépôt manuellement !
	echo.
	goto end
) ELSE (
echo Actualiser le dépôt ?(Y/N) 
set INPUT=
set /P INPUT=Y/N: %=%
if /I "%INPUT%" == "Y" goto updateGit
if /I "%INPUT%" == "N" goto noupdateGit
goto noupdateGit
)

:updateGit
cd ../
git pull
git add .
git commit -a -m "commit"
git push
echo.
ECHO Dépôt GitHub actualisé !
echo.
goto end

:noupdateGit
echo.
ECHO Pensez à actualiser le dépôt manuellement !
echo.

:end


pause