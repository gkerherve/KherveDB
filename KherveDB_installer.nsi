; KherveDB Installer - Version Configuration
; ==== CHANGE THESE VALUES WHEN VERSION UPDATES ====
!define VERSION_NUMBER "4.0"
!define ZIP_FILENAME "KherveDB_4.0.zip"
!define FOLDER_IN_ZIP "KherveDB_4.0"
!define EXE_FILENAME "KherveDB_4.0.exe"
; ===================================================

; Application Configuration
!define APPNAME "KherveDB"
!define FULLNAME "KherveDB_${VERSION_NUMBER}"
!define DESCRIPTION "NIST XPS binding-energy database viewer"

Name "${APPNAME} ${VERSION_NUMBER}"
Caption "${APPNAME} Setup"
BrandingText "${APPNAME} v${VERSION_NUMBER}"

OutFile "KherveDB_Installer.exe"
InstallDir "$DESKTOP\${FULLNAME}"
RequestExecutionLevel admin

!include "MUI2.nsh"

; Modern UI Configuration - Clean look without custom graphics
!define MUI_ABORTWARNING

; Use built-in modern header (no custom bitmaps required)
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT

; Modern color scheme
!define MUI_BGCOLOR 0xFFFFFF
!define MUI_TEXTCOLOR 0x000000

; Welcome Page
!define MUI_WELCOMEPAGE_TITLE "Welcome to ${APPNAME} ${VERSION_NUMBER} Setup"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of ${APPNAME}.$\r$\n$\r$\n${DESCRIPTION}$\r$\n$\r$\nClick Next to continue."

; Directory Page
!define MUI_DIRECTORYPAGE_TEXT_TOP "Choose the folder in which to install ${APPNAME}.$\r$\n$\r$\nIMPORTANT: Do NOT install in Program Files or other read-only locations as the software needs write access. Desktop or My Documents are recommended locations."

; Finish Page
!define MUI_FINISHPAGE_TITLE "Completing the ${APPNAME} Setup"
!define MUI_FINISHPAGE_TEXT "${APPNAME} has been installed on your computer.$\r$\n$\r$\nYou can launch ${APPNAME} from the desktop shortcut.$\r$\n$\r$\nClick Finish to close this wizard."

; Installation progress customization
!define MUI_INSTFILESPAGE_COLORS "000000 FFFFFF"
!define MUI_INSTFILESPAGE_PROGRESSBAR "smooth"

; Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Section "Install"
    SetOutPath $INSTDIR

    DetailPrint "Copying installation files..."
    File "${ZIP_FILENAME}"

    DetailPrint "Extracting files, please be patient - this may take a minute..."
    nsExec::ExecToLog 'powershell -command "Expand-Archive -Path \"$INSTDIR\${ZIP_FILENAME}\" -DestinationPath \"$INSTDIR\" -Force"'
    Delete "$INSTDIR\${ZIP_FILENAME}"

    DetailPrint "Organizing files..."
    CopyFiles /SILENT "$INSTDIR\${FOLDER_IN_ZIP}\*.*" "$INSTDIR\"
    CopyFiles /SILENT "$INSTDIR\${FOLDER_IN_ZIP}\*" "$INSTDIR\"
    RMDir /r "$INSTDIR\${FOLDER_IN_ZIP}"

    DetailPrint "Verifying installation..."
    IfFileExists "$INSTDIR\${EXE_FILENAME}" ExeFound
        MessageBox MB_OK "${EXE_FILENAME} not found after extraction!"
        Abort
    ExeFound:

    DetailPrint "Creating shortcuts..."
    StrCpy $9 "$INSTDIR\Icons\Icon.ico"
    IfFileExists $9 IconFound
        StrCpy $9 "$INSTDIR\Icon.ico"
        IfFileExists $9 IconFound
            StrCpy $9 "$INSTDIR\${EXE_FILENAME}"
    IconFound:

    CreateShortCut "$DESKTOP\${FULLNAME}.lnk" "$INSTDIR\${EXE_FILENAME}" "" "$9" 0

    CreateDirectory "$SMPROGRAMS\${APPNAME}"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\${FULLNAME}.lnk" "$INSTDIR\${EXE_FILENAME}" "" "$9" 0
    CreateShortCut "$SMPROGRAMS\${APPNAME}\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0

    DetailPrint "Finalizing installation..."
    WriteUninstaller "$INSTDIR\uninstall.exe"

    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FULLNAME}" "DisplayName" "${APPNAME} ${VERSION_NUMBER}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FULLNAME}" "UninstallString" "$INSTDIR\uninstall.exe"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FULLNAME}" "InstallLocation" "$INSTDIR"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FULLNAME}" "DisplayIcon" "$9"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FULLNAME}" "DisplayVersion" "${VERSION_NUMBER}"

    DetailPrint "Installation complete!"
SectionEnd

Section "Uninstall"
    Delete "$DESKTOP\${FULLNAME}.lnk"
    Delete "$SMPROGRAMS\${APPNAME}\${FULLNAME}.lnk"
    Delete "$SMPROGRAMS\${APPNAME}\Uninstall.lnk"
    RMDir "$SMPROGRAMS\${APPNAME}"
    RMDir /r "$INSTDIR"
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FULLNAME}"
SectionEnd
