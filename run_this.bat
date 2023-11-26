
set /p project_name=Insert project name: 

IF EXIST FNA3D RMDIR /S /Q FNA3D
IF EXIST FAudio RMDIR /S /Q FAudio
IF EXIST Theorafile RMDIR /S /Q Theorafile
IF EXIST SDL2 RMDIR /S /Q SDL2

git clone --recursive https://github.com/FNA-XNA/FNA3D.git
git clone --recursive https://github.com/FNA-XNA/FAudio.git
git clone --recursive https://github.com/FNA-XNA/Theorafile.git

curl -OL https://github.com/libsdl-org/SDL/releases/download/release-2.28.5/SDL2-devel-2.28.5-VC.zip
Tar -m -xf SDL2-devel-2.28.5-VC.zip
del SDL2-devel-2.28.5-VC.zip
ren SDL2-2.28.5 SDL2

curl -OL https://fna.flibitijibibo.com/archive/fnalibs.tar.bz2
mkdir fnalibs
Tar -m -xf fnalibs.tar.bz2 -C fnalibs
del fnalibs.tar.bz2

set SDL2_DIR=..\SDL2

cd FNA3D
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release
cmake --build build --config Release
cd ..

cd FAudio
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release
cmake --build build --config Release
cd ..

cd Theorafile
cd visualc
msbuild libtheorafile.sln /p:PlatformToolset=v143 /property:Configuration=Release
cd ..
cd ..

dotnet new sln --output %project_name%
cd %project_name%

IF EXIST FNA RMDIR /S /Q FNA
git clone --recursive https://github.com/FNA-XNA/FNA.git

dotnet new console -lang "C#" -n %project_name% -f net8.0 --use-program-main
dotnet add %project_name%/%project_name%.csproj reference FNA/FNA.Core.csproj

dotnet sln %project_name%.sln add %project_name%/%project_name%.csproj
dotnet sln %project_name%.sln add FNA/FNA.Core.csproj

cd %project_name%
curl -O https://gist.githubusercontent.com/DeltaW0x/51fa36ba561f991b328e7d683cd66a36/raw/1f7dacee2bb02e818d479fcfd81b39fa34b2e51c/rd.xml
curl -O https://gist.githubusercontent.com/TheSpydog/53ce4216a1ed5455dbb99d25ed2c6c6c/raw/da340422d9e0638f56393480565433ef7fa47d6d/SDLApis.txt
cd ..
cd ..

python setup_projects_DO_NOT_TOUCH_THIS.py %project_name%

move /y FNA3D\build\Release\FNA3D.lib                %project_name%/%project_name% 
move /y FNA3D\build\Release\mojoshader.lib           %project_name%/%project_name% 
move /y FAudio\build\Release\FAudio.lib              %project_name%/%project_name% 
move /y Theorafile\visualc\Release\libtheorafile.lib %project_name%/%project_name% 
move /y SDL2\lib\x64\SDL2.lib                        %project_name%/%project_name% 

dotnet build %project_name%/%project_name%/%project_name%.csproj -c Release
dotnet build %project_name%/%project_name%/%project_name%.csproj -c Debug

copy fnalibs\x64\FNA3D.dll  %project_name%\%project_name%\bin\Release\net8.0
copy fnalibs\x64\FAudio.dll  %project_name%\%project_name%\bin\Release\net8.0 
copy fnalibs\x64\libtheorafile.dll  %project_name%\%project_name%\bin\Release\net8.0
copy fnalibs\x64\SDL2.dll  %project_name%\%project_name%\bin\Release\net8.0

copy fnalibs\x64\FNA3D.dll  %project_name%\%project_name%\bin\Debug\net8.0
copy fnalibs\x64\FAudio.dll  %project_name%\%project_name%\bin\Debug\net8.0 
copy fnalibs\x64\libtheorafile.dll  %project_name%\%project_name%\Debug\Release\net8.0
copy fnalibs\x64\SDL2.dll  %project_name%\%project_name%\bin\Debug\net8.0

RMDIR /S /Q FNA3D
RMDIR /S /Q FAudio
RMDIR /S /Q Theorafile
RMDIR /S /Q SDL2
RMDIR /S /Q fnalibs

