import marcasCervezas.*
import carpas.*


class Persona {
	var property peso
	var property escuchaMusicaTradicional = false
	var property nivelDeAguante //numero
	var property jarrasCompradas = []
	var carpaActual //capaz no se usa
	
	//method comprarJarra(litros, marca){}
	
	method alcoholIngerido(){ return jarrasCompradas.sum( { j => j.graduacionAlcoholica() } ) }
	method estaEbria(){ return self.alcoholIngerido()*peso > nivelDeAguante }
	method leGusta(marca) = true
	method quiereEntrar(carpa){
		return self.leGusta(carpa.cerveza()) && (self.escuchaMusicaTradicional() == carpa.tieneBanda())
	} // le gusta la cerveza que tiene la carpa pasada por parametro y tambien la musica que tiene.
	method puedeEntrar(carpa){
		return self.quiereEntrar(carpa) && carpa.dejaIngresar(self)
	}
	method entrarACarpa(carpa){
		if(self.puedeEntrar(carpa)){
			carpa.agregarPersona(self)
			carpaActual = carpa
		} else {
			self.error("la persona no puede entrar")
		}
	}
	method carpaActual() = carpaActual
	method esCompatible(persona){ return
		(jarrasCompradas.map( { j => j.marca() } ).asSet()).difference((persona.jarrasCompradas().map( { j => j.marca() } ).asSet())) < //marcas de cerveza en diferencia
		(jarrasCompradas.map( { j => j.marca() } ).asSet()).intersection((persona.jarrasCompradas().map( { j => j.marca() } ).asSet())) //marcas de cerveza en comun
	}
	method estaEntrandoEnElVicio(){
		return jarrasCompradas.all( { i => jarrasCompradas.get(i).lts() >= jarrasCompradas.get(i - 1).lts() } )
	}
}

class Belga inherits Persona {
	//Se sabe que a los belgas les gusta solamente la cerveza con más de 4 gramos de lúpulo por litro
	const property pais
	override method leGusta(marca) = marca.lupulo() > 4  //Le gusta cervezas con mas de 4 gramos de lupulo.
	method esPatriota(){
		return jarrasCompradas.all( { j => j.marca() == self.pais() } )
	}
}

class Checo inherits Persona {
	//a los checos les gustan las cervezas de más de 8 % de graduación (ver abajo qué es la graduación de la cerveza)
	const property pais
	override method leGusta(marca) = marca.graduacionAlcoholica() > 0.08 
	method esPatriota(){
		return jarrasCompradas.all( { j => j.marca() == self.pais() } )
	}
}

class Aleman inherits Persona {
	//les gustan todas las marcas
	const property pais
	override method quiereEntrar(carpa){ return super(carpa) && carpa.personasActualmente().size().even() }
	//hace super de persona.quiereEntrar(carpa). Ademas, exijen que el numero 
	method esPatriota(){
		return jarrasCompradas.all( { j => j.marca() == self.pais() } )
	}
}
