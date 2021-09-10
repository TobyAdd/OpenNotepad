unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Menus, XPMan, StrUtils, ShellAPI, IniFiles;

type
  TMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    CreateBtn: TMenuItem;
    NewWindowBtn: TMenuItem;
    OpenBtn: TMenuItem;
    SaveBtn: TMenuItem;
    SaveAsBtn: TMenuItem;
    N7: TMenuItem;
    PageSettingsBtn: TMenuItem;
    PrintBtn: TMenuItem;
    N10: TMenuItem;
    ExitBtn: TMenuItem;
    N12: TMenuItem;
    UndoBtn: TMenuItem;
    N14: TMenuItem;
    CutBtn: TMenuItem;
    CopyBtn: TMenuItem;
    PasteBtn: TMenuItem;
    DelBtn: TMenuItem;
    N19: TMenuItem;
    FindBtn: TMenuItem;
    FindNextBtn: TMenuItem;
    FindBackBtn: TMenuItem;
    N23: TMenuItem;
    ReplaceBtn: TMenuItem;
    GoToBtn: TMenuItem;
    SelectAllBtn: TMenuItem;
    TimeDateBtn: TMenuItem;
    N28: TMenuItem;
    ScrollBarsBtn: TMenuItem;
    FontBtn: TMenuItem;
    N31: TMenuItem;
    ZoomBtn: TMenuItem;
    StatusBarBtn: TMenuItem;
    ZoomUpBtn: TMenuItem;
    ZoomDownBtn: TMenuItem;
    DefaultZoom: TMenuItem;
    N37: TMenuItem;
    HelpBtn: TMenuItem;
    AboutBtn: TMenuItem;
    N40: TMenuItem;
    StatusBar: TStatusBar;
    XPManifest1: TXPManifest;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Memo: TRichEdit;
    PrintDialog: TPrintDialog;
    PrinterSetupDialog: TPrinterSetupDialog;
    FindDialog: TFindDialog;
    ReplaceDialog: TReplaceDialog;
    FontDialog: TFontDialog;
    procedure FormCreate(Sender: TObject);
    procedure CreateBtnClick(Sender: TObject);
    procedure NewWindowBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure LoadTextFile(FileNamePath: string);
    procedure SaveBtnClick(Sender: TObject);
    procedure SaveAsBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure PageSettingsBtnClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure UndoBtnClick(Sender: TObject);
    procedure CutBtnClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure PasteBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure FindBtnClick(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure FindNextBtnClick(Sender: TObject);
    procedure FindBackBtnClick(Sender: TObject);
    procedure ReplaceBtnClick(Sender: TObject);
    procedure ReplaceDialogReplace(Sender: TObject);
    procedure SelectAllBtnClick(Sender: TObject);
    procedure TimeDateBtnClick(Sender: TObject);
    procedure ScrollBarsBtnClick(Sender: TObject);
    procedure FontBtnClick(Sender: TObject);
    procedure FontDialogApply(Sender: TObject; Wnd: HWND);
    procedure StatusBarBtnClick(Sender: TObject);
    procedure ZoomUpBtnClick(Sender: TObject);
    procedure ZoomDownBtnClick(Sender: TObject);
    procedure DefaultZoomClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure MemoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure MemoChange(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;
  CurrentFileName: string;
  CurZoom: integer = 100;
  LastText: string;
  AllowChanges: boolean;

implementation

{$R *.dfm}

procedure TMain.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Setup.ini');
  Width:=Ini.ReadInteger('Main', 'Width', Width);
  Height:=Ini.ReadInteger('Main', 'Height', Height);
  if Ini.ReadBool('Main', 'WordWrap', true) then
    ScrollBarsBtn.Click;
  if Ini.ReadBool('Main', 'StatusBar', true) = false then
    StatusBarBtn.Click;
  Ini.Free;
  Memo.Font.Size:=11;
  Memo.Font.Name:='Consolas';
  LoadTextFile(ParamStr(1));
end;

procedure TMain.CreateBtnClick(Sender: TObject);
begin
  Caption:='Безымянный - OpenNotepad';
  Application.Title:=Caption;
  CurrentFileName:='';
  Memo.Clear;
end;

procedure TMain.NewWindowBtnClick(Sender: TObject);
begin
  WinExec(PChar(ParamStr(0)), SW_SHOWNORMAL);
end;

procedure TMain.OpenBtnClick(Sender: TObject);
begin
  if not OpenDialog.Execute then Exit;
  LoadTextFile(OpenDialog.FileName);
end;

function IsUtf8Encoded(const Str: AnsiString): boolean;
begin
  Result:=(Str <> '') and (UTF8Decode(Str) <> '')
end;

procedure TMain.LoadTextFile(FileNamePath: string);
begin
  AllowChanges:=false;
  if FileExists(FileNamePath) then begin
    Caption:=ExtractFileName(FileNamePath) + ' - OpenNotepad';
    Application.Title:=Caption;
    Memo.Lines.LoadFromFile(FileNamePath);
    CurrentFileName:=FileNamePath;
    if IsUtf8Encoded(Memo.Text) then begin
      Memo.Text:=UTF8ToAnsi(Memo.Text);
      StatusBar.Panels[4].Text:='UTF-8';
    end else
      StatusBar.Panels[4].Text:='ANSI';
    LastText:=Memo.Text;
  end else begin
    Caption:='Безымянный - OpenNotepad';
    Application.Title:=Caption;
    CurrentFileName:='';
    Memo.Clear;
    StatusBar.Panels[4].Text:='UTF-8';
    CurrentFileName:='';
    LastText:='';
  end;
  StatusBar.Panels[1].Text:='Стр 1, стлб 0';
  AllowChanges:=true;
end;

procedure TMain.SaveBtnClick(Sender: TObject);
var
  TextFile: TStringList;
begin
  TextFile:=TStringList.Create;
  if (CurrentFileName <> '') and FileExists(CurrentFileName) then begin
    if StatusBar.Panels[4].Text = 'UTF-8' then
      TextFile.Text:=AnsiToUTF8(Memo.Text)
    else
      TextFile.Text:=Memo.Text;
    TextFile.SaveToFile(CurrentFileName);
  end else
    SaveAsBtn.Click;
  TextFile.Free;

  LastText:=Memo.Text;

  if Main.Caption[1] = '*' then begin
    Main.Caption:=Copy(Main.Caption, 2, Length(Main.Caption));
    Application.Title:=Caption;
  end;
end;

procedure TMain.SaveAsBtnClick(Sender: TObject);
var
  TextFile: TStringList;
begin
  if not SaveDialog.Execute then SaveBtn.Click;
  TextFile:=TStringList.Create;
  if StatusBar.Panels[4].Text = 'UTF-8' then
    TextFile.Text:=AnsiToUTF8(Memo.Text)
  else
    TextFile.Text:=Memo.Text;
  TextFile.SaveToFile(SaveDialog.FileName);
  CurrentFileName:=SaveDialog.FileName;
  TextFile.Free;
  LastText:=Memo.Text;

  Main.Caption:=ExtractFileName(CurrentFileName) + ' - OpenNotepad';
  Application.Title:=Caption;
end;

procedure TMain.PrintBtnClick(Sender: TObject);
begin
  Memo.Print(Memo.Text);
end;

procedure TMain.PageSettingsBtnClick(Sender: TObject);
begin
  PrinterSetupDialog.Execute;
end;

procedure TMain.ExitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TMain.UndoBtnClick(Sender: TObject);
begin
  Memo.Undo;
end;

procedure TMain.CutBtnClick(Sender: TObject);
begin
  Memo.CutToClipboard;
end;

procedure TMain.CopyBtnClick(Sender: TObject);
begin
  Memo.CopyToClipboard;
end;

procedure TMain.PasteBtnClick(Sender: TObject);
begin
  Memo.PasteFromClipboard;
end;

procedure TMain.DelBtnClick(Sender: TObject);
begin
  Memo.CutToClipboard;
end;

procedure TMain.FindBtnClick(Sender: TObject);
begin
  FindDialog.Execute;
end;

procedure TMain.FindDialogFind(Sender: TObject);
var
   Found, StartPos: Integer;
begin
   if Memo.SelLength <> 0 then // для повторного поиска
      StartPos := Memo.SelStart + Memo.SelLength
   else
      StartPos := 0;
 
   // Для PosEx надо подключить StrUtils
   Found := PosEx(FindDialog.FindText, Memo.Text, StartPos + 1);
   if Found <> 0 then
   begin
      Memo.HideSelection := False;
      Memo.SelStart := Found - 1;
      Memo.SelLength := Length(FindDialog.FindText);
   end else
    Application.MessageBox(PChar('Не удаётся найти "' + FindDialog.FindText + '"'), 'OpenNotepad', MB_ICONINFORMATION)
end;

procedure TMain.FindNextBtnClick(Sender: TObject);
begin
  if FindDialog.FindText <> '' then
    FindDialogFind(Sender);
end;

procedure TMain.FindBackBtnClick(Sender: TObject);
begin
  if FindDialog.FindText <> '' then
    FindDialogFind(Sender);
end;

procedure TMain.ReplaceBtnClick(Sender: TObject);
begin
  ReplaceDialog.Execute;
end;

procedure TMain.ReplaceDialogReplace(Sender: TObject);
begin
  Memo.Text:=StringReplace(Memo.Text, ReplaceDialog.FindText, ReplaceDialog.ReplaceText, [rfReplaceAll]);
end;

procedure TMain.SelectAllBtnClick(Sender: TObject);
begin
  Memo.SelectAll;
end;

procedure TMain.TimeDateBtnClick(Sender: TObject);
begin
  Memo.Text:=Memo.Text + TimeToStr(Now) + ' ' + DateToStr(Now);
end;

procedure TMain.ScrollBarsBtnClick(Sender: TObject);
begin
  if ScrollBarsBtn.Checked then begin
    ScrollBarsBtn.Checked:=false;
    Memo.WordWrap:=false;
  end else begin
    ScrollBarsBtn.Checked:=true;
    Memo.WordWrap:=true;
  end;
end;

procedure TMain.FontBtnClick(Sender: TObject);
begin
FontDialog.Execute
end;

procedure TMain.FontDialogApply(Sender: TObject; Wnd: HWND);
begin
  Memo.Font.Name:=FontDialog.Font.Name;
  Memo.Font.Size:=FontDialog.Font.Size;
end;

procedure TMain.StatusBarBtnClick(Sender: TObject);
begin
  StatusBarBtn.Checked:=not StatusBarBtn.Checked;
  StatusBar.Visible:=StatusBarBtn.Checked;
end;

procedure TMain.ZoomUpBtnClick(Sender: TObject);
begin
  CurZoom:=CurZoom + 10;
  if CurZoom > 300 then CurZoom:=300;
  Memo.Font.Size:=(CurZoom div 10) + 1;
  StatusBar.Panels[2].Text:=IntToStr(CurZoom) + '%';
end;

procedure TMain.ZoomDownBtnClick(Sender: TObject);
begin
  CurZoom:=CurZoom - 10;
  if CurZoom < 100 then CurZoom:=100;
  Memo.Font.Size:=(CurZoom div 10) + 1;
  StatusBar.Panels[2].Text:=IntToStr(CurZoom) + '%';
end;

procedure TMain.DefaultZoomClick(Sender: TObject);
begin
  CurZoom:=100;
  Memo.Font.Size:=11;
  StatusBar.Panels[2].Text:='100%';
end;

procedure TMain.HelpBtnClick(Sender: TObject);
begin
  ShellExecute(handle,'open', 'https://go.microsoft.com/fwlink/?LinkId=834783', nil, nil, SW_SHOWNORMAL);
end;

procedure TMain.AboutBtnClick(Sender: TObject);
begin
  ShellAbout(Main.Handle, 'OpenNotepad', '', Application.Icon.Handle);
end;

procedure TMain.MemoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  LineNum, ColumnNum, CT: integer;
begin
  LineNum:=SendMessage(Memo.Handle, EM_LINEFROMCHAR, Memo.SelStart, 0);
  ColumnNum:=SendMessage(Memo.Handle, EM_LINEINDEX, -1, 0);
  StatusBar.Panels[1].Text:='Стр ' + IntToStr(LineNum + 1) + ', стлб ' + IntToStr(ColumnNum);

  ColumnNum := LongRec(SendMessage(Memo.Handle, EM_GETSEL, 0, 0)).Hi; // возвращает номер символа конца выделения, младшее слово - начало.
  ColumnNum := ColumnNum - SendMessage(Memo.Handle, EM_LINEINDEX, -1, 0); //Функция возвращает номер первого символа в строке на которой находится курсор

  StatusBar.Panels[1].Text:='Стр ' + IntToStr(LineNum + 1) + ', стлб ' + IntToStr(ColumnNum);
end;




procedure TMain.FormResize(Sender: TObject);
begin
  StatusBar.Panels[0].Width:=Width - 466;
end;

procedure TMain.MemoChange(Sender: TObject);
var
  AppTitle: string;
begin
  if (AllowChanges) and (LastText <> Memo.Text) and (Main.Caption[1] <> '*') then begin
    Main.Caption:='*' + Main.Caption;
    Application.Title:=Caption;
    LastText:=Memo.Text;
  end;
end;

procedure TMain.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LineNum, ColumnNum, CT: integer;
begin
  LineNum:=SendMessage(Memo.Handle, EM_LINEFROMCHAR, Memo.SelStart, 0);
  ColumnNum:=SendMessage(Memo.Handle, EM_LINEINDEX, -1, 0);
  StatusBar.Panels[1].Text:='Стр ' + IntToStr(LineNum + 1) + ', стлб ' + IntToStr(ColumnNum);

  ColumnNum := LongRec(SendMessage(Memo.Handle, EM_GETSEL, 0, 0)).Hi; // возвращает номер символа конца выделения, младшее слово - начало.
  ColumnNum := ColumnNum - SendMessage(Memo.Handle, EM_LINEINDEX, -1, 0); //Функция возвращает номер первого символа в строке на которой находится курсор

  StatusBar.Panels[1].Text:='Стр ' + IntToStr(LineNum + 1) + ', стлб ' + IntToStr(ColumnNum);
end;

procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Ini: TIniFile;
  buttonSelected : Integer;
  TextFile: TStringList;
begin

  buttonSelected := MessageDlg('Сохранить текстовый документ?',mtInformation, mbYesNoCancel, 0);

  if buttonSelected = mrYes then
  begin
   CanClose:=True;
   TextFile:=TStringList.Create;
  if (CurrentFileName <> '') and FileExists(CurrentFileName) then begin
    if StatusBar.Panels[4].Text = 'UTF-8' then
      TextFile.Text:=AnsiToUTF8(Memo.Text)
    else
      TextFile.Text:=Memo.Text;
    TextFile.SaveToFile(CurrentFileName);
  end else
    SaveAsBtn.Click;
  TextFile.Free;

  LastText:=Memo.Text;

  if Main.Caption[1] = '*' then begin
    Main.Caption:=Copy(Main.Caption, 2, Length(Main.Caption));
    Application.Title:=Caption;
  end;
  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Setup.ini');
  Ini.WriteInteger('Main', 'Width', Width);
  Ini.WriteInteger('Main', 'Height', Height);
  Ini.WriteBool('Main', 'WordWrap', ScrollBarsBtn.Checked);
  Ini.WriteBool('Main', 'StatusBar', StatusBarBtn.Checked);
  Ini.Free;
  end;
  if buttonSelected = mrNo then
  begin
  CanClose:=True;
  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Setup.ini');
  Ini.WriteInteger('Main', 'Width', Width);
  Ini.WriteInteger('Main', 'Height', Height);
  Ini.WriteBool('Main', 'WordWrap', ScrollBarsBtn.Checked);
  Ini.WriteBool('Main', 'StatusBar', StatusBarBtn.Checked);
  Ini.Free;
  end;

  if buttonSelected = mrCancel then
  begin
  CanClose:=False;
  end;

end;

end.
