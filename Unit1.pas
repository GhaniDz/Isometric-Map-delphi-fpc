// -------------------------------------------------
//   Isometric map demo / staggered and diamond
//--------------------------------------------------

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,Dialogs, jpeg, ExtCtrls, StdCtrls;

type

  TMapType = (DIAMOND, STAGGERED);

  TForm1 = class(TForm)
    image1: TImage;
    btnDiamond: TButton;
    btnStaggered: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnStaggeredClick(Sender: TObject);
    procedure btnDiamondClick(Sender: TObject);
  private
    Tile: TBitmap;
    offsetX, offsetY: integer;   // X Y offsets to center map on screen
  public
    procedure RenderMap(xTiles, yTiles : integer; Tile: TBitmap; MapType: TMapType);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.RenderMap(xTiles, yTiles : integer; Tile: TBitmap; MapType: TMapType);
var
  x, y, i, j : integer;
begin

  offsetY := (ClientHeight - (yTiles * Tile.Height)) div 2;  // Y Offset

  if MapType = STAGGERED then
  begin
  offsetX := (ClientWidth -  ((xTiles + 1) div 2 * Tile.Width)) div 2;  // X Offset
     for i := 0 to xTiles - 1  do
       for j := 0 to yTiles - 1  do
       begin
         X := Tile.Width div 2  * i + offsetX;
         if (i mod 2) = 0 then
            Y := Tile.Height * j + offsetY
         else
            Y := Tile.Height * j + Tile.Height div 2 + offsetY;
         // Render tile
         Canvas.Draw(X, Y, Tile);
         // Render tile's x,y coordinates on top of tile
         Canvas.TextOut(x+20, y+10, IntToStr(i)+','+IntToStr(j));
         sleep(50);
       end;
  end;

  if MapType = DIAMOND then
  begin
     offsetX := ClientWidth div 2 - (Tile.Width div 2);   // X Offset
     for i := 0 to xTiles - 1  do
       for j := 0 to yTiles - 1  do
       begin
          X := (i - j) * (Tile.Width div 2) + offsetX;
          Y := (i + j) * (Tile.Height div 2) + offsetY;
          // Render tile
          Canvas.Draw(x , y, Tile);
          // Render tile's x,y coordinates on top of tile
          Canvas.TextOut(x + 20, y + 10, IntToStr(i)+','+IntToStr(j));
          sleep(50);
       end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Canvas.Font.Style := [fsBold];
  Canvas.Font.Color := ClYellow;
  Canvas.Brush.Style := bsClear;

  Tile := image1.Picture.Bitmap;
end;

procedure TForm1.btnStaggeredClick(Sender: TObject);
begin
 // Clear form canvas
 PatBlt(Canvas.Handle, 0, 0, ClientWidth, ClientHeight,BLACKNESS);
 // Draw a 14x8 tiles staggered map
 RenderMap(14, 8, Tile, STAGGERED);
end;

procedure TForm1.btnDiamondClick(Sender: TObject);
begin
 // Clear form canvas
 PatBlt(Canvas.Handle, 0, 0, ClientWidth, ClientHeight,BLACKNESS);
 // Draw a 10x10 tiles diamond map
  RenderMap(10, 10, Tile, DIAMOND);
end;

end.
