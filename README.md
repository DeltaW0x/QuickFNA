# QuickFNA
A quick FNA .Net Native project generator 
![Logo](Resources/logo.png)

## Getting Started
### NOTE:
**This batch is intended to set up projects from zero, if you already have a project, you'll have to do everything by hand, this script won't help you. You might still be able to generate a .NetNative project and just copy all the code from the old to the new project, but i'm not sure it'll work and i take no responsibilities whatsoever**

### Windows Prerequisites
* .Net 8.0 & .Net 7.0
* Python 3.6+
* Visual studio 2022
* CMake
* Git

### Windows Installation
1. Clone the repository
2. Open a Developer Command Prompt for VS 2022
3. Navigate to the directory where you downloaded the previous files
4. Run ```setup_windows.bat ```
5. Enter your project name when required, do not use spaces when naming the project
6. Wait, open the project folder, run the solution and enjoy .Net Native 

---

### ArchLinux Prerequisites
* Git
* All other depencencies are handled by the script
  
### ArchLinux installation
1. Run ```sudo pacman -Sy git``` if git isn't installed
2. Clone the repository
3. Run ```nano ~/.bash_profile```
4. Add the line ```export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib```, save and close
5. Run ```source ~/.bash_profile```
6. Open the directory with the repo file
7. Run ```chmod +x setup_linux.sh```
8. Run ```sudo ./setup_linux.sh```
9. Enter your project name when required, do not use spaces when naming the project
10. Wait, open the project folder, run the solution and enjoy .Net Native

I only have a setup script for Arch because if you're making builds for Linux, there's 99.999% probability that those builds are for a Steam Deck lol. I personally used [ArchWSL](https://github.com/yuk7/ArchWSL.git) so I could go back and forth between Windows and Linux builds quickly. The actual compiled builds are then sent to my Steam Deck for testing, I wouldn't recommended running FNA on WSL 

---

### MacOS installation
MacOS support will be added when FNA will unify iOS, tvOS and MacOS

---

### Consoles
Will be added when i'll be rich and famous and it will be in a private branch anyway lol


