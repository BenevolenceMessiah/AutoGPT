@echo off
setlocal

:::  ________  _______   ________   _______   ___      ___ ________  ___       _______   ________   ________  _______      
::: |\   __  \|\  ___ \ |\   ___  \|\  ___ \ |\  \    /  /|\   __  \|\  \     |\  ___ \ |\   ___  \|\   ____\|\  ___ \     
::: \ \  \|\ /\ \   __/|\ \  \\ \  \ \   __/|\ \  \  /  / | \  \|\  \ \  \    \ \   __/|\ \  \\ \  \ \  \___|\ \   __/|    
:::  \ \   __  \ \  \_|/_\ \  \\ \  \ \  \_|/_\ \  \/  / / \ \  \\\  \ \  \    \ \  \_|/_\ \  \\ \  \ \  \    \ \  \_|/__  
:::   \ \  \|\  \ \  \_|\ \ \  \\ \  \ \  \_|\ \ \    / /   \ \  \\\  \ \  \____\ \  \_|\ \ \  \\ \  \ \  \____\ \  \_|\ \ 
:::    \ \_______\ \_______\ \__\\ \__\ \_______\ \__/ /     \ \_______\ \_______\ \_______\ \__\\ \__\ \_______\ \_______\
:::     \|_______|\|_______|\|__| \|__|\|_______|\|__|/       \|_______|\|_______|\|_______|\|__| \|__|\|_______|\|_______|
::: 
:::  _____ ______   _______   ________   ________  ___  ________  ___  ___     
::: |\   _ \  _   \|\  ___ \ |\   ____\ |\   ____\|\  \|\   __  \|\  \|\  \    
::: \ \  \\\__\ \  \ \   __/|\ \  \___|_\ \  \___|\ \  \ \  \|\  \ \  \\\  \   
:::  \ \  \\|__| \  \ \  \_|/_\ \_____  \\ \_____  \ \  \ \   __  \ \   __  \  
:::   \ \  \    \ \  \ \  \_|\ \|____|\  \\|____|\  \ \  \ \  \ \  \ \  \ \  \ 
:::    \ \__\    \ \__\ \_______\____\_\  \ ____\_\  \ \__\ \__\ \__\ \__\ \__\
:::     \|__|     \|__|\|_______|\_________\\_________\|__|\|__|\|__|\|__|\|__|
:::                             \|_________\|_________|
::: ___  ________   ________  _________  ________  ___       ___       _______   ________     
::: |\  \|\   ___  \|\   ____\|\___   ___\\   __  \|\  \     |\  \     |\  ___ \ |\   __  \    
::: \ \  \ \  \\ \  \ \  \___|\|___ \  \_\ \  \|\  \ \  \    \ \  \    \ \   __/|\ \  \|\  \   
:::  \ \  \ \  \\ \  \ \_____  \   \ \  \ \ \   __  \ \  \    \ \  \    \ \  \_|/_\ \   _  _\  
:::   \ \  \ \  \\ \  \|____|\  \   \ \  \ \ \  \ \  \ \  \____\ \  \____\ \  \_|\ \ \  \\  \| 
:::    \ \__\ \__\\ \__\____\_\  \   \ \__\ \ \__\ \__\ \_______\ \_______\ \_______\ \__\\ _\ 
:::     \|__|\|__| \|__|\_________\   \|__|  \|__|\|__|\|_______|\|_______|\|_______|\|__|\|__|
:::                    \|_________|

for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
:: Play soundbyte from audio
if not exist audio\ mkdir audio
cd audio
set "file=Benevolence_Messiah_DJ_Kwe.wav"
( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%file%"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >sound.vbs
start /min sound.vbs
cd ..

timeout /t 3

:: Download the repo code if its not downloaded.
echo As-salamu alaykum!!
echo detecting presence of repo, git cloning if not detected...
echo ---------------------------------------------------------------
if exist docs\ goto Menu1
git clone https://github.com/BenevolenceMessiah/AutoGPT.git
cd AutoGPT
git pull
cd audio
set "file=Benevolence_Messiah_DJ_Kwe.wav"
( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%file%"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >sound.vbs
start /min sound.vbs
cd ..
echo ---------------------------------------------------------------

:Menu1
echo ---------------------------------------------------------------
echo Please choose from the following options:
echo - These options are all case sensitive.
echo - Make sure Docker Desktop is up and running on your system!
echo - Press Ctrl+c to exit at any time!
echo ---------------------------------------------------------------
echo 1) Install AutoGPT (configured for Docker install, uncomment 
echo    the relevant code in the 'Run' section in this .bat file to
echo    install via Poetry this is unrecommended on Windows according to the 
echo    documentation, some things may not work).
echo 2) Run AutoGPT (local Llama).
echo B) Run AutoGPT Via Docker (API).
echo 3) Open Documentation (Recommended)!
echo I) Install Docker Desktop (if you don't have it installed).
echo C) Exit.
echo U) Update repo.
echo ---------------------------------------------------------------

