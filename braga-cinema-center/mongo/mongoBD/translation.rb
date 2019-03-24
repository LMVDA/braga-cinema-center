table "Cliente" do
	column "idCliente", :key
	column "username", :string
	column "password", :string
	column "nome", :string
	column "telefone", :string
	column "dataNascimento", :date
	column "email", :string
	column "dataRegisto", :datetime
    column "membroPremium", :boolean
end

table "Bilhete", 
	:embed_in => "Cliente", 
	:on => "idCliente" do

	column "idBilhete", :key
	column "IVA", :float
	column "dataCompra", :datetime
	column "dataSessao", :date
	column "tipoBilhete", :string
	column "desconto", :float
	column "precoTotal", :float
	column "lugar", :integer
	column "idSessao", :integer, :references => "Sessao"
	column "idCliente", :integer, :references => "Cliente"
end

table "Sessao" do
	column "idSessao", :key
	column "precoBase", :float
	column "idHorario", :integer, :references => "Horario"
	column "idFilme", :integer, :references => "Filme"
end

table "Bilhete", 
	:embed_in => "Sessao", 
	:on => "idSessao" do

	column "idBilhete", :key
	column "IVA", :float
	column "dataCompra", :datetime
	column "dataSessao", :date
	column "tipoBilhete", :string
	column "desconto", :float
	column "precoTotal", :float
	column "lugar", :integer
	column "idSessao", :integer, :references => "Sessao"
	column "idCliente", :integer, :references => "Cliente"
end

table "Sala" do
    column "idSala", :key
    column "capacidade", :integer
    column "nomeSala", :string
    column "tipoSala", :string
end

table "lugar", 
	:embed_in => "Sala", 
	:on => "idSala" do

	column "lugar", :integer
	column "idSala", :integer, :references => "Sala"
end

table "Filme",
	column "idFilme", :key
	column "titulo", :string
	column "duracao", :integer
	column "dataEstreia", :date
	column "dataFim", :date
	column "idadeMinima", :integer
	column "idSala", :integer, :references => "Sala"
end

table "Horario",
	column "idHorario", :key
	column "hora", :time
end

