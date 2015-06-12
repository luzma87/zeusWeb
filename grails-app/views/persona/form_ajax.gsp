<%@ page import="seguridad.Persona" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!personaInstance}">
    <elm:notFound elem="Persona" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmPersona" id="${personaInstance?.id}"
            role="form" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-7">
            <g:textField name="nombre" maxlength="100" class="form-control " value="${personaInstance?.nombre}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Login" claseField="col-sm-7">
            <g:textField name="login" maxlength="100" required="" class="form-control  required unique noEspacios" value="${personaInstance?.login}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cedula" claseField="col-sm-7">
            <g:textField name="cedula" maxlength="13" class="form-control " value="${personaInstance?.cedula}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Email" claseField="col-sm-7">
            <div class="input-group"><span class="input-group-addon"><i class="fa fa-envelope"></i></span><g:field type="email" name="email" maxlength="13" class="form-control  unique noEspacios" value="${personaInstance?.email}"/></div>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Password" claseField="col-sm-7">
            <g:textArea name="password" cols="40" rows="5" maxlength="255" class="form-control " value="${personaInstance?.password}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Direccion" claseField="col-sm-7">
            <g:textArea name="direccion" cols="40" rows="5" maxlength="500" class="form-control " value="${personaInstance?.direccion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Longitud" claseField="col-sm-3">
            <g:textField name="longitud" value="${fieldValue(bean: personaInstance, field: 'longitud')}" class="number form-control  "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Latitud" claseField="col-sm-3">
            <g:textField name="latitud" value="${fieldValue(bean: personaInstance, field: 'latitud')}" class="number form-control  "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Telefono" claseField="col-sm-7">
            <g:textField name="telefono" maxlength="13" class="form-control " value="${personaInstance?.telefono}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Celular" claseField="col-sm-7">
            <g:textField name="celular" maxlength="13" class="form-control " value="${personaInstance?.celular}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Creacion" claseField="col-sm-7">
            <g:textField name="creacion" maxlength="15" required="" class="form-control  required" value="${personaInstance?.creacion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Modificacion" claseField="col-sm-7">
            <g:textField name="modificacion" maxlength="15" required="" class="form-control  required" value="${personaInstance?.modificacion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Tipo" claseField="col-sm-7">
            <g:textField name="tipo" maxlength="1" class="form-control " value="${personaInstance?.tipo}"/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmPersona").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            }
            
            , rules          : {
                
                login: {
                    remote: {
                        url: "${createLink(controller:'persona', action: 'validar_unique_login_ajax')}",
                        type: "post",
                        data: {
                            id: "${personaInstance?.id}"
                        }
                    }
                },
                
                email: {
                    remote: {
                        url: "${createLink(controller:'persona', action: 'validar_unique_email_ajax')}",
                        type: "post",
                        data: {
                            id: "${personaInstance?.id}"
                        }
                    }
                }
                
            },
            messages : {
                
                login: {
                    remote: "Ya existe Login"
                },
                
                email: {
                    remote: "Ya existe Email"
                }
                
            }
            
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormPersona();
                return false;
            }
            return true;
        });
    </script>

</g:else>