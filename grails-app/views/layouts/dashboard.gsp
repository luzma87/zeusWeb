<%@ page import="arazu.alertas.Alerta" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title><g:layoutTitle default="Arazu"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <imp:favicon/>
        <imp:importJs/>
        <imp:plugins/>
        <imp:customJs/>

        <imp:spinners/>

        <imp:importCss/>

        <g:layoutHead/>

        <g:set var="alertSize" value="${50}"/>
        <g:set var="posTop" value="${200}"/>
        <g:set var="posRight" value="${16}"/>
        <g:set var="increase" value="${12}"/>
        <g:set var="handleHeight" value="${alertSize / 2}"/>
        <g:set var="handleWidth" value="${alertSize + (posRight * 3)}"/>
        <g:set var="handlePadding" value="${8}"/>

        <style type="text/css">
        body {
            overflow-x : hidden;
        }

        .circle-base {
            border-radius : 50%;
        }

        .circle-fg {
            box-sizing  : border-box;
            position    : absolute;
            top         : ${posTop}px;
            right       : ${posRight}px;

            width       : ${alertSize}px;
            height      : ${alertSize}px;

            font-size   : 15pt;
            font-weight : bold;
            text-align  : center;
            line-height : ${alertSize - 2}px;

            z-index     : 500;
        }

        .circle-bg {
            box-sizing : border-box;
            position   : absolute;
            top        : ${posTop - (increase / 2)}px;
            right      : ${posRight - (increase / 2)}px;
            width      : ${alertSize + increase}px;
            height     : ${alertSize + increase}px;
            z-index    : 499;
        }

        .circle-container {
            height         : 100%;
            width          : ${handleHeight - handlePadding }px;
            display        : inline-block;
            text-align     : center;
            vertical-align : middle;
            position       : relative;
            margin-top     : -4px;
        }

        .circle-icon {
            box-sizing  : border-box;
            width       : ${handleHeight - handlePadding - 2}px;
            height      : ${handleHeight - handlePadding - 2}px;
            text-align  : center;
            line-height : ${handleHeight - handlePadding - 4}px;
            font-size   : 8pt;
        }

        .handle {
            box-sizing                : border-box;
            position                  : absolute;
            top                       : ${posTop + (handleHeight / 2)}px;
            right                     : 0;

            width                     : ${handleWidth}px;
            height                    : ${handleHeight}px;

            border-bottom-left-radius : ${handleHeight / 2}px;
            border-top-left-radius    : ${handleHeight / 2}px;
            border-right              : transparent;

            padding                   : ${handlePadding / 2}px;

            z-index                   : 498;
        }

        .handle, .circle-bg, .circle-fg {
            cursor : pointer;
        }

        .content-alertas {
            width      : 95%;
            height     : 100%;
            display    : inline-block;
            display    : none;
            padding    : 5px;
            overflow-y : auto;
        }

        .titulo-alertas {
            margin-bottom : 5px;
            padding       : 5px;
            color         : #3A5DAA;

            font-weight   : bold;
        }

        .inicio img {
            height : 190px;
        }

        i {
            margin-right : 5px;
        }
        </style>

        <script type="text/javascript">
            var index = 1041;
            function bringToTop(element) {
                element.css({"zIndex" : index});
                index++;
            }
            function bringToTopCustom(element, zIndex) {
                element.css({"zIndex" : zIndex});
            }

            $(function () {
                var $circle = $(".circle");
                var $circleBg = $(".circle-bg");
                var $circleFg = $(".circle-fg");
                var $handle = $(".handle");

                var circleBgIni = ${posRight - (increase / 2)};
                var circleFgIni = ${posRight};
                var circleFin = -${alertSize + posRight};
                var handleIni = ${handleWidth};
                var handleFin = 550;
                var time = 600;

                $(".handle, .circle-bg, .circle-fg ").click(function () {
                    if ($circle.hasClass("showing")) {
                        $.ajax({
                            type    : "POST",
                            url     : "${g.createLink(controller: 'alerta',action: 'list_ajax')}",
                            data    : "",
                            success : function (msg) {
                                $(".content-alertas").html(msg)
                            },
                            error   : function () {
                                log("Ha ocurrido un error interno", "Error");
                                closeLoader();
                            }
                        });
                        $circle.removeClass("showing");
                        $(".content-alertas").css({display : " inline-block"})
                        $(".content-alertas").show();
                        $circleBg.animate({
                            right : circleFin
                        }, time, function () {
                            $circleBg.addClass("hidden");
                        });
                        $circleFg.animate({
                            right : circleFin
                        }, time, function () {
                            $circleFg.addClass("hidden");
                        });
                        $handle.animate({
                            width  : handleFin,
                            height : 300,
                            top    : 150
                        }, time, function () {

                        });
                        $handle.find(".circle-icon").addClass("fa-rotate-180")

                    } else {
                        $circle.addClass("showing");
                        $circleBg.removeClass("hidden");
                        $circleFg.removeClass("hidden");

                        $circleBg.animate({
                            right : circleBgIni
                        }, time);
                        $circleFg.animate({
                            right : circleFgIni
                        }, time);
                        $handle.animate({
                            width  : handleIni,
                            height : ${handleHeight},
                            top    : ${posTop + (handleHeight / 2)}
                        }, time, function () {
                            $(".content-alertas").hide()
                        });
                        $handle.find(".circle-icon").removeClass("fa-rotate-180")
                    }
                });
            });

        </script>
        <imp:css src="${g.resource(dir: 'css/custom/', file: 'dashboard.css')}"/>
    </head>

    <body style="">

    <!-- http://wrapbootstrap.com/preview/WB0P8S4X3 -->

    %{--<mn:bannerTop/>--}%
        <g:set var="alertas" value="${Alerta.cantAlertasPersonaPorTipo(session.usuario)}"/>
        <g:set var="clase" value="success"/>

        <g:if test="${alertas.total > 0}">
            <g:if test="${alertas.d2 > 0}">
                <g:set var="clase" value="warning"/>
            </g:if>
            <g:if test="${alertas.dmas > 0}">
                <g:set var="clase" value="danger"/>
            </g:if>
            <div class="handle svt-border-${clase}" style="background: #ffe7b5">
                <div class="circle-container">
                    <div class="circle-base circle-icon svt-bg-info svt-border-info">
                        <i class="fa fa-arrow-left"></i>
                    </div>
                </div>

                <div class="content-alertas"></div>
            </div>

            <div class="circle showing">
                <div class="circle-base circle-bg svt-bg-default svt-border-${clase}"></div>

                <div class="circle-base circle-fg svt-bg-${clase} svt-border-${clase}" id="divTotalAlertas">
                    ${alertas.total}
                </div>
            </div>
        </g:if>

        <mn:menu title="${g.layoutTitle(default: 'Arazu')}"/>

        <div class="container" id="mass-container" style="position: relative">
            <g:layoutBody/>
        </div>

        <mn:stickyFooter/>
    </body>
</html>
