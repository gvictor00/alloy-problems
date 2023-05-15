abstract sig Mochila{}
one sig Amarela, Azul, Preta, Verde, Vermelha extends Mochila{}

abstract sig Nome{}
one sig Ana, Jessica, Joana, Pati, Renata extends Nome{}

abstract sig Materia{}
one sig Artes, Biologia, Historia, Matematica, Portugues extends Materia{}

abstract sig Animal{}
one sig Cachorros, Cavalos, Gatos, Hamsters, Passaros extends Animal{}

abstract sig Cidade{}
one sig F_de_Noronha, Florianopolis, Recife, Rio_de_Janeiro, Salvador extends Cidade{}

abstract sig Suco{}
one sig Abacaxi, Laranja, Limao, Maracuja, Morango extends Suco{}

sig Menina{
	nome: one Nome,
	mochila: one Mochila,
	materia: one Materia,
	animal: one Animal,
	cidade: one Cidade,
	suco: one Suco, 
	esq: lone Menina, 
	dir: lone Menina
}

fact {	
	// Existem, somente 5 meninas que não tem nomes repetidos
	#Menina = 5
	all m: Menina | m.esq != none or m.dir != none	
	all m: Menina | m.esq != m and m.dir != m
	all m: Menina | m.esq != m.dir
//	all m1, m2 : Menina | (m1.esq = m2 and m2.dir = m1) and (m1.dir = m2 and m2.esq = m1)
	all disj m1, m2: Menina | m1.nome != m2.nome
	all disj m1, m2: Menina | m1.mochila != m2.mochila
	all disj m1, m2: Menina | m1.materia != m2.materia
	all disj m1, m2: Menina | m1.animal != m2.animal
	all disj m1, m2: Menina | m1.cidade != m2.cidade
	all disj m1, m2: Menina | m1.suco != m2.suco
	all disj m1, m2: Menina | m1.esq != m2.esq
	all disj m1, m2: Menina | m1.dir != m2.dir
}

fact {
	//  Joana gosta de suco de Abacaxi.
	some m: Menina | m.nome = Joana and m.suco = Abacaxi

	// A menina que tem Hamsters gosta de estudar Artes.
	some m: Menina | m.animal = Hamsters and m.materia = Artes

	// O suco favorito de Ana é de Limão
	some m: Menina | m.nome = Ana and m.suco = Limao

	// Jéssica está exatamente à esquerda da Renata
	some m: Menina | m.nome = Jessica and m.dir.nome = Renata

	// Pati é a primeira da esquerda
	some m: Menina | m.nome = Pati and no m.esq
	
	// A menina mais à direita gosta de estudar Artes.
	some m: Menina | m.materia = Artes and no m.dir

	// Quem toma suco de Laranja gosta de Cavalos 
	some m: Menina | m.suco = Laranja and m.animal = Cavalos

	// A pessoa que gosta de suco de Limão está no meio.
	

	// A mochila da Jéssica é Verde.
	some m: Menina | m.nome = Jessica and m.mochila = Verde

	// A menina exatamente à esquerda da do meio viajará Florianópolis.
	some m: Menina | m.suco = Limao and m.esq.cidade = Florianopolis
	
	// Quem quer viajar pra Recife tem a mochila Amarela.
	some m: Menina | m.cidade = Recife and m.mochila = Amarela

	// A menina que gosta do suco de Abacaxi senta ao lado da que viajará para Fernando de Noronha.
	some m1, m2: Menina | m1.suco = Abacaxi and m2.cidade = F_de_Noronha	 and (m1.esq = m2 or m1.dir = m2)

	// A dona da mochila Vermelha vai viajar para Fernando de Noronha.
	some m: Menina | m.mochila = Vermelha and m.cidade = F_de_Noronha

	// A primeira menina da esquerda usa uma mochila Amarela
	some m1: Menina | no m1.esq and m1.mochila = Amarela

	// A menina da mochila Azul tem Cachorros.
	some m: Menina | m.mochila = Azul and m.animal = Cachorros

	// Quem gosta de Biologia senta ao lado da menina que tem Hamsters.
	some m1, m2: Menina | m1.materia = Biologia and m2.animal = Hamsters and (m1.esq = m2 or m1.dir = m2)

	// A garota que senta exatamente à direita de quem gosta de História prefere Matemática.
	some m1: Menina | m1.esq.materia = Historia and m1.materia = Matematica
	
	// Quem gosta de suco de Laranja senta ao lado de quem gosta de suco de Maracujá.
	some m1, m2: Menina | m1.suco = Laranja and m2.suco = Maracuja and (m1.esq = m2 or m1.dir = m2)

	// Viajará para o Rio de Janeiro a menina que tem a mochila Preta.
	some m: Menina | m.cidade = Rio_de_Janeiro and m.mochila = Preta

	// A garota que gosta de suco de Morango tem Pássaros como animal de estimação.
	some m: Menina | m.suco = Morango and m.animal = Passaros

	//  A menina que gosta de Biologia senta ao lado da que gosta de Português
	some m1, m2: Menina | m1.materia = Biologia and m2.materia = Portugues and (m1.esq = m2 or m1.dir = m2)

	// Jéssica viajará para Salvador nas férias.
	some m: Menina | m.nome = Jessica and m.cidade = Salvador

}

run {} for 10
