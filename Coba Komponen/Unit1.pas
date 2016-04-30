unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZAbstractConnection, ZConnection, ExtCtrls;

type
  TForm1 = class(TForm)
    con1: TZConnection;
    ZQuery1: TZQuery;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    cbb1: TComboBox;
    edttotal: TEdit;
    btn1: TBitBtn;
    Button2: TButton;
    Button1: TButton;
    StringGrid1: TStringGrid;
    edt2: TEdit;
    edt1: TEdit;
    lbl: TLabel;
    edtbayar: TEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtkembali: TEdit;
    pnl5: TPanel;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    btn5: TBitBtn;
    btn6: TBitBtn;
    btn7: TBitBtn;
    btn8: TBitBtn;
    btn9: TBitBtn;
    btn10: TBitBtn;
    btn11: TBitBtn;
    btn12: TBitBtn;
    btn13: TBitBtn;
    lbl1: TLabel;
    edt3: TEdit;
    btn14: TBitBtn;
    btn15: TBitBtn;
    btn16: TBitBtn;
    btn18: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure rupiah (edit : TEdit);
    procedure buattabel;
    function hapusribuan(edit: TEdit): string;
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cbb1Change(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure edt2KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure edtbayarKeyPress(Sender: TObject; var Key: Char);
    procedure edtbayarChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn14Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  h,i : Integer;
begin
 if StringGrid1.Cells[3, StringGrid1.RowCount-1] = StringGrid1.Cells[3,StringGrid1.RowCount-1] then
  begin
  h := 0;
  for i:=1 to StringGrid1.RowCount-1 do
        begin
          h:= StrToInt(StringGrid1.Cells[5,i])+ h;
           edttotal.Text := IntToStr(h);
         end;
  end;
 end;
procedure TForm1.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  if (ACol = 3) and (ARow <> 0) then
  begin
    R := StringGrid1.CellRect(ACol, ARow);
    R.Left := R.Left + StringGrid1.Left;
    R.Right := R.Right + StringGrid1.Left;
    R.Top := R.Top + StringGrid1.Top;
    R.Bottom := R.Bottom + StringGrid1.Top;
    with edt2 do
    begin
      Left := R.Left + 1;
      Top := R.Top + 1;
      Width := (R.Right + 1) - R.Left;
      Height := (R.Bottom + 1) - R.Top;
      Visible := True;
      SetFocus;
    end;
  end;
  CanSelect := True;

end;



procedure TForm1.StringGrid1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
  var  a,b :Integer;
begin
StringGrid1.MouseToCell(X,Y,a,b);
end;

procedure TForm1.cbb1Change(Sender: TObject);
var
  t,y : Integer;
begin
if zquery1.Locate('kd_brg',cbb1.text,[]) then
begin
  StringGrid1.RowCount := StringGrid1.RowCount+1 ;
  StringGrid1.Cells[0, StringGrid1.RowCount-1] := IntToStr(StringGrid1.RowCount-1);
  StringGrid1.Cells[1, StringGrid1.RowCount-1] := ZQuery1.fieldbyName('kd_brg').AsString;
  StringGrid1.Cells[2, StringGrid1.RowCount-1] := ZQuery1.fieldbyName('nm_brg').AsString;
  StringGrid1.Cells[3, StringGrid1.RowCount-1] :='1';
  StringGrid1.Cells[4, StringGrid1.RowCount-1] := ZQuery1.fieldbyName('jual').AsString;

           t:= strtoint (stringGrid1.cells[4,StringGrid1.RowCount-1]);
           y:= strtoint (stringGrid1.cells[3,StringGrid1.RowCount-1])*t;
           StringGrid1.Cells[5,StringGrid1.RowCount-1] := Inttostr(y);
           Button1.Click;
            cbb1.Text:='';
  end;

 end;
procedure TForm1.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
Button1.Click;
end;

procedure TForm1.edt2KeyPress(Sender: TObject; var Key: Char);
var
 intRow,t,y: Integer;
begin
if key=#13 then
Begin
  inherited;
   {Ambil seleksi Editbox dan tempatkan di Grid}
  with edt2 do
  begin
    intRow := StringGrid1.Row;
    if (StringGrid1.Col = 2) then
      StringGrid1.Cells[3, intRow] := edt2.Text
    else
      StringGrid1.Cells[StringGrid1.Col, intRow] := edt2.Text;
    Visible := False;
  end;
           StringGrid1.SetFocus;
           t:= strtoint (stringGrid1.cells[4,intRow]);
           y:= strtoint (stringGrid1.cells[3,intRow])*t;
           StringGrid1.Cells[5,intRow] := Inttostr(y);

    Button1.Click;
    cbb1.SetFocus;
    edt2.Text:= '1';
    rupiah(edttotal);
end;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
//cbb1.SetFocus;
buattabel;
end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
begin
cbb1.SetFocus;
end;

procedure TForm1.edt1Change(Sender: TObject);
var
  t,y : Integer;
begin
if zquery1.Locate('kd_brg',edt1.text,[]) then
begin
  StringGrid1.RowCount := StringGrid1.RowCount+1 ;
  StringGrid1.Cells[0, StringGrid1.RowCount-1] := IntToStr(StringGrid1.RowCount-1);
  StringGrid1.Cells[1, StringGrid1.RowCount-1] := ZQuery1.fieldbyName('kd_brg').AsString;
  StringGrid1.Cells[2, StringGrid1.RowCount-1] := ZQuery1.fieldbyName('nm_brg').AsString;
  StringGrid1.Cells[3, StringGrid1.RowCount-1] :='1';
  StringGrid1.Cells[4, StringGrid1.RowCount-1] := ZQuery1.fieldbyName('jual').AsString;

           t:= strtoint (stringGrid1.cells[4,StringGrid1.RowCount-1]);
           y:= strtoint (stringGrid1.cells[3,StringGrid1.RowCount-1])*t;
           StringGrid1.Cells[5,StringGrid1.RowCount-1] := Inttostr(y);
           Button1.Click;
            edt1.Text:='';
            rupiah(edttotal);
  end;

end;

procedure TForm1.rupiah(edit: TEdit);
var  
 sRupiah: string; 
  iRupiah: Currency;
 begin  
		 // ribuan --> currency ( menyesuaikan setting windows ) 
        sRupiah := edit.Text;
       sRupiah := StringReplace(sRupiah, ',', '', [rfReplaceAll, rfIgnoreCase]);
           // hilangkan char koma , pemisah //ribuan selain IDR
       sRupiah := StringReplace(sRupiah, '.', '', [rfReplaceAll, rfIgnoreCase]);
            // remove char titik . pemisah //ribuan IDR
       iRupiah := StrToCurrDef(sRupiah, 0);
          // convert srupiah ke currency   // currency --> format ribuan
      edit.Text :='Rp. ' + FormatCurr('#,###', iRupiah);
      edit.SelStart := length(edit.Text);

 end;

function TForm1.hapusribuan(edit: TEdit): string;
var
hasil: string;
 begin
 hasil := edit.Text;
 hasil := StringReplace(hasil, ',', '', [rfReplaceAll, rfIgnoreCase]);  
 hasil := StringReplace(hasil, '.', '', [rfReplaceAll, rfIgnoreCase]);  
 hapusribuan := hasil;
 end;

procedure TForm1.edtbayarKeyPress(Sender: TObject; var Key: Char);
var
  hasil: Integer;
begin
  if Key = #13 then
  begin
    rupiah(edttotal);
    hasil := StrToInt(hapusribuan(edtbayar)) - StrToInt(hapusribuan(edttotal));
    edtkembali.Text := IntToStr(hasil);
    rupiah(edtkembali);

  end;
end;

procedure TForm1.edtbayarChange(Sender: TObject);
begin
rupiah(edtbayar);
rupiah(edtkembali);

end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_F1 then
begin
btn14.Click;
end else
if Key = VK_F2 then
begin
  pnl5.Visible:= True;
end;
end;
procedure TForm1.buattabel;
begin
 With StringGrid1 Do Begin
            RowCount:=1;
            ColCount:=6;
            Cells[0,0]:='NO';
            Cells[1,0]:='KODE';
            Cells[2,0]:='NAMA BARANG';
            Cells[3,0]:='Qty';
            Cells[4,0]:='HARGA';
            Cells[5,0]:='JUMLAH';

            ColWidths[0]:=30;
            ColWidths[1]:=100;
            ColWidths[2]:=200;
            ColWidths[3]:=50;
            ColWidths[4]:=100;
            ColWidths[5]:=150;
          End;
end;

procedure TForm1.btn14Click(Sender: TObject);
begin
buattabel;
end;

end.
