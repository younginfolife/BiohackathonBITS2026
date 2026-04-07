@echo off
setlocal

set IMAGE_NAME=ghcr.io/younginfolife/biohackathonbits2026:latest
set SCRIPT_DIR=%~dp0

docker run --rm -it ^
  --platform linux/amd64 ^
  -p 8888:8888 ^
  -v "%SCRIPT_DIR%:/sharedFolder" ^
  %IMAGE_NAME%

endlocal
