unit UnitMesas.Controller;

interface

uses
  System.SysUtils,
  System.JSON,
  Horse,
  Horse.Commons,
  Horse.Jhonson,
  UnitConnection.Model.Interfaces,
  DataSet.Serialize;

type
  TControllerMesas = class
    class procedure Registry;
    class procedure GetMesas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure GetMesasPorCodigo(Req: THorseRequest; Res: THorseResponse);
  end;

implementation

{ TControllerMesas }

uses UnitDatabase;

class procedure TControllerMesas.GetMesas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Query: iQuery;
begin
  Query := TDatabase.Query;
  Query.Open('SELECT MES_CODIGO, MES_NOME, MES_ESTADO, MES_JUNCAO, COALESCE(COM_VALOR, 0) MES_VALOR FROM MESAS LEFT JOIN COMANDAS ON COM_MESA = MES_CODIGO AND COM_DATA_FECHAMENTO IS NULL');
  if not Query.DataSet.IsEmpty then
  begin
    // retorna o resultado
    Res.Send<TJSONArray>(Query.DataSet.ToJSONArray()).Status(THTTPStatus.OK);
  end
  else
  begin
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('msg',
      'mesas não encontradas')).Status(THTTPStatus.NotFound);
  end;
end;

class procedure TControllerMesas.GetMesasPorCodigo(Req: THorseRequest; Res: THorseResponse);
var
  Query: iQuery;
  Codigo: integer;
begin
  Codigo := Req.Params.Items['id'].ToInteger;
  Query := TDatabase.Query;
  Query.Add('SELECT MES_CODIGO, MES_NOME, MES_ESTADO, MES_JUNCAO, COALESCE(COM_VALOR, 0) MES_VALOR FROM MESAS LEFT JOIN COMANDAS ON COM_MESA = MES_CODIGO AND COM_DATA_FECHAMENTO IS NULL');
  Query.Add('WHERE MES_CODIGO = :CODIGO');
  Query.AddParam('CODIGO', Codigo);
  Query.Open();
  if not Query.DataSet.IsEmpty then
  begin
    // retorna o resultado
    Res.Send<TJSONObject>(Query.DataSet.ToJSONObject()).Status(THTTPStatus.OK);
  end
  else
  begin
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('msg',
      'mesa não encontrada')).Status(THTTPStatus.NotFound);
  end;
end;

class procedure TControllerMesas.Registry;
begin
  THorse.Get('/mesas', GetMesas)
        .Get('/mesas/:id', GetMesasPorCodigo);
end;

end.