set /P option=Enter your choice:
if %option% == 1 goto Install
if %option% == B goto Run
if %option% == 2 goto Run2
if %option% == I goto DockerDesktop
if %option% == 3 goto Documentation
if %option% == C goto End
if %option% == U goto Updater

:Install
echo ---------------------------------------------------------------
echo Creating virtual environment
echo ---------------------------------------------------------------
if not exist venv (
    py -3.10 -m venv .venv
) else (
    echo Existing venv detected. Activating.
)
echo Activating virtual environment
call .venv\Scripts\activate
echo ---------------------------------------------------------------
python.exe -m pip install --upgrade pip
pip install docker
docker pull node:20-alpine
docker run node:20-alpine node -v
docker run node:20-alpine npm -v
:: npm install
:: npm install yarn
start call npm install -g yarn
pip install poetry
cd rnd
cd autogpt_server
poetry install
poetry run prisma migrate deploy
poetry run prisma generate
start call poetry run app
cd ..
cd autogpt_builder
:: start call npm install
:: start call yarn install
start call yarn dev
cd ..
cd ..
:: npm install
:: npm install -g yarn
:: pip install poetry
:: cd rnd
:: cd autogpt_builder
:: npm install
:: npm install -g yarn
:: yarn install
:: npm run dev
:: cd ..
:: cd autogpt_server
:: pip install poetry
:: poetry install
:: poetry run prisma migrate deploy
:: poetry run prisma generate
:: start call poetry run app
:: cd ..
:: cd autogpt_builder
:: start call yarn dev
:: cd ..
:: cd ..
:: pip install poetry
:: poetry config virtualenvs.in-project true
:: poetry shell
:: poetry install
:: poetry run prisma generate
:: start call poetry run app
:: cd ..
pip install docker
docker pull significantgravitas/auto-gpt
docker compose run --rm auto-gpt run --install-plugin-deps
goto Menu1

:Run2
echo ---------------------------------------------------------------
echo Firing up the server...
echo And
echo Firing up the CLI!
echo ---------------------------------------------------------------
if not exist venv (
    py -3.10 -m venv .venv
) else (
    echo Existing venv detected. Activating.
)
echo Activating virtual environment
call .venv\Scripts\activate
echo ---------------------------------------------------------------
echo Navigate to the autogpt folder, copy .env-template to .env
echo Edit the .env file:
echo 1. set SMART_LLM/FAST_LLM or both to mistral-7b-instruct-v0.2.
echo 2. If the server is running on different address than http://localhost:8080/v1, 
echo    set LLAMAFILE_API_BASE in .env to the right base URL.
echo 3. To force GPU acceleration, add --use-gpu to the command.
echo 4. These instructions will download and use mistral-7b-instruct-v0.2.Q5_K_M.llamafile. 
echo    mistral-7b-instruct-v0.2 is currently the only tested and supported model. If you 
echo    want to try other models, you'll have to add them to LlamafileModelName in llamafile.py. 
echo    For optimal results, you may also have to add some logic to adapt the message format, 
echo    like LlamafileProvider._adapt_chat_messages_for_mistral_instruct(..) does.
timeout /t -1
cd autogpt
start call python ./scripts/llamafile/serve.py
timeout /t -1
cd ..
goto Menu1

:Run
echo ---------------------------------------------------------------
echo Firing up the server...
echo And
echo Firing up the CLI!
echo ---------------------------------------------------------------
if not exist venv (
    py -3.10 -m venv .venv
) else (
    echo Existing venv detected. Activating.
)
echo Activating virtual environment
call .venv\Scripts\activate
echo ---------------------------------------------------------------
:: cd rnd
:: cd autogpt_server
:: start call poetry run app
:: cd ..
:: cd ..
:: start call cli.py
:: docker compose run --rm auto-gpt
docker compose run --rm auto-gpt run --install-plugin-deps
echo ---------------------------------------------------------------
echo Navigate to the autogpt folder, copy .env-template to .env
echo Edit your settings in the .env file.
timeout /t -1
goto Menu1

:DockerDesktop
echo Installing Docker Desktop
echo ---------------------------------------------------------------
cd /d %~dp0
call curl "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module" -o docker-desktop-installer.exe
start call docker-desktop-installer.exe
echo Once the install is complete, continue.
echo ---------------------------------------------------------------
timeout /t -1
echo Restarting...
echo Deleting installer .exe file if it exists...
echo ---------------------------------------------------------------
if exist docker-desktop-installer.exe del docker-desktop-installer.exe
start call Run_AutoGPT.bat
exit

:Documentation
echo Launching Documentation...
echo you may close the extra CMD window that launches.
echo ---------------------------------------------------------------
start start https://docs.agpt.co/
goto Menu1

:Updater
echo ---------------------------------------------------------------
echo Updating repo...
echo ---------------------------------------------------------------
ls | xargs -I{} git -C {} pull
echo Complete!
echo ---------------------------------------------------------------
goto Menu1

:End 
echo ---------------------------------------------------------------
echo As-salamu alaykum!!
echo ---------------------------------------------------------------
pause