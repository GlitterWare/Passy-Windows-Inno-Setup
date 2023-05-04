; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName      "Passy"
#define MyAppVersion   "1.4.1"
#define MyAppPublisher "GlitterWare"
#define MyAppURL       "https://glitterware.github.io/Passy"
#define MyAppExeName   "passy.exe"
#define CStartYear     "2017" 
#define CurrentYear    GetDateTimeString('yyyy','','')

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)

AppId={{AE2D44A7-B09E-4C99-8F39-3F4DFA3F15DB}

AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}

VersionInfoDescription={#MyAppName} installer
VersionInfoVersion={#MyAppVersion}
VersionInfoProductName={#MyAppName}
VersionInfoProductVersion={#MyAppVersion}
AppCopyright={#MyAppPublisher} {#CStartYear}-{#CurrentYear}

UninstallDisplayIcon={app}\{#MyAppExeName}
UninstallDisplayName={#MyAppname}
AppPublisher={#MyAppPublisher}

AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}

WizardStyle=modern
UsePreviousLanguage=no

DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=commandline
OutputBaseFilename=passy
Compression=lzma
SolidCompression=yes
SetupIconFile="icon48.ico"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Release\url_launcher_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[UninstallDelete]
Type: files; Name: "{app}\innosetup.ini"

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[INI]
Filename: "{app}\innosetup.ini"; Section: "Info"; Key: "setupVersion"; String: "1.0.0"

[Code]
procedure ListFolders(const Directory: string; Folders: TStrings);
var
  FindRec: TFindRec;
begin
  Folders.Clear;
  if FindFirst(ExpandConstant(Directory + '\*'), FindRec) then
  try
    repeat
      if FILE_ATTRIBUTE_DIRECTORY <> 0 then
        Folders.Add(FindRec.Name);
    until
      not FindNext(FindRec);
  finally
    FindClose(FindRec);
  end;
end;
procedure CurStepChanged(CurStep: TSetupStep);
var
_valStr : string;
begin  
  if CurStep = ssPostInstall then begin    
    _valStr := ExpandConstant('{param:UninstallerUserDataRemove|false}');
    if _valStr = 'true' then
      SetIniBool('Uninstaller', 'userDataRemove', True, ExpandConstant('{app}\innosetup.ini'))
    else
      SetIniBool('Uninstaller', 'userDataRemove', False, ExpandConstant('{app}\innosetup.ini'));
  end;
end;
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
_userFolders : TStrings;
var
_curUser : Integer;
begin
  if CurUninstallStep = usUninstall then begin
    _userFolders := TStringList.Create;
    if FileExists(ExpandConstant('{app}\innosetup.ini')) then begin        
      if GetIniBool('Uninstaller', 'userDataRemove', False, ExpandConstant('{app}\innosetup.ini')) then begin
        ListFolders('C:\Users', _userFolders);
        repeat begin
          DelTree(ExpandConstant('C:\Users\' + _userFolders[_curUser] + '\Documents\Passy'), True, True, True);
          _curUser := _curUser + 1;
        end;
        until _curUser = _userFolders.Count;
        DelTree(ExpandConstant('{userdocs}\Passy'), True, True, True);          
      end;
    end;
  end;
end; 
