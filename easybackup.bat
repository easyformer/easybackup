@echo off
setlocal enableextensions enabledelayedexpansion
color 0A
REM chcp 65001 > nul

REM #     ____     ######################################
REM #    /___/`    # Nom du script: Easy Backup    
REM #    (O,O)     # Utilit‚: ce script sert … sauvegarder votre keepass
REM #   /(   )\    # Usage: easybackup.bat sans options
REM # --==M=M==--  # Auteur: Alex FALZON
REM #     Easy     # Mise … jour le: 14/05/2024
REM # F O R M E R  ######################################

REM liste des contributeurs: Alex FALZON, Victor CUILLANDRE, Nelson Fontes Queiros, 
rem Maxime ROSMADE, Quentin MENDER, Alban ROYER, Fares MAHMOUD, 
rem Michael BITSINDOU, Haseeb ARIF, Alex PETIT


REM Le format de ce fichier est en OEM 850 pour permettre les accents
REM Dans Notepad++ vous pouvez change ce format dans:
REM -> Encodage -> Codage des caractŠres -> Langues d'Europe occidentale -> OEM 850

REM LOGO en ‚criture directe:
REM echo      ____       ______                  ____             _                 
REM echo     /___/`     ^|  ____^|                ^|  _ \           ^| ^|                
REM echo     (O,O)      ^| ^|__   __ _ ___ _   _  ^| ^|_) ^| __ _  ___^| ^| ___   _ _ __   
REM echo    /(   )\     ^|  __^| / _` / __^| ^| ^| ^| ^|  _ ^< / _` ^|/ __^| ^|/ / ^| ^| ^| '_ \  
REM echo  --==M=M==--   ^| ^|___^| (_^| \__ \ ^|_^| ^| ^| ^|_) ^| (_^| ^| (__^|   ^<^| ^|_^| ^| ^|_) ^| 
REM echo      Easy      ^|______\__,_^|___/\__, ^| ^|____/ \__,_^|\___^|_^|\_\\__,_^| .__/  
REM echo  F O R M E R                     __/ ^|                             ^| ^|     
REM echo                                 ^|___/                              ^|_^|     

REM d‚ffinition de la banniŠre
set "bannerline[1]=      ____       ______                  ____             _                 "
set "bannerline[2]=     /___/`     |  ____|                |  _ \           | |                "
set "bannerline[3]=     (O,O)      | |__   __ _ ___ _   _  | |_) | __ _  ___| | ___   _ _ __   "
set "bannerline[4]=    /(   )\     |  __| / _` / __| | | | |  _ < / _` |/ __| |/ / | | | '_ \  "
set "bannerline[5]=  --==M=M==--   | |___| (_| \__ \ |_| | | |_) | (_| | (__|   <| |_| | |_) | "
set "bannerline[6]=      Easy      |______\__,_|___/\__, | |____/ \__,_|\___|_|\_\\__,_| .__/  "
set "bannerline[7]=  F O R M E R                     __/ |                             | |     "
set "bannerline[8]=                                 |___/                              |_|     "

REM ############################################################################
REM ####################      Tƒche de sauvegarde      #########################
REM ############################################################################

if /i "%1" == "" goto debut
set param=%1
for /F "tokens=1-2 delims=/" %%a in (%param%) do (
	set taskversion=%%a
	set taskrepathtemp=%%b
	set taskreppath=!taskrepathtemp:?= !
)

cls
REM Affichage de la banniŠre
for /l %%i in (1,1,8) do (echo !bannerline[%%i]!)
echo.
ping -n 2 127.0.0.1 > nul


REM -------- MEMORISATION ET DECOMPOSITON DE LA DATE DU JOUR ---------
REM jo = jour de la sauvegarde
set jo=%date:~0,2%
REM mo= mois de la sauvegarde
set mo=%date:~3,2%
REM an= ann‚e de la sauvegarde
set an=%date:~6,4%


