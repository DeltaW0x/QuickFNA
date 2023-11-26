#!/bin/bash
read -p 'Insert project name: ' project_name

sudo pacman -Sy --needed sdl2 sdl2_image sdl2_mixer sdl2_ttf
sudo pacman -Sy --needed python-pip
sudo pacman -Sy --needed cmake
sudo pacman -Sy --needed make
sudo pacman -Sy --needed gcc
sudo pacman -Sy --needed wget
sudo pacman -Sy --needed dotnet-sdk

wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
sudo ./dotnet-install.sh --install-dir /usr/share/dotnet --channel 7.0
sudo ./dotnet-install.sh --install-dir /usr/share/dotnet --channel 8.0

rm -rf FNA3D
rm -rf FAudio
rm -rf Theorafile

git clone --recursive https://github.com/FNA-XNA/FNA3D.git
git clone --recursive https://github.com/FNA-XNA/FAudio.git
git clone --recursive https://github.com/FNA-XNA/Theorafile.git

cd FNA3D
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release
cmake --build build --config Release
cd ..

cd FAudio
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release
cmake --build build --config Release
cd ..

cd Theorafile
make
cd ..

dotnet new sln --output $project_name
cd $project_name

git clone --recursive https://github.com/FNA-XNA/FNA.git

dotnet new console -lang "C#" -n $project_name -f net8.0 --use-program-main
dotnet add $project_name/$project_name.csproj reference FNA/FNA.Core.csproj

dotnet sln $project_name.sln add $project_name/$project_name.csproj
dotnet sln $project_name.sln add FNA/FNA.Core.csproj

cd $project_name
curl -O https://gist.githubusercontent.com/DeltaW0x/51fa36ba561f991b328e7d683cd66a36/raw/1f7dacee2bb02e818d479fcfd81b39fa34b2e51c/rd.xml
curl -O https://gist.githubusercontent.com/TheSpydog/53ce4216a1ed5455dbb99d25ed2c6c6c/raw/da340422d9e0638f56393480565433ef7fa47d6d/SDLApis.txt
cd ..
cd ..

python leavethisalone.py $project_name

sudo cp -p FNA3D/build/[libFNA3D]*      /usr/local/lib           
sudo cp -p FAudio/build/[libFAudio]*    /usr/local/lib    
sudo cp -p Theorafile/libtheorafile.so  /usr/local/lib 

dotnet build $project_name/$project_name/$project_name.csproj -c Release --os linux
dotnet build $project_name/$project_name/$project_name.csproj -c Debug   --os linux

wget https://fna.flibitijibibo.com/archive/fnalibs.tar.bz2
mkdir fnalibs
tar -xf fnalibs.tar.bz2 -C fnalibs/

sudo cp -p fnalibs/lib64/libFNA3D.so.0       $project_name/$project_name/bin/Release/net8.0/linux-x64   
sudo cp -p fnalibs/lib64/libFAudio.so.0      $project_name/$project_name/bin/Release/net8.0/linux-x64
sudo cp -p fnalibs/lib64/libtheorafile.so    $project_name/$project_name/bin/Release/net8.0/linux-x64
sudo cp -p fnalibs/lib64/libSDL2-2.0.so.0    $project_name/$project_name/bin/Release/net8.0/linux-x64

sudo cp -p fnalibs/lib64/libFNA3D.so.0       $project_name/$project_name/bin/Debug/net8.0/linux-x64 
sudo cp -p fnalibs/lib64/libFAudio.so.0      $project_name/$project_name/bin/Debug/net8.0/linux-x64  
sudo cp -p fnalibs/lib64/libtheorafile.so    $project_name/$project_name/bin/Debug/net8.0/linux-x64
sudo cp -p fnalibs/lib64/libSDL2-2.0.so.0    $project_name/$project_name/bin/Debug/net8.0/linux-x64

rm -rf fnalibs.tar.bz2 FNA3D FAudio Theorafile dotnet-install.sh fnalibs
