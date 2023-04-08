unit UnitDatabase;

interface
uses
  UnitConnection.Model.Interfaces,
  UnitConnection.Firedac.Model,
	UnitFactory.Connection.Firedac;

type
  TDatabase = class
    class function Connection: iConnection;
    class function Query: iQuery;
  end;

implementation

{ TDatabase }

class function TDatabase.Connection: iConnection;
begin
  Result := TConnectionFiredac.Create('../../Dados/PRINCIPAL.FDB');
end;

class function TDatabase.Query: iQuery;
begin
	Result := TFactoryConnectionFiredac.New('../../Dados/PRINCIPAL.FDB').Query;
end;

end.
