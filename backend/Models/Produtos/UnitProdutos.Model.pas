unit UnitProdutos.Model;

interface

uses UnitPortalORM.Model;

type
  [TNomeTabela('PRODUTOS', 'PRO_CODIGO')]
  TProdutos = class(TTabela)
  private
    FNome: string;
    FCodigo: integer;
    FValor: Currency;
    FValorCusto: Currency;
  public
    [TCampo('PRO_CODIGO', 'INTEGER NOT NULL PRIMARY KEY')]
    property Codigo: integer read FCodigo write FCodigo;
    [TCampo('PRO_NOME', 'VARCHAR(200)')]
    property Nome: string read FNome write FNome;
    [TCampo('PRO_VALORV', 'NUMERIC(9,2)')]
    property Valor: Currency read FValor write FValor;
    [TCampo('PRO_VALORC', 'NUMERIC(9,2)')]
    property ValorCusto: Currency read FValorCusto write FValorCusto;
  end;

implementation

end.