if %taskversion% == 0 (
	if exist %taskreppath% (
		xcopy %taskreppath%* "%taskreppath%..\_easybackup\%an%-%mo%-%jo%-sauvegarde\" /E /A /H /Y
	cls
	REM Affichage de la banniŠre
	for /l %%i in (1,1,8) do (echo !bannerline[%%i]!)
	echo.
	echo.
	echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	echo ³ La sauvegarde a ‚t‚ effectu‚e             ³
	echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	echo.
	ping -n 1 127.0.0.1 > nul
	)
	if not exist %taskreppath%..\_easybackup\%an%-%mo%-%jo%-sauvegarde\ (
		echo problème sur "%taskreppath%..\_easybackup\%an%-%mo%-%jo%-sauvegarde\" >> %homepath%\Desktop\Erreur-EasyBackup.txt
	)
) else (
	if exist %taskreppath% (
		xcopy %taskreppath%* "%taskreppath%..\_easybackup\Quotidiennes\%an%-%mo%-%jo%-sauvegarde\" /E /A /H /Y
		cls
		REM Affichage de la banniŠre
		for /l %%i in (1,1,8) do (echo !bannerline[%%i]!)
		echo.
		echo.
		echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		echo ³ La sauvegarde quotidienne a ‚t‚ effectu‚e ³
		echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		echo.
		ping -n 1 127.0.0.1 > nul
		if %jo% == 01 (
			xcopy %taskreppath%* "%taskreppath%..\_easybackup\Mensuelles\%an%-%mo%-%jo%-sauvegarde\" /E /A /H /Y
			cls
			REM Affichage de la banniŠre
			for /l %%i in (1,1,8) do (echo !bannerline[%%i]!)
			echo.
			echo.
			echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo ³ La sauvegarde mensuelle a ‚t‚ effectu‚e   ³
			echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
			ping -n 1 127.0.0.1 > nul
			if %mo% == 01 (
				xcopy %taskreppath%* "%taskreppath%..\_easybackup\Annuelles\%an%-%mo%-%jo%-sauvegarde\" /E /A /H /Y
				cls
				REM Affichage de la banniŠre
				for /l %%i in (1,1,8) do (echo !bannerline[%%i]!)
				echo.
				echo.
				echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				echo ³ La sauvegarde annuelle a ‚t‚ effectu‚e    ³
				echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				echo.
				ping -n 1 127.0.0.1 > nul
			)
		)
	)
	if not exist %taskreppath%..\_easybackup\Quotidiennes\%an%-%mo%-%jo%-sauvegarde\ (
		echo problème sur "%taskreppath%..\_easybackup\%an%-%mo%-%jo%-sauvegarde\" >> %homepath%\Desktop\Erreur-EasyBackup.txt
	)
)

REM ############################################################################
REM #################      Nettoyage des sauvegardes      ######################
REM ############################################################################

if %taskversion% == 0 (

	set chemin=%taskreppath%..\_easybackup\Mensuelles

	rem Compter le nombre de fichiers dans le r‚pertoire
	set "count=0"
	for /f %%A in ('dir /b /a-d "%chemin%" ^| find /c /v ""') do set count=%%A

	rem Supprimer tous les fichiers sauf les 12 derniers
	set "keep=!count!"
	set /a "delete=!count!-12"
	for /f "skip=%delete% delims=" %%F in ('dir /b /a-d /o-d "%chemin%"') do (
		if !delete! gtr 0 (
			del /q "%chemin%\%%F"
			set /a "delete-=1"
		)
	)

	rem Compter le nombre de r‚pertoires dans le r‚pertoire
	set "count=0"
	for /d %%A in ("%chemin%\*") do (
		set /a "count+=1"
	)

	rem Supprimer tous les r‚pertoires sauf les 12 derniers
	set "keep=!count!"
	set /a "delete=!count!-12"
	for /f "skip=%delete% delims=" %%D in ('dir /b /ad /o-d "%chemin%"') do (
		if !delete! gtr 0 (
			rd /s /q "%chemin%\%%D"
			set /a "delete-=1"
		)
	)



	set chemin=%taskreppath%..\_easybackup\Quotidiennes

	rem Compter le nombre de fichiers dans le r‚pertoire
	set "count=0"
	for /f %%A in ('dir /b /a-d "%chemin%" ^| find /c /v ""') do set count=%%A

	rem Supprimer tous les fichiers sauf les 12 derniers
	set "keep=!count!"
	set /a "delete=!count!-30"
	for /f "skip=%delete% delims=" %%F in ('dir /b /a-d /o-d "%chemin%"') do (
		if !delete! gtr 0 (
			del /q "%chemin%\%%F"
			set /a "delete-=1"
		)
	)

	rem Compter le nombre de r‚pertoires dans le r‚pertoire
	set "count=0"
	for /d %%A in ("%chemin%\*") do (
		set /a "count+=1"
	)

	rem Supprimer tous les r‚pertoires sauf les 12 derniers
	set "keep=!count!"
	set /a "delete=!count!-30"
	for /f "skip=%delete% delims=" %%D in ('dir /b /ad /o-d "%chemin%"') do (
		if !delete! gtr 0 (
			rd /s /q "%chemin%\%%D"
			set /a "delete-=1"
		)
	)


	echo.
	echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	echo ³ Les anciennes sauvegardes ont ‚t‚ effac‚es³
	echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	echo.
	ping -n 2 127.0.0.1 > nul

)

goto fin

REM ############################################################################
REM #########   fin de la partie sur l'execution de la sauvegarde   ############
REM ############################################################################


