package arazu.seguridad

import arazu.alertas.Alerta
import arazu.inventario.Bodega
import arazu.parametros.EstadoSolicitud
import arazu.proyectos.Proyecto
import arazu.solicitudes.NotaPedido

class InicioController extends Shield {

    def index() {
        def estadoPr = EstadoSolicitud.findByCodigo("E01")
        def estadoPa = EstadoSolicitud.findByCodigo("E02")
        def estadoAp = EstadoSolicitud.findByCodigo("A01")
        def estadoEj = EstadoSolicitud.findByCodigo("C01")

        def pr = NotaPedido.findAllByEstadoSolicitud(estadoPr)
        def pa = NotaPedido.findAllByEstadoSolicitud(estadoPa)
        def aprobadas = NotaPedido.findAllByEstadoSolicitud(estadoAp)
        def ejecutadas = NotaPedido.findAllByEstadoSolicitud(estadoEj)
        def alertas = Alerta.findAllByRecibeAndFechaRecibidoIsNull(session.usuario)
        def bodegas = Bodega.findAllByActivo(1)
        def proyectos = Proyecto.findAllByFechaFinIsNullOrFechaFinGreaterThan(new Date())
        [pr: pr, pa: pa, aprobadas: aprobadas, ejecutadas: ejecutadas, alertas: alertas, bodegas: bodegas, proyectos: proyectos, estadoPr: estadoPr, estadoPa: estadoPa, estadoAp: estadoAp, estadoEj: estadoEj]
    }

    def demoUI() {

    }

    def parametros() {

    }
}


