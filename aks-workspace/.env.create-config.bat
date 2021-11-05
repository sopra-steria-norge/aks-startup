cd %~dp0
cd ../..

mkdir aks-startup-config

cd aks-startup-config

REM Only copy if not existing
echo n | copy /-y %~dp0.env .

cd %~dp0