// ������������ Shadow Engine 2D. ������� �������.

unit uDemoGame;

interface

uses
  FMX.Types, System.UITypes, System.Classes, System.Types,
  FMX.Objects, System.Generics.Collections,
  uEasyDevice, uDemoEngine, uDemoGameLoader, uDemoObjects;

type
  TDemoGame = class
  private
    FEngine: TDemoEngine;
    FBackObjects: TList<TLittleAsteroid>; // ������� ����
    FShip: TShip;
    FAsteroids: TList<TAsteroid>;
    function GetImage: TImage;
    procedure SetImage(const Value: TImage);
    procedure mouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, y: single);
  public
    property Image: TImage read GetImage write SetImage;
    procedure Prepare;
    constructor Create;
  end;

implementation

{ TDemoGame }

constructor TDemoGame.Create;
begin
  FEngine := TDemoEngine.Create;
end;

function TDemoGame.GetImage: TImage;
begin
  Result := FEngine.Image;
end;

procedure TDemoGame.mouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: single);
var
  i, vL: Integer;
begin
  { ������ ������ ���� }
  fEngine.mouseDown(Sender, Button, Shift, x, y);

  vL := Length(fEngine.Downed) - 1;

  for i := 0 to vL do
    fEngine.sprites[fEngine.Downed[i]].OnMouseDown(Sender, Button, Shift, x, y);
end;

procedure TDemoGame.Prepare;
var
  vLoader: TLoader;
  i: Integer;
begin
  FEngine.Resources.addResFromLoadFileRes('images.load');
  FEngine.Background.LoadFromFile(UniPath('back.jpg'));

  FBackObjects := TList<TLittleAsteroid>.Create;
  vLoader := TLoader.Create(FEngine);
  // ������� ����������� ����
  for i := 0 to 47 do
    FBackObjects.Add(vLoader.RandomAstroid);

  // ������� �������
  FShip := vLoader.CreateShip;

  FAsteroids := TList<TAsteroid>.Create;
  for i := 0 to 3 do
    FAsteroids.Add(vLoader.BigAstroid);

  fEngine.Start;
end;

procedure TDemoGame.SetImage(const Value: TImage);
begin
  fEngine.init(Value);
  Value.OnMouseDown := Self.MouseDown;
  Value.OnMouseUp := fEngine.MouseUp;
end;

end.
