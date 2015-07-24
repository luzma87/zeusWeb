<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <imp:js src="${g.resource(dir: 'js', file: 'markerwithlabel.js')}"/>
        <imp:js src="${g.resource(dir: 'js/plugins/jquery.xcolor', file: 'jquery.xcolor.min.js')}"/>
        <imp:js src="${g.resource(dir: 'js/plugins/ion.sound-3.0.4', file: 'ion.sound.min.js')}"/>
        <imp:js src="${g.resource(dir: 'js/plugins/OverlappingMarkerSpiderfier/js', file: 'oms.min.js')}"/>

        <imp:css src="${g.resource(dir: 'css/chat', file: 'chat.css')}"/>
        <imp:js src="${g.resource(dir: 'js/chat', file: 'mapSetup.js')}"/>

        <title>Chat comunitario</title>
    </head>

    <body>
        <g:render template="/chatTemplate/chat" model="[botones: botones, user: user, folder: folder,
                                                        persona: persona, policia: true, control: 'chat']"/>
    </body>
</html>