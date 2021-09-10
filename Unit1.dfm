object Main: TMain
  Left = 207
  Top = 128
  Width = 686
  Height = 431
  Caption = 'OpenNotepad'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 354
    Width = 670
    Height = 19
    Panels = <
      item
        Width = 260
      end
      item
        Width = 130
      end
      item
        Text = '100%'
        Width = 50
      end
      item
        Text = 'Windows (CRLF)'
        Width = 130
      end
      item
        Width = 50
      end>
  end
  object Memo: TRichEdit
    Left = 0
    Top = 0
    Width = 670
    Height = 354
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
    OnChange = MemoChange
    OnKeyDown = MemoKeyDown
    OnMouseDown = MemoMouseDown
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      ShortCut = 16464
      object CreateBtn: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100
        ShortCut = 16462
        OnClick = CreateBtnClick
      end
      object NewWindowBtn: TMenuItem
        Caption = #1053#1086#1074#1086#1077' '#1086#1082#1085#1086
        ShortCut = 24654
        OnClick = NewWindowBtnClick
      end
      object OpenBtn: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        ShortCut = 16463
        OnClick = OpenBtnClick
      end
      object SaveBtn: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = SaveBtnClick
      end
      object SaveAsBtn: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...             '
        ShortCut = 24659
        OnClick = SaveAsBtnClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object PageSettingsBtn: TMenuItem
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1090#1088#1072#1085#1080#1094#1099
        OnClick = PageSettingsBtnClick
      end
      object PrintBtn: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100
        ShortCut = 16464
        OnClick = PrintBtnClick
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object ExitBtn: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = ExitBtnClick
      end
    end
    object N12: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
      object UndoBtn: TMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100'                         '
        ShortCut = 16474
        OnClick = UndoBtnClick
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object CutBtn: TMenuItem
        Caption = #1042#1099#1088#1077#1079#1072#1090#1100
        ShortCut = 16472
        OnClick = CutBtnClick
      end
      object CopyBtn: TMenuItem
        Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
        ShortCut = 16451
        OnClick = CopyBtnClick
      end
      object PasteBtn: TMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100
        ShortCut = 16451
        OnClick = PasteBtnClick
      end
      object DelBtn: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        ShortCut = 46
        OnClick = DelBtnClick
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object FindBtn: TMenuItem
        Caption = #1053#1072#1081#1090#1080
        ShortCut = 16454
        OnClick = FindBtnClick
      end
      object FindNextBtn: TMenuItem
        Caption = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077
        ShortCut = 16498
        Visible = False
        OnClick = FindNextBtnClick
      end
      object FindBackBtn: TMenuItem
        Caption = #1053#1072#1081#1090#1080' '#1088#1072#1085#1077#1077
        ShortCut = 114
        Visible = False
        OnClick = FindBackBtnClick
      end
      object ReplaceBtn: TMenuItem
        Caption = #1047#1072#1084#1077#1085#1080#1090#1100'...'
        ShortCut = 16456
        OnClick = ReplaceBtnClick
      end
      object GoToBtn: TMenuItem
        Caption = #1055#1077#1088#1077#1081#1090#1080'...'
        ShortCut = 16455
        Visible = False
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object SelectAllBtn: TMenuItem
        Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
        ShortCut = 16449
        OnClick = SelectAllBtnClick
      end
      object TimeDateBtn: TMenuItem
        Caption = #1042#1088#1077#1084#1103' '#1080' '#1076#1072#1090#1072
        ShortCut = 116
        OnClick = TimeDateBtnClick
      end
    end
    object N28: TMenuItem
      Caption = #1060#1086#1088#1084#1072#1090
      object ScrollBarsBtn: TMenuItem
        Caption = #1055#1077#1088#1077#1085#1086#1089' '#1087#1086' '#1089#1083#1086#1074#1072#1084
        OnClick = ScrollBarsBtnClick
      end
      object FontBtn: TMenuItem
        Caption = #1064#1088#1080#1092#1090'...'
        OnClick = FontBtnClick
      end
    end
    object N31: TMenuItem
      Caption = #1042#1080#1076
      object ZoomBtn: TMenuItem
        Caption = #1052#1072#1089#1096#1090#1072#1073
        object ZoomUpBtn: TMenuItem
          Caption = #1059#1074#1077#1083#1080#1095#1080#1090#1100'                            '
          OnClick = ZoomUpBtnClick
        end
        object ZoomDownBtn: TMenuItem
          Caption = #1059#1084#1077#1085#1100#1096#1080#1090#1100
          OnClick = ZoomDownBtnClick
        end
        object DefaultZoom: TMenuItem
          Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1084#1072#1089#1096#1090#1072#1073' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
          OnClick = DefaultZoomClick
        end
      end
      object StatusBarBtn: TMenuItem
        Caption = #1057#1090#1088#1086#1082#1072' '#1089#1086#1089#1090#1086#1103#1085#1080#1103
        Checked = True
        OnClick = StatusBarBtnClick
      end
    end
    object N37: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object HelpBtn: TMenuItem
        Caption = #1055#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1089#1087#1088#1072#1074#1082#1091
        OnClick = HelpBtnClick
      end
      object N40: TMenuItem
        Caption = '-'
      end
      object AboutBtn: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
        OnClick = AboutBtnClick
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 40
    Top = 8
  end
  object OpenDialog: TOpenDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099'|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Left = 72
    Top = 8
  end
  object SaveDialog: TSaveDialog
    DefaultExt = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099'|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099'|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Left = 104
    Top = 8
  end
  object PrintDialog: TPrintDialog
    Left = 168
    Top = 8
  end
  object PrinterSetupDialog: TPrinterSetupDialog
    Left = 136
    Top = 8
  end
  object FindDialog: TFindDialog
    OnFind = FindDialogFind
    Left = 200
    Top = 8
  end
  object ReplaceDialog: TReplaceDialog
    OnReplace = ReplaceDialogReplace
    Left = 232
    Top = 8
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    OnApply = FontDialogApply
    Left = 264
    Top = 8
  end
end