REM ############################################################################
REM ####################   D‚claration des variables   #########################
REM ############################################################################

:debut
set repdefault=C:\_gdrive-sync\
	:: Compter le nombre de caractŠres
	for /f "tokens=1,* delims=[,]" %%A in ('"%comspec% /u /c echo:%repdefault%|more|find /n /v """') do set /a nb=%%A-4
	:: Cr‚er une chaŒne d'espaces
set "espaces="
	for /l %%i in (1,1,%nb%) do set "espaces=!espaces! "
	:: Cr‚er une chaŒne de soulignement
set "underline="
	for /l %%i in (1,1,%nb%) do set "underline=!underline!Ä"

set taskName=easybackup
set "xmlFile=%taskName%_task_details.xml"
set choix=""

:mainmenu
:: V‚rifier si la tƒche existe
schtasks /query /tn "%taskName%" 2>nul | findstr /i "%taskName%" >nul
:: Si la tƒche existe
if %errorlevel% equ 0 (
	set "istask=1" 
	REM Exporter la tƒche vers un fichier XML temporaire
	schtasks /query /xml /tn "%taskName%" > %xmlFile%
	REM Extraire et afficher les informations requises du fichier XML temporaire
	for /f "tokens=3 delims=<>" %%a in ('type %xmlFile% ^| findstr /i "<Arguments>"') do (
		set "optionactualtask=%%a"
	)
	for /F "tokens=1,* delims=/" %%a in (!optionactualtask!) do (
		set versionactualtask=%%a
		set diractualtask=%%b
		set diractualtask2=!diractualtask:?= !
	)
) else (
	set "istask=0" 
	set "diractualtask=aucun" 
)
	
cls
REM Affichage de la banniŠre
for /l %%i in (1,1,8) do (echo !bannerline[%%i]!)
echo.


if %istask% == 1 (
	echo La tƒche %taskName% existe d‚j… avec le r‚pertoire !diractualtask2!
	if 	!versionactualtask! == 1 echo La sauvegarde par cycles est activ‚e
	echo.
	echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	echo ³                    Menu                   ³
	echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
	echo ³ 1. Modifier la tƒche                      ³
	echo ³ 2. Supprimer la tƒche                     ³
	echo ³ 3. Afficher la configuration de la tƒche  ³
	echo ³                                           ³
	echo ³ 4. Voir les sauvegardes                   ³
	echo ³                                           ³
	echo ³ 5. Quitter                                ³
	echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	echo.
	echo Faites votre choix: (1,2,3,4 ou 5^):
) else (
	echo La tƒche %taskName% n'existe pas encore
	echo.
	echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	echo ³                    Menu                   ³
	echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
	echo ³ 1. Cr‚er la tƒche                         ³
	echo ³ 2. Quitter                                ³
	echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	echo.
	echo Faites votre choix: (1 ou 2^):
)

:choice
set /p choice=""
if %istask% == 1 (
	if %choice% == 1 goto createtask
	if %choice% == 2 goto deletetask
	if %choice% == 3 goto exporttask
	if %choice% == 4 goto opendirsave
	if %choice% == 5 goto fin
	echo Choix invalide. Veuillez choisir entre 1,2,3,4 ou 5.
	goto choice
) else (
	if %choice% == 1 goto createtask
	if %choice% == 2 goto fin
	echo Choix invalide. Veuillez choisir entre 1 ou 2.
	goto choice
)


:createtask
cls
REM Affichage de la banniŠre
for /l %%i in (1,1,8) do (echo !bannerline[%%i]!)
echo.
if %istask% == 1 (
	echo Modification de la tƒche de sauvegarde
) else (
	echo Cr‚ation de la tƒche de sauvegarde
)
echo.
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ%underline%¿
echo ³     Choix du r‚pertoire de sauvegarde%espaces%³
echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ%underline%´
echo ³ 1. Utiliser le r‚pertoire %repdefault%           ³
echo ³ 2. Choisir un r‚pertoire existant    %espaces%³
echo ³ 3. Cr‚er et utiliser un r‚pertoire   %espaces%³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ%underline%Ù
echo.


:choisedir
set /p choisedir="Faites votre choix: (1,2 ou 3): "

if %choisedir% == 1 goto usedefault
if %choisedir% == 2 goto chooserep
if %choisedir% == 3 goto createdir
echo Choix invalide. Veuillez choisir entre 1,2 ou 3.
goto choisedir


:createdir
	echo.
	set /p reppath="Indiquez le chemin complet du repertoire a cr‚er:"
	MKDIR %reppath%
	If exist %reppath% echo cr‚ation du repertoire %reppath% r‚ussi
	If exist %reppath% goto suite
	echo.
	echo D‚sol‚ il est impossible de cr‚er le r‚pertoire.
	echo.
	pause
	goto main_menu


