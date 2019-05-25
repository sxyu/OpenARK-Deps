; Start
 
  !include "winmessages.nsh"
  !include "MUI.nsh"
  !define MUI_NAME "OpenARK Dependency Pack"
  !define MUI_FILE "savefile"
  !define MUI_BRANDINGTEXT "OpenARK"
  !define MUI_WELCOMEPAGE_TITLE "Welcome to the OpenARK Dependency Pack Installer"
  !define MUI_LICENSEPAGE_TEXT_TOP "Please review the note and license terms before installing"
  !define MUI_WELCOMEFINISHPAGE_BITMAP "welcome.bmp"
  Name "OpenARK Dependency Pack"
  CRCCheck On
 
  ;!include "${NSISDIR}\Contrib\Modern UI\System.nsh"
 
;---------------------------------
;General
 
  OutFile "openark-deps-vc14-win64.exe"
  ShowInstDetails "nevershow"
  ShowUninstDetails "nevershow"
  
  SetCompressor /SOLID lzma
  SetCompressorDictSize 64
  SetDatablockOptimize ON
 
  !define MUI_ICON "icon.ico"
  !define MUI_UNICON "icon.ico"
  ;!define MUI_SPECIALBITMAP "Bitmap.bmp"
 
;--------------------------------
;Folder selection page
 
  InstallDir "$PROGRAMFILES64\OpenARK-Deps"
 
 
;--------------------------------
;Modern UI Configuration
 
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "license.txt"
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !define MUI_ABORTWARNING
  !insertmacro MUI_PAGE_FINISH
  
  ;!insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH
 
    
;--------------------------------
;Language
 
  !insertmacro MUI_LANGUAGE "English"
 
;--------------------------------
;Data
 
  LicenseData "license.txt" 
 
;-------------------------------- 
;Installer Sections     
Section "install" ;Installation info
 
;Add files
  SetOutPath "$INSTDIR"
 
  File /R "..\arkdeps\*"
 
;write uninstall information to the registry
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\openark-deps" "DisplayName" "${MUI_NAME} (remove only)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\openark-deps" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "ARK_DEPS_DIR" "$INSTDIR"
  ;SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
  
  EnVar::SetHKCU
  EnVar::AddValue "PATH" "$INSTDIR\bin"
 
  WriteUninstaller "$INSTDIR\Uninstall.exe"
 
SectionEnd
 
;--------------------------------    
;Uninstaller Section  
Section "Uninstall"
 
;Delete Files 
  RMDir /r "$INSTDIR\*.*"    
 
;Remove the installation directory
  RMDir "$INSTDIR"
 
;Delete Start Menu Shortcuts
  ;Delete "$DESKTOP\${MUI_NAME}.lnk"
  ;Delete "$SMPROGRAMS\${MUI_NAME}\*.*"
  ;RmDir  "$SMPROGRAMS\${MUI_NAME}"
 
;Delete Uninstaller And Unistall Registry Entries
  DeleteRegKey HKLM "SOFTWARE\openark-deps"
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\openark-deps"  
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "ARK_DEPS_DIR"
  ;SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
 
  EnVar::SetHKCU
  EnVar::DeleteValue "PATH" "$INSTDIR\bin"
SectionEnd
 
 
;--------------------------------    
;MessageBox Section
 
 
;Function that calls a messagebox when installation finished correctly
Function .onInstSuccess
  MessageBox MB_OK "You have successfully installed the ${MUI_NAME}. Please proceed to configure OpenARK using cmake .. -G'Visual Studio 14 2015 Win64'"
FunctionEnd
 
 
Function un.onUninstSuccess
  MessageBox MB_OK "You have successfully uninstalled the ${MUI_NAME}."
FunctionEnd
 
;eof