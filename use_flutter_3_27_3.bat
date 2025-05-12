@echo off
echo Setting up Flutter 3.27.3 for your project...
cd %~dp0
call fvm use 3.27.3
echo.
echo Now running Flutter clean and pub get...
call .fvm\flutter_sdk\bin\flutter clean
call .fvm\flutter_sdk\bin\flutter pub get
echo.
echo Flutter setup complete. You can now run your app with:
echo .fvm\flutter_sdk\bin\flutter run
