<!DOCTYPE html>
<head>
    <title><g:layoutTitle default="Zeus"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <imp:favicon/>
    <imp:importJs/>
    <imp:plugins/>
    <imp:customJs/>
    <imp:spinners/>
    <imp:importCss/>
    <g:layoutHead/>
</head>

<body>
    <mn:verticalMenu/>

    <div class="contenido">
        <mn:barraTop titulo="${g.layoutTitle(default: 'Zeus')}"/>

        <g:layoutBody/>
    </div>
    <script type="text/javascript">
        var estadoMenu = 1;
        $("#control-menu").click(function () {
            $(".toggle-menu").toggle();
            if (estadoMenu == 1) {
                $(".submenu").hide();
                $(".menu").animate({
                    width : 55
                });
                $(".contenido").animate({
                    marginLeft : "55"
                });
                estadoMenu = 0;
            } else {
                $(".menu").animate({
                    width : 190
                });
                $(".contenido").animate({
                    marginLeft : "190"
                });
                estadoMenu = 1;
            }
            return false;
        });
        $(".dropdown-toggle").click(function () {
            if (estadoMenu == 1)
                $(this).parent().find(".submenu").toggle();
            else {
                $("#control-menu").click();
                $(this).parent().find(".submenu").toggle()
            }
            return false;
        })
    </script>
</body>
</html>
