<% import grails.persistence.Event %>
<%=packageName%>

<g:if test="\${!${propertyName}}">
    <elm:notFound elem="${domainClass.propertyName.capitalize()}" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">
<%  excludedProps = Event.allEvents.toList() << 'id' << 'version' << 'password' << 'pass'
allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
props.eachWithIndex { p, i -> %>
        <g:if test="\${${propertyName}?.${p.name}}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    ${p.naturalName}
                </div>
                <%  if (p.isEnum()) { %>
                <div class="col-sm-4">
                    <g:fieldValue bean="\${${propertyName}}" field="${p.name}"/>
                </div>
                <%  } else if (p.oneToMany || p.manyToMany) { %>
                <div class="col-sm-4">
                    <ul>
                        <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                            <li>\${${p.name[0]}?.encodeAsHTML()}</li>
                        </g:each>
                    </ul>
                </div>
                <%  } else if (p.manyToOne || p.oneToOne) { %>
                <div class="col-sm-4">
                    \${${propertyName}?.${p.name}?.encodeAsHTML()}
                </div>
                <%  } else if (p.type == Boolean || p.type == boolean) { %>
                <div class="col-sm-4">
                    <g:formatBoolean boolean="\${${propertyName}?.${p.name}}" true="Sí" false="No" />
                </div>
                <%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
                <div class="col-sm-4">
                    <g:formatDate date="\${${propertyName}?.${p.name}}" format="dd-MM-yyyy" />
                </div>
                <%  } else if(!p.type.isArray()) { %>
                <div class="col-sm-4">
                    <g:fieldValue bean="\${${propertyName}}" field="${p.name}"/>
                </div>
                <%  } %>
            </div>
        </g:if>
    <%  } %>
    </div>
</g:else>