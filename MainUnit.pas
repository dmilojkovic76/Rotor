unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, jpeg, ExtCtrls, StdCtrls, Buttons, DBCtrls, DB,
  Grids, DBGrids, Mask, ADODB;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Izadji1: TMenuItem;
    ImageList1: TImageList;
    Help1: TMenuItem;
    About1: TMenuItem;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Panel1: TPanel;
    Image1: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBMemo1: TDBMemo;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    procedure Izadji1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Filterisanje(Sender: TObject);
    procedure ADODataSet1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private

  public

  end;

var
  MainForm: TMainForm;
  BrojZapisa: Integer;
  Klik : Boolean;
  NadjenTip: Boolean;
  NadjenaMarka: Boolean;

implementation

uses
  AboutUnit, DataUnit;
{$R *.dfm}

procedure TMainForm.Filterisanje(Sender: TObject);
begin
ADODataSet1.Filtered:=FALSE;
if (Edit2.Text <> '') or (Edit3.Text <> '') then
  begin
    if ADODataSet1.Locate('Tip', Edit3.Text, [loPartialKey])=TRUE then
        NadjenTip := TRUE
    else
      NadjenTip:=FALSE;

    if ADODataSet1.Locate('Marka', Edit2.Text, [loPartialKey])=TRUE then
        NadjenaMarka := TRUE
    else
      NadjenaMarka:=FALSE;

    if NadjenTip = TRUE and NadjenaMarka = TRUE then
      ADODataSet1.Filtered:=TRUE;

  end

else ADODataSet1.Filtered := FALSE;
end;

procedure TMainForm.Izadji1Click(Sender: TObject);
begin
Close;
end;

procedure TMainForm.About1Click(Sender: TObject);
begin
AboutBox.ShowModal;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin

with DataModule1 do begin

if not ADODataSet1.Active then ADODataSet1.Active:=TRUE;
ADODataSet1.Open;

if not AdoDataSet1.Active then
case  messageDlg('Doslo je do greske prilikom povezivanja sa bazom podataka!'+#10+#13+
       'Program ce se sada iskluciti, ako ponovo vidite ovu poruku'+#10+#13+
       'restartujte racunar i pokusajte ponovo!', mtError, mbOkCancel, 0) of
       mrOK:       Close;
end;
end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
DBMemo1.Left := Image1.Width+6;
DBMemo1.Width := Panel2.Width-Image1.Width-3;
Panel3.Height := MainForm.ClientHeight-Panel2.Height-2;
DBGrid1.Height := Panel3.Height - 66;
end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
begin
klik := not klik;

If Klik = True then
  begin
    DBNavigator1.Visible := TRUE;
    BitBtn1.Caption := 'ZAVRSI';
    BitBtn2.Enabled := FALSE;

    with DBEdit1 do begin
      Edit2.Visible := FALSE;
      Left:=Edit2.Left;
      Top := Edit2.Top;
      Width := Edit2.Width;
      Height := Edit2.Height;
      TabOrder := Edit2.TabOrder;
      Hint := Edit2.Hint;
      Color := Edit2.Color;
      Visible := TRUE;
      ReadOnly := False;
    end;

    with DBEdit2 do begin
      Edit3.Visible := FALSE;
      Left:=Edit3.Left;
      Top := Edit3.Top;
      Width := Edit3.Width;
      Height := Edit3.Height;
      TabOrder := Edit3.TabOrder;
      Hint := Edit3.Hint;
      Color := Edit3.Color;
      Visible := TRUE;
      ReadOnly := False;
    end;
    DBEdit3.ReadOnly := FALSE;
    DBEdit4.ReadOnly := FALSE;
    DBEdit5.ReadOnly := FALSE;
    DBEdit6.ReadOnly := FALSE;
    DBEdit7.ReadOnly := FALSE;
    DBEdit3.TabStop := TRUE;
    DBEdit4.TabStop := TRUE;
    DBEdit5.TabStop := TRUE;
    DBEdit6.TabStop := TRUE;
    DBEdit7.TabStop := TRUE;
    DBEdit9.Visible := TRUE;
    DBEdit10.Visible := TRUE;
    DBEdit11.Visible := TRUE;
  end

else
  begin
    DBNavigator1.Visible:= FALSE;
    BitBtn1.Caption := 'NOVI / IZMENA';
    DBEdit1.Visible := FALSE;
    DBEdit2.Visible := FALSE;
    DBEdit3.ReadOnly := TRUE;
    DBEdit4.ReadOnly := TRUE;
    DBEdit5.ReadOnly := TRUE;
    DBEdit6.ReadOnly := TRUE;
    DBEdit7.ReadOnly := TRUE;
    DBEdit3.TabStop := FALSE;
    DBEdit4.TabStop := FALSE;
    DBEdit5.TabStop := FALSE;
    DBEdit6.TabStop := FALSE;
    DBEdit7.TabStop := FALSE;
    DBEdit9.Visible := FALSE;
    DBEdit10.Visible := FALSE;
    DBEdit11.Visible := FALSE;
    Edit2.Visible := TRUE;
    Edit3.Visible := TRUE;
    BitBtn2.Enabled := TRUE;
  end;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
StaticText5.Caption:='Debljina zice '+#216+'(mm):';
StaticText7.Caption:='Debljina zice '+#216+'(mm):';
Klik := FALSE;
NadjenTip:=FALSE;
NadjenaMarka:=FALSE;
DBEdit9.Left := DBText3.Left;
DBEdit9.Top := DBText3.Top;
DBEdit10.Left := DBText2.Left;
DBEdit10.Top := DBText2.Top;
DBEdit11.Left := DBText1.Left;
DBEdit11.Top := DBText1.Top;
end;

procedure TMainForm.ADODataSet1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if NadjenTip = TRUE then
    Accept := DataSet['Tip'] = Edit3.Text;

if NadjenaMarka = TRUE then
    Accept := DataSet['Marka'] = Edit2.Text;
end;

end.
