import marcasCervezas.*

class Carpa {
	var property capacidadMax //limite de admision de gente
	var personasActualmente = [] //personas que tiene actualmente adentro la carpa 
	var property tieneBanda = true
	var property cerveza //cada carpa vende solo un tipo de cerveza
	var property nombreCarpa
	
	
	method personasActualmente() = personasActualmente
	method agregarPersona(persona){
		personasActualmente.add(persona)
	}
	method sacarPersona(persona){
		personasActualmente.remove(persona)
	}
	method dejaIngresar(persona){
		return (self.capacidadMax() > personasActualmente.size()) && not persona.estaEbria()
	}
	method servirJarra(litros, persona){
		if(personasActualmente.contains(persona)){
			const jarra1 = new Jarra(marca = self.cerveza(),lts = litros, carpaVendedora = nombreCarpa )
			persona.jarrasCompradas().add(jarra1)
		} else { self.error("la persona no esta en la carpa") }
	}
	method ebriosEmpedernidos(){
		const ebrios = personasActualmente.filter( { p => p.estaEbria() } )
		return ebrios.count( { p => p.jarrasCompradas().map( { j => j.lts() >= 1 } ) } )
	}
	method esHomogenea(){
		return personasActualmente.filter( { p => p.pais() } ).asSet().size() == 1
	}
	method personasQueNoCompraron(){
		return personasActualmente.filter( { p => p.jarrasCompradas().carpaVendedora() != nombreCarpa } )
	}
	
}