:chooserep
	echo.
	set /p reppath="Indiquez le chemin complet du repertoire:"
	If exist %reppath% goto suite
	echo.
	echo Attention le r‚pertoire n'existe pas.
	goto chooserep


:usedefault
	echo.
	echo Vous avez choisi d'utiliser %repdefault% pour votre sauvegarde
	echo.
	If exist %repdefault% ( 
		set reppath=%repdefault%
	)
	goto suite


:suite
	MKDIR "%reppath%..\_easybackup\Application EasyBackup - NE PAS EFFACER" > nul
	copy  "%~f0" "%reppath%..\_easybackup\Application EasyBackup - NE PAS EFFACER\" > nul
	echo.
	echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	echo ³    Choix de la fr‚quence de sauvegarde    ³
	echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
	echo ³ 1. sauvegarde quotidienne                 ³
	echo ³ 2. sauvegarde hebdomadaire                ³
	echo ³ 3. sauvegarde mensuelle                   ³
	echo ³ 4. sauvegarde par cycles* (recommand‚e)   ³
	echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	echo * La sauvegarde par cycles efface les anciennes sauvegardes.
	echo   Elle conserve dans des r‚pertoires diff‚rents:
	echo - les 30 derniŠres quotidiennes,
	echo - les 12 derniŠres mensuelles,
	echo - une par ann‚e.
	echo.
	
	
:choixfrequence
	set /p choixfrequence="Faites votre choix: (1,2,3 ou 4): "

	if %choixfrequence%==1 (
		set frequence=DAILY
		set versioning=0
		goto suite2
	)
	if %choixfrequence%==2 (
		set frequence=WEEKLY
		set versioning=0
		goto suite2
	)	
	if %choixfrequence%==3 (
		set frequence=MONTHLY 
		set versioning=0
		goto suite2
	)
	if %choixfrequence%==4 (
		set frequence=DAILY
		set versioning=1
		MKDIR %reppath%\..\_easybackup\Quotidiennes
		MKDIR %reppath%\..\_easybackup\Mensuelles
		MKDIR %reppath%\..\_easybackup\Annuelles
		goto suite2
	)
	
	echo.
	echo Attention votre choix n'existe pas.
	goto choixfrequence


:suite2
set /p choixheure="Choisissez l'heure de sauvegarde (0 a 23): "

REM on teste l'heure saisie grace … une boucle FOR
for /l %%X in (0,1,23) do (

    REM Si l'heure est bonne on passera … la suite grace au GOTO
    if %choixheure%==%%X (
	
	    REM on rajoute un z‚ro pour que l'heure soit sur deux caractŠres
	    if %choixheure% LEQ 9 set choixheure="0"%choixheure%
		
	    goto suite3
    )
)

REM si l'heure est mal saisie on reposse la question avec le GOTO
echo.
echo Attention votre choix n'existe pas.
goto suite2


:suite3
REM cr‚ation de la tƒche planifi‚e
echo.
echo cr‚ation de la tƒche suivante:
set reppath2=!reppath: =?!
rem echo schtasks /create /sc %frequence% -mo 1 /TN %taskName% /ST %choixheure%:00:00 /tr "\"%reppath%..\_easybackup\Application EasyBackup - NE PAS EFFACER\easybackup.bat\" \"%versioning%/!reppath2!\"" 
schtasks /create /sc %frequence% -mo 1 /TN %taskName% /ST %choixheure%:00:00 /tr "\"%reppath%..\_easybackup\Application EasyBackup - NE PAS EFFACER\easybackup.bat\" \"%versioning%/!reppath2!\"" 
echo.
pause
goto mainmenu


:deletetask
set /p deleteconfirm="Etes vous s–r de vouloir effacer la tƒche de sauvegarde ? (o/n) "
if %deleteconfirm%==o (
    schtasks /delete /tn "%taskName%" /f
	echo.
	echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	echo ³La suppression de la tƒche a ‚t‚ effectu‚e ³
	echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	echo.
	ping -n 3 127.0.0.1 > nul
	goto mainmenu
)
if %deleteconfirm%==n (
	echo.
	echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	echo ³ La suppression de la tƒche a ‚t‚ annul‚e  ³
	echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	echo.
	ping -n 3 127.0.0.1 > nul
	goto mainmenu
)	
goto deletetask


:exporttask
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
type %xmlFile%
echo.
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
pause
goto mainmenu


:printstatesave

goto mainmenu


:opendirsave
start "" "!diractualtask2!..\_easybackup\"
goto mainmenu


:deletesave

goto mainmenu


:fin
echo.
echo Merci et a bient“t :-)
ping -n 3 127.0.0.1 > nul
