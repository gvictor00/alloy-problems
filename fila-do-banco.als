abstract sig Camisa{}
one sig amarela, azul, branca, verde, vermelha extends Camisa{}

abstract sig Conta{}
one sig agua, aluguel, celular, luz, telefone extends Conta{}

abstract sig Nome{}
one sig augusto, douglas, jose, ronaldo, samuel extends Nome{}

abstract sig Profissao{}
one sig bombeiro, fotografo, massagista, pesquisador, veterinario extends Profissao{}

abstract sig Animal{}
one sig cachorro, gato, passaro, peixe, tartaruga extends Animal{}

abstract sig Esporte{}
one sig basquete, futebol, sinuca, natacao, volei extends Esporte{}

sig Homem{
	camisa: one Camisa,	
	conta: one Conta,
	nome: one Nome,
	profissao: one Profissao,	
	animal: one Animal,
	esporte: one Esporte,
	posFila: Int
}

pred estaAoLado[h1: Homem, h2: Homem]{
	(h1.posFila =add[h2.posFila,1]) or (h1.posFila= sub[h2.posFila, 1])
}

pred imediatamenteAEsquerda[h1:Homem, h2:Homem]{
	h1.posFila= sub[h2.posFila, 1]
}

pred imediatamenteADireita[h1:Homem, h2:Homem]{
	h1.posFila= add[h2.posFila, 1]
}

pred estaADireita[h1: Homem, h2:Homem]{
	h1.posFila > h2.posFila 
}

pred estaAEsquerda[h1: Homem, h2:Homem]{
	h1.posFila < h2.posFila 
}

pred estaNaPonta[h: Homem]{
	h.posFila = 1 or h.posFila = 5
}

fact{
	#Homem = 5
	posFila in Homem one -> one (1+2+3+4+5)
	camisa in Homem one -> one Camisa
	conta in Homem one -> one Conta
	nome in Homem one -> one Nome
	profissao in Homem one -> one Profissao
	animal in Homem one -> one Animal
	esporte in Homem one -> one Esporte	
}

fact {
	// Na quarta posição está o homem que gosta de sinuca
	one h:Homem | h.esporte = sinuca and h.posFila = 4

	// Quem gosta de Futebol está na quinta posição.
	one h:Homem | h.esporte = futebol and h.posFila = 5

	// O homem que gosta de Basquete está na segunda posição
	one h:Homem | h.esporte = basquete and h.posFila = 2

	// Quem gosta de Vôlei está de Vermelho
	(camisa.vermelha).esporte = volei

	// O dono do Peixe está exatamente à esquerda de quem pratica Natação
	estaAEsquerda[(animal.peixe),(esporte.natacao)]

	//O homem de Branco é o dono do réptil.
	(camisa.branca).animal = tartaruga

	// O Bombeiro está exatamente à direita do Samuel
	estaADireita[(profissao.bombeiro),(nome.samuel)]
	
	// O Veterinário está na quinta posiçã
	one h:Homem | h.profissao = veterinario and h.posFila = 5

	// O Pesquisador está na terceira posição
	one h:Homem | h.profissao = pesquisador and h.posFila = 3
	
	// Douglas trabalha como Fotógrafo
	(nome.douglas).profissao = fotografo

	// José está na quinta posição.
	(nome.jose).posFila = 5

	// O Pesquisador está exatamente à esquerda do Augusto
	imediatamenteAEsquerda[(profissao.pesquisador),(nome.augusto)]

	// Douglas tem um Cachorro
	one h: Homem | h.animal = cachorro and h.nome = douglas

	// Na quinta posição está o homem da conta de Telefone
	one h: Homem | h.conta = telefone and h.posFila = 5

	// O homem de Branco vai pagar a conta de Água.	
	one  h: Homem | h.camisa = branca and h.conta = agua

	// Na terceira posição está quem vai pagar a conta de Luz.
	one  h: Homem | h.posFila = 3 and h.conta = luz

	// Ronaldo vai pagar a conta de Celular
	one h: Homem | h.nome = ronaldo and h.conta = celular

	// O homem de Verde tem um Pássaro.
	(animal.passaro).camisa = verde

	// O homem de azul está em uma das pontas
	estaNaPonta[(camisa.azul)]

	// O homem que tem um Gato está exatamente à direita de que gosta de Sinuca
	imediatamenteADireita[(animal.gato), (esporte.sinuca)]

	// O homem que tem um Pássaro está ao lado do que joga Sinuca.
	estaAoLado[(animal.passaro), (esporte.sinuca)]
}

run { 
     
} for 5 but 5 int
