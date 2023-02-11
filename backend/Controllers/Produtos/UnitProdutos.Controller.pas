unit UnitProdutos.Controller;

interface
uses
  System.SysUtils,
  System.Json,
  Horse;

type
  TControllerProdutos = class
    class procedure Registry;
    class procedure GetAll(Res: THorseResponse);
    class procedure GetOne(Req: THorseRequest; Res: THorseResponse);
    class procedure Create(Req: THorseRequest; Res: THorseResponse);
    class procedure Update(Req: THorseRequest; Res: THorseResponse);
    class procedure Delete(Req: THorseRequest; Res: THorseResponse);
  end;

implementation

{ TControllerProdutos }

uses
  UnitProdutos.Model,
  UnitTabela.Helper.Json,
  UnitDatabase,
  UnitConnection.Model.Interfaces;

class procedure TControllerProdutos.Create(Req: THorseRequest;
  Res: THorseResponse);
var Produto: TProdutos;
  body: string;
begin
  body := Req.Body;
  Produto := TProdutos.Create(TDatabase.Connection).fromJson<TProdutos>(body);
  Produto.SalvaNoBanco(1);
  Res.Send<TJSONObject>(TJSONObject.ParseJSONValue(Produto.ToJson) as TJSONObject);
end;

class procedure TControllerProdutos.Delete(Req: THorseRequest;
  Res: THorseResponse);
var
  Produto: TProdutos;
  id: integer;
begin
  id := Req.Params.Items['id'].ToInteger();
  Produto := TProdutos.Create(TDatabase.Connection);
  Produto.Apagar(id);
  Res.Send('').Status(THTTPStatus.NoContent);
end;

class procedure TControllerProdutos.GetAll(Res: THorseResponse);
var
  Query: iQuery;
  Produto: TProdutos;
  aJson: TJSONArray;
begin
  aJson := TJSONArray.Create;
  Query := TDatabase.Query;
  Query.Open('SELECT PRO_CODIGO FROM PRODUTOS');
  Query.DataSet.First;
  while not Query.DataSet.Eof do
  begin
    Produto := TProdutos.Create(TDatabase.Connection);
    Produto.BuscaDadosTabela(Query.DataSet.FieldByName('PRO_CODIGO').AsInteger);
    aJson.AddElement(TJSONObject.ParseJSONValue(Produto.ToJson) as TJSONObject);
    Query.DataSet.Next;
  end;
  Res.Send<TJSONArray>(aJson);
end;

class procedure TControllerProdutos.GetOne(Req: THorseRequest; Res: THorseResponse);
var Produto: TProdutos;
  id: Integer;
begin
  id := Req.Params.Items['id'].ToInteger();
  Produto := TProdutos.Create(TDatabase.Connection);
  Produto.BuscaDadosTabela(id);
  Res.Send<TJSONObject>(TJSONObject.ParseJSONValue(Produto.ToJson) as TJSONObject);
end;

class procedure TControllerProdutos.Registry;
begin
  THorse
    .Get('/produtos', GetAll)
    .Post('/produtos', Create)
    .Put('/produtos', Update)
    .Get('/produtos/:id', GetOne)
    .Delete('/produtos/:id', Delete);
end;

class procedure TControllerProdutos.Update(Req: THorseRequest;  Res: THorseResponse);
var Produto: TProdutos;
  body: string;
begin
  body := Req.Body;
  Produto := TProdutos.Create(TDatabase.Connection).fromJson<TProdutos>(body);
  Produto.SalvaNoBanco(1);
  Res.Send<TJSONObject>(TJSONObject.ParseJSONValue(Produto.ToJson) as TJSONObject);
end;

end.
