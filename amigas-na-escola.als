abstract sig Mochila{}
one sig amarela, azul, preta, verde, vermelha extends Mochila{}

abstract sig Nome{}
one sig ana, jessica, joana, pati, renata extends Nome{}

abstract sig Materia{}
one sig artes, biologia, historia, matematica, portugues extends Materia{}

abstract sig Animal{}
one sig cachorros, cavalos, gatos, hamsters, passaros extends Animal{}

abstract sig Cidade{}
one sig f_de_noronha, florianopolis, recife, rio_de_janeiro, salvador extends Cidade{}

abstract sig Suco{}
one sig abacaxi, laranja, limao, maracuja, morango extends Suco{}

sig Menina{
	nome: one Nome,
	mochila: one Mochila,
	materia: one Materia,
	animal: one Animal,
	cidade: one Cidade,
	suco: one Suco, 
	pos: Int
}

pred exatamenteADireita[m1:Menina, m2:Menina]{
	m1.pos = add[m2.pos, 1]
}

pred exatamenteAEsquerda[m1:Menina, m2:Menina]{
	m1.pos = sub[m2.pos, 1]
}

pred exatamenteAoLado[m1:Menina, m2:Menina]{
	exatamenteAEsquerda[m1,m2] or exatamenteADireita[m1,m2]
}

pred eh_primeira_da_esquerda[m: Menina]{
	m.pos = 1
}

pred eh_mais_a_direita[m: Menina]{
	m.pos = 5
}

pred esta_no_meio[m: Menina]{
	m.pos = 3
}

fact {	
	#Menina = 5
	pos in Menina one -> one (1 + 2 + 3 +4 + 5)
	nome in Menina one -> one Nome
	mochila in Menina one -> one Mochila
	materia in Menina one -> one Materia
	animal in Menina one -> one Animal
	cidade in Menina one -> one Cidade
	suco in Menina one -> one Suco
}

fact {
	// Joana gosta de suco de Abacaxi.
	(nome.joana).suco = abacaxi

	// A menina que tem Hamsters gosta de estudar Artes.
	one m: Menina | m.animal = hamsters and m.materia = artes

	// O suco favorito de Ana é de Limão.
	one m: Menina | m.suco = limao and m.nome = ana

	// Jéssica está exatamente à esquerda da Renata.
	exatamenteAEsquerda[(nome.jessica), (nome.renata)]

	// Pati é a primeira da esquerda.
	eh_primeira_da_esquerda[(nome.pati)]

	// A menina mais à direita gosta de estudar Artes.
	eh_mais_a_direita[(materia.artes)]

	// Quem toma suco de Laranja gosta de Cavalos.
	(suco.laranja).animal = cavalos

	// A pessoa que gosta de suco de Limão está no meio.
	esta_no_meio[(suco.limao)]

	// A mochila da Jéssica é Verde.
	(nome.jessica).mochila = verde

	// A menina exatamente à esquerda da do meio viajará Florianópolis.
	one m: Menina | m.pos = 2 and m.cidade = florianopolis

	// Quem quer viajar pra Recife tem a mochila Amarela.
	one m: Menina | m.cidade = recife and m.mochila = amarela
	
	// A menina que gosta do suco de Abacaxi senta ao lado da que viajará para Fernando de Noronha.
	exatamenteAoLado[(suco.abacaxi), (cidade.f_de_noronha)]

	//A dona da mochila Vermelha vai viajar para Fernando de Noronha.
	one m: Menina | m.mochila = vermelha and m.cidade = f_de_noronha

	//A primeira menina da esquerda usa uma mochila Amarela.
	one m: Menina | eh_primeira_da_esquerda[m] and m.mochila = amarela

	//A menina da mochila Azul tem Cachorros.
	(mochila.azul).animal = cachorros

	//Quem gosta de Biologia senta ao lado da menina que tem Hamsters.
	exatamenteAoLado[(materia.biologia), (animal.hamsters)]

	//A garota que senta exatamente à direita de quem gosta de História prefere Matemática.
	some m1, m2: Menina | exatamenteADireita[m1, m2] and m1.materia = matematica and m2.materia = historia

	//Quem gosta de suco de Laranja senta ao lado de quem gosta de suco de Maracujá.
	exatamenteAoLado[(suco.laranja),(suco.maracuja)]
	
	//Viajará para o Rio de Janeiro a menina que tem a mochila Preta.
	some m: Menina | m.mochila = preta and m.cidade = rio_de_janeiro

	//A garota que gosta de suco de Morango tem Pássaros como animal de estimação.
	some m: Menina | m.suco = morango and m.animal = passaros

	//A menina que gosta de Biologia senta ao lado da que gosta de Português.
	exatamenteAoLado[(materia.biologia), (materia.portugues)]

	//Jéssica viajará para Salvador nas férias.
	(nome.jessica).cidade = salvador
}	

run {} for 5
