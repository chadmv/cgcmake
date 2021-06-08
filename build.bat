@echo off
pushd %~dp0
for /f "delims== tokens=1,2" %%G in (..\version.txt) do set %%G=%%H
echo version %version%
echo mayaVersion %mayaVersion%

if not exist bin mkdir bin
cd bin
del /s /q /f *.mll
cd ..

FOR %%G IN (%mayaVersion%) DO (call :subroutine "%%G")
popd
GOTO :eof


:subroutine
set builddir=build.%1
if not exist %builddir% goto BUILDENV
rmdir %builddir% /S /Q
:BUILDENV
mkdir %builddir%
cd %builddir%
cmake -DVERSION=%version% -A x64 -DCMAKE_TOOLCHAIN_FILE=../../../../cgcmake/toolchain/%1.cmake  -DMAYA_VERSION=%1 ../
cmake  --build . --target meshCompare --config Release
cd ..
xcopy .\build.%1\src\Release\meshCompare.mll .\bin\meshCompare_%1.mll* /Y
goto :eof
