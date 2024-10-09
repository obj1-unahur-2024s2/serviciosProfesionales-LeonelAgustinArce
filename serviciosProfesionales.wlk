import vm.*
class Universidad{
    const property provincia
    var property honorarios 
    var donaciones = 0
    method recibirDonaciones(unImporte) {
        donaciones += unImporte
    }
}

class AsociadosAUniversidad{
    const property universidad 
    method honorarios() = universidad.honorarios()
    method puedeTrabajar() = [universidad.provincia()]
    method cobrar(unImporte) {
        universidad.recibirDonaciones(unImporte*0.5)
    }
}

class AsociadosALitoral{
    const property universidad
    method puedeTrabajar() = ["Entre Rios", "Santa Fe", "Corrientes"]
    method honorarios() = 3000
    method cobrar(unImporte) {
        asociacionesProfesionalDeLitoral.recaudar(unImporte)
    }
}

object asociacionesProfesionalDeLitoral {
    var recaudaciones = 0

    method recaudar(unImporte) {
        recaudaciones += unImporte
    }
}

class Libres{
    const property universidad 
    var property puedeTrabajar
    var property honorarios
    method cobrar(unImporte) {

    }
}

class Empresa{
    const property profesionales = []
    var property honorariosDeReferencia

    method agregarProfesionales(unProfesional) {
        profesionales.add(unProfesional)
    }
    method cuantos(unaUniversidad) {
        return profesionales.count({p => p.universidad() == unaUniversidad})
    }
    method caros() {
        return profesionales.filter({p => p.honorarios() > honorariosDeReferencia})
    }
    method formadoras() {
        return profesionales.map({p => p.universidad()}).asSet()
    }
    method masBarato() {
        return profesionales.min({p => p.honorarios()})
    }
    method esGenteAcotada() {
        return !profesionales.any({p => p.puedeTrabajar().size() > 3})
    }
    method puedeSatisfacer(unSolicitante) {
        return profesionales.any({p => unSolicitante.puedeSerAtendido(p)})
    }
}

class SolicitantePersona{
    var property provincia
    method puedeSerAtendido(unProfesional) = unProfesional.puedeTrabajar().contains(provincia)
}

class SolicitanteInstitucion{
    var property universidades
    method puedeSerAtendido(unProfesional) {
      universidades.contains(unProfesional.universidad())
    }
}

class SolicitanteClub {
    var property provincias
    method puedeSerAtendido(unProfesional) {
        return !provincias.asSet().intersection(unProfesional.puedeTrabajar().asSet()).isEmpty()
    }
}

