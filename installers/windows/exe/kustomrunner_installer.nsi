!include "MUI2.nsh"

Name "Kustomrunner"
OutFile "KustomrunnerInstaller.exe"
InstallDir "$PROGRAMFILES\Kustomrunner"
RequestExecutionLevel user

!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Section "Install"
    SetOutPath "$INSTDIR"

    ; copy main files
    File /r "..\..\..\kustomrunner\*"

    ; create desktop shortcut
    CreateShortcut "$DESKTOP\Kustomrunner.lnk" "$INSTDIR\main.bat"

    ; start menu folder
    CreateDirectory "$SMPROGRAMS\Kustomrunner"
    CreateShortcut "$SMPROGRAMS\Kustomrunner\Kustomrunner.lnk" "$INSTDIR\main.bat"

    ; uninstaller
    WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Uninstall"
    Delete "$DESKTOP\Kustomrunner.lnk"
    Delete "$SMPROGRAMS\Kustomrunner\Kustomrunner.lnk"

    RMDir /r "$SMPROGRAMS\Kustomrunner"
    RMDir /r "$INSTDIR"

SectionEnd
