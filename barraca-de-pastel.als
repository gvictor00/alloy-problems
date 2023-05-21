abstract sig Camiseta{}
one sig amarelo, azul, branco, verde, vermelho extends Camiseta{}

abstract sig Nome{}
one sig carlos, fabiano, julio, marcelo, rubens extends Nome{}

abstract sig Pastel{}
one sig calabresa, carne, frango, pizza, queijo extends Pastel{}

abstract sig Condimento{}
one sig ketchup, maionese, mortadela, pimenta, vinagrete extends Condimento{}

abstract sig Suco{}
one sig laranja, limao, maca, maracuja, uva extends Suco{}

abstract sig Profissao{}
one sig bancario, entregador, feirante, relojoeiro, vendedor extends Profissao{}

sig Homem {
	camiseta : one Camiseta,
	nome : one Nome,
	pastel : one Pastel, 
	condimento : one Condimento,
	suco : one Suco,
	profissao : one Profissao,
	pos : Int
}

fact {
	#Homem = 5
	camiseta in Homem one -> one Camiseta
	nome in Homem one -> one Nome
	pastel in Homem one -> one Pastel
	condimento in Homem one -> one Condimento
	suco in Homem one -> one Suco
	profissao in Homem one -> one Profissao
	pos in Homem one -> one (1+2+3+4+5)
}

pred exatamenteADireita[h1:Homem, h2:Homem]{
	h1.pos = sub[h2.pos, 1]
}

pred exatamenteAEsquerda[h1:Homem, h2:Homem]{
	h1.pos = add[h2.pos, 1]
}

fact {
	// Júlio está exatamente à direita do Bancário.
	exatamenteADireita[(nome.julio), (profissao.bancario)]
}

run {} for 5

/*
Júlio está exatamente à direita do Bancário.
Quem gosta de Maionese está em algum lugar entre quem gosta de Pimenta e quem gosta de Mostarda, nessa ordem.
Fabiano vai comer um pastel de Frango.
O cliente de Vermelho está ao lado de quem vai beber um suco de Maracujá.
Fabiano está em algum lugar entre quem gosta de Vinagrete e o Carlos, nessa ordem.
O Entregador pediu um pastel de Carne.
O Relojoeiro está exatamente à esquerda de quem beberá um suco de Maçã.
O rapaz de Vermelho está em algum lugar à esquerda de quem gosta de Ketchup.
Na quarta posição está o cliente que gosta de Mostarda.
O Feirante está ao lado de quem gosta de Pimenta.
Quem vai comer um pastel de Carne está em algum lugar entre quem vai comer um pastel de Frango e quem vai comer um pastel de Calabresa, nessa ordem.
O cliente de Azul gosta de Maionese.
Rubens está exatamente à direita de quem pediu um pastel de Queijo.
O Feirante vai beber um suco de Maracujá.
O rapaz de Amarelo está em algum lugar à esquerda do rapaz de Branco.
Quem pediu um suco de Laranja está em algum lugar entre Júlio e quem pediu suco de Limão, nessa ordem.
Na primeira posição está quem vai comer um pastel de Pizza.
O Bancário está usando um camiseta Verde.
Quem gosta de Pimenta está em algum lugar entre o Relojoeiro e o cliente de Azul, nessa ordem.
*/
