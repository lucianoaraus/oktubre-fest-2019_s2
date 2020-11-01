/*
**Queremos controlar la entrada a estas carpas dependiendo de la disponibilidad de la carpa y los gustos del público.
**Un programa en objetos que modele el comportamiento de las personas en la fiesta.
*/

class Cerveza { //es una clase abstracta
	var property marca
	var property lupulo
	var property paisElaboracion
	
	method graduacionAlcoholica() //metodo abstracto
}

class Jarra {
	var property marca
	var property lts
	var property carpaVendedora
	
	method contenidoDeAlcohol() = lts*marca.graduacionAlcoholica()
}

class Rubia inherits Cerveza {
	var property graduacionAlcoholica 
	method tipo(){ return "rubia" }
}

class Negra inherits Cerveza {	
	override method graduacionAlcoholica() = graduacionReglamentaria.graduacionMundial().min(2*lupulo)
	method tipo(){ return "negra" }
}

class Roja inherits Negra{
	override method graduacionAlcoholica() = super()* 1.25  
	override method tipo(){ return "roja" }
}

object corona inherits Rubia {
	override method paisElaboracion(){ return "mexico" }
}

object guiness inherits Negra {
	override method paisElaboracion(){ return "alemania" }
}

object hofbrau inherits Roja {
	override method paisElaboracion(){ return "alemania" }
}

object graduacionReglamentaria {
	//Es unica para todas las cervezas negras (puede cambiar con el tiempo).
	var property graduacionMundial = 0
}
