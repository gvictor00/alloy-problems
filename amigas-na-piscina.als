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

fact {
	#Menina = 4
	pos in Menina one -> one (1 + 2 + 3 + 4)
	nome in Menina one -> one Nome
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
	some m: Menina | m.idade = 1 and m.protetor = 1
	
} 

/*

Quem gosta de suco de Morango está na quarta posição.
A menina que gosta de suco de Maracujá está ao lado da que gosta de Pássaros.
A menina que gosta de limonada está ao lado da que gosta de suco de Maracujá.
Quem gosta de suco de Laranja está em uma das pontas.
A menina de maiô Azul está em algum lugar à esquerda da menina de 9 anos.
A garota de 8 anos está na quarta posição.
A garota de 11 anos está em uma das pontas.
Vivian gosta de Pássaros.
Raquel está na primeira posição.
A menina de maiô Verde está na quarta posição.
A menina de maiô Branco está em uma das pontas.
*/

run {} for 10	
