<%@ page import="seguridad.Persona" %>
<div class="ventana">
    <div class="fila-ventana">
        <span style="font-weight: bold">Usuario:</span>
        ${personaInstance?.login}
    </div>

    <div class="fila-ventana">
        <span style="font-weight: bold">Nombre:</span>
        ${personaInstance?.nombre}
    </div>

    <div class="fila-ventana">
        <span style="font-weight: bold">Email:</span>
        ${personaInstance?.email}
    </div>

    <div class="fila-ventana">
        <span style="font-weight: bold">Cédula:</span>
        ${personaInstance?.cedula}
    </div>

    <div class="fila-ventana">
        <span style="font-weight: bold">Dirección:</span>
        ${personaInstance?.direccion}
    </div>

    <div class="fila-ventana">
        <span style="font-weight: bold">Teléfono:</span>
        ${personaInstance?.telefono}
    </div>

    <div class="fila-ventana">
        <span style="font-weight: bold">Celular:</span>
        ${personaInstance?.celular}
    </div>

    <div class="fila-ventana">
        <a href="#" class="btn btn-info btn-sm ver-mapa " longitud="${personaInstance.longitud}" latitud="${personaInstance.latitud}" nombre="${personaInstance.nombre}">
            <i class="fa fa-map"></i> Ver en el mapa
        </a>
    </div>
</div>
<script type="text/javascript">
    $(".ver-mapa").click(function () {
        showPin($(this).attr("latitud"), $(this).attr("longitud"), $(this).attr("nombre"))
    })
</script>
