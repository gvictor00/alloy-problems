abstract sig Maio{}	
one sig maio_amarelo, maio_azul, maio_branco, maio_verde extends Maio{}

abstract sig Nome{}
one sig nome_ana, nome_bruna, nome_raquel, nome_vivian extends Nome{}

abstract sig Suco{}
one sig suco_laranja, suco_limao, suco_maracuja, suco_morango extends Suco{}

abstract sig Animal{}
one sig cachorros, gatos, passaros, peixes extends Animal{}

sig Menina{
	maio: one Maio,
	nome: one Nome,
	suco: one Suco,
	animal: one Animal, 
	protetor: Int, // 1 = 40, 2 = 45, 3 = 50, 4 = 55
	idade: Int, // 1 = 8, 2 = 9, 3 = 10, 4 = 11
 	pos: Int 
}

pred estaNaPonta[m: Menina] {
	m.pos = 1 or m.pos = 4
}

pred estaNaEsquerdaImediata[m1: Menina, m2: Menina] {
	m1.pos = sub[m2.pos, 1]
}

pred estaNaDireitaImediata[m1: Menina, m2: Menina] {
	m1.pos = add[m2.pos, 1]
}

pred estaAoLado[m1: Menina, m2: Menina]{
	estaNaDireitaImediata[m1,m2] or estaNaEsquerdaImediata[m1,m2]
}

pred algumLugarAEsquerda[m1: Menina, m2: Menina]{
	m1.pos < m2.pos
}

fact {
	#Menina = 4
	pos in Menina one -> one (1 + 2 + 3 + 4)
	nome in Menina one -> one Nome
	maio in Menina one -> one Maio
	suco in Menina one -> one Suco
	animal in Menina one -> one Animal
	protetor in Menina one -> one (1 + 2 + 3 + 4)
	idade in Menina one -> one (1 + 2 + 3 + 4)
}

fact {
	// Na terceira posição está a menina que gosta de Cachorros.
	some m : Menina | m.pos = 3 and m.animal = cachorros

	// Quem gosta de Peixes está em uma das pontas.
	some m: Menina | estaNaPonta[m] and m.animal = peixes
	
	// A garota que gosta de Gatos está na primeira posição.
	some m: Menina | m.animal = gatos and m.pos = 1

	// Ana usa protetor solar de FPS 50.
	some m: Menina | m.nome = nome_ana and m.protetor = 3
	
	// Na segunda posição está a menina que usa filtro solar com FPS 55.
	some m: Menina | m.pos = 2 and m.protetor = 4

	// A garota mais nova está ao lado da que usa protetor solar de menor FPS.
	some m1, m2: Menina | m1.idade = 1 and m2.protetor = 1 and estaAoLado[m1,m2]
	
	// Quem gosta de suco de Morango está na quarta posição.
	some m: Menina | m.suco = suco_morango and m.pos = 4

	// A menina que gosta de suco de Maracujá está ao lado da que gosta de Pássaros.
	estaAoLado[(suco.suco_maracuja),(animal.passaros)]

	// A menina que gosta de limonada está ao lado da que gosta de suco de Maracujá.
	estaAoLado[(suco.suco_limao), (suco.suco_maracuja)]

	// Quem gosta de suco de Laranja está em uma das pontas.
	estaNaPonta[(suco.suco_laranja)]

	// A menina de maiô Azul está em algum lugar à esquerda da menina de 9 anos.
	some m1,m2 : Menina | algumLugarAEsquerda[m1,m2] and m1.maio = maio_azul and m2.idade = 2

	// A garota de 8 anos está na quarta posição.
	some m : Menina | m.idade = 1 and m.pos = 4

	// A garota de 11 anos está em uma das pontas.
	some m: Menina | m.idade = 4 and estaNaPonta[m]
	
	// Vivian gosta de Pássaros.
	some m: Menina | m.nome = nome_vivian and m.animal = passaros

	// Raquel está na primeira posição.
	some m: Menina | m.nome = nome_raquel and m.pos = 1

	// A menina de maiô Verde está na quarta posição.
	some m: Menina | m.maio = maio_verde and m.pos = 4

	// A menina de maiô Branco está em uma das pontas.
	some m: Menina | m.maio = maio_branco and estaNaPonta[m]
} 

run {} for 10	
