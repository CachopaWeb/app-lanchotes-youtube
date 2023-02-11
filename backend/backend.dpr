program backend;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  UnitMesas.Controller in 'Controllers\Mesas\UnitMesas.Controller.pas',
  UnitDatabase in 'Database\UnitDatabase.pas',
  UnitProdutos.Model in 'Models\Produtos\UnitProdutos.Model.pas',
  UnitProdutos.Controller in 'Controllers\Produtos\UnitProdutos.Controller.pas';

begin
  //middlewares
  THorse.Use(Jhonson);

  //Controllers
  TControllerMesas.Registry;
  TControllerProdutos.Registry;

  ////
  THorse.Listen(9000,
  procedure(App: THorse)
  begin
    Writeln('Server is running on port '+App.Port.ToString);
  end);
end.
