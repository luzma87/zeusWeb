package arazu

class ImportsTagLib {
//    static defaultEncodeAs = 'html'
//    static encodeAsForTags = [tagName: 'raw']
    static namespace = 'imp'

    /**
     * Tag para facilitar la importación de hojas de estilos
     */
    def css = { attrs ->
        def href = attrs.href
        if (!href) {
            href = attrs.src
        }
        out << "<link href=\"${href}\" rel=\"stylesheet\">"
    }

    /**
     * Tag para facilitar la importación de archivos javascript
     */
    def js = { attrs ->
        def href = attrs.href
        if (!href) {
            href = attrs.src
        }
        out << "<script src=\"${href}\"></script>\n"
    }

    /**
     * Tag para facilitar la importación de imagenes
     */
    def image = { attrs ->
        def writer = out
        def href = attrs.href
        if (!href) {
            href = attrs.src
        }

        writer << "<img src='${href}'"
        outputAttributes(attrs, writer, true)
        writer << "/>"
        writer.println()
    }

    /**
     * imports para los favicons
     */
    def favicon = { attrs ->
        /*
        <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="60x60" href="/apple-touch-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="120x120" href="/apple-touch-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="76x76" href="/apple-touch-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="152x152" href="/apple-touch-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon-180x180.png">
        <meta name="apple-mobile-web-app-title" content="arazu">
        <link rel="icon" type="image/png" href="/favicon-192x192.png" sizes="192x192">
        <link rel="icon" type="image/png" href="/favicon-160x160.png" sizes="160x160">
        <link rel="icon" type="image/png" href="/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="/favicon-16x16.png" sizes="16x16">
        <link rel="icon" type="image/png" href="/favicon-32x32.png" sizes="32x32">
        <meta name="msapplication-TileColor" content="#1f3a78">
        <meta name="msapplication-TileImage" content="/mstile-144x144.png">
        <meta name="application-name" content="arazu">
         */
        def favicons = ""

        favicons += "<link rel='apple-touch-icon' sizes='57x57' href='${resource(dir: 'images/favicons', file: 'apple-touch-icon-57x57.png')}'>"
        favicons += "<link rel='apple-touch-icon' sizes='114x114' href='${resource(dir: 'images/favicons', file: 'apple-touch-icon-114x114.png')}'>"
        favicons += "<link rel='apple-touch-icon' sizes='72x72' href='${resource(dir: 'images/favicons', file: 'apple-touch-icon-72x72.png')}'>"
        favicons += "<link rel='apple-touch-icon' sizes='144x144' href='${resource(dir: 'images/favicons', file: 'apple-touch-icon-144x144.png')}'>"
        favicons += "<link rel='apple-touch-icon' sizes='60x60' href='${resource(dir: 'images/favicons', file: 'apple-touch-icon-60x60.png')}'>"
        favicons += "<link rel='apple-touch-icon' sizes='120x120' href='${resource(dir: 'images/favicons', file: 'apple-touch-icon-120x120.png')}'>"
        favicons += "<link rel='apple-touch-icon' sizes='76x76' href='${resource(dir: 'images/favicons', file: 'apple-touch-icon-76x76.png')}'>"
        favicons += "<link rel='apple-touch-icon' sizes='152x152' href='${resource(dir: 'images/favicons', file: 'apple-touch-icon-152x152.png')}'>"
        favicons += "<link rel='apple-touch-icon' sizes='180x180' href='${resource(dir: 'images/favicons', file: 'apple-touch-icon-180x180.png')}'>"
        favicons += "<meta name='apple-mobile-web-app-title' content='arazu'>"
        favicons += "<link rel='icon' type='image/png' href='${resource(dir: 'images/favicons', file: 'favicon-192x192.png')}' sizes='192x192'>"
        favicons += "<link rel='icon' type='image/png' href='${resource(dir: 'images/favicons', file: 'favicon-160x160.png')}' sizes='160x160'>"
        favicons += "<link rel='icon' type='image/png' href='${resource(dir: 'images/favicons', file: 'favicon-96x96.png')}' sizes='96x96'>"
        favicons += "<link rel='icon' type='image/png' href='${resource(dir: 'images/favicons', file: 'favicon-16x16.png')}' sizes='16x16'>"
        favicons += "<link rel='icon' type='image/png' href='${resource(dir: 'images/favicons', file: 'favicon-32x32.png')}' sizes='32x32'>"
        favicons += "<meta name='msapplication-TileColor' content='#1f3a78'>"
        favicons += "<meta name='msapplication-TileImage' content='${resource(dir: 'images/favicons', file: 'mstile-144x144.png')}'>"
        favicons += "<meta name='application-name' content='HINSA'>"

        out << favicons
    }

    /**
     * imports de hojas de estilo CSS
     */
    def importCss = { attrs ->
        def bootstrapTheme = attrs.bootstrap ?: "theme"

        //Bootstrap
        def text = imp.css(src: resource(dir: 'bootstrap-3.3.4/dist/css', file: 'bootstrap.min.css'))
        text += imp.css(src: resource(dir: 'bootstrap-3.3.4/dist/css', file: 'bootstrap-' + bootstrapTheme + '.min.css'))
        // JQuery
        text += imp.css(src: resource(dir: 'js/jquery-ui-1.11.2', file: 'jquery-ui.min.css'))
        text += imp.css(src: resource(dir: 'js/jquery-ui-1.11.2', file: 'jquery-ui.structure.min.css'))
        text += imp.css(src: resource(dir: 'js/jquery-ui-1.11.2', file: 'jquery-ui.theme.min.css'))
        // MFizz
        text += imp.css(src: resource(dir: 'fonts/font-mfizz-1.2', file: 'font-mfizz.css'))
        // Flaticons construction
        text += imp.css(src: resource(dir: 'fonts/flaticons-construction', file: 'flaticon.css'))
        // FontAwesome
        text += imp.css(src: resource(dir: 'fonts/font-awesome-4.3.0/css', file: 'font-awesome.min.css'))

        //CUSTOM
        text += imp.css(src: resource(dir: 'css/custom', file: 'custom.css'))
        text += imp.css(src: resource(dir: 'css/custom', file: 'modals.css'))
        text += imp.css(src: resource(dir: 'css/custom', file: 'tablas.css'))
        text += imp.css(src: resource(dir: 'css/custom', file: 'inputs.css'))
        text += imp.css(src: resource(dir: 'css/custom', file: 'texto.css'))
        text += imp.css(src: resource(dir: 'css/custom', file: 'texto-vertical.css'))

        //Banner
        text += imp.css(src: resource(dir: 'css/custom', file: 'banner.css'))
        //Sticky footer
        text += imp.css(src: resource(dir: 'css/custom', file: 'sticky-footer.css'))

        out << text
    }

    /**
     * imports de librerías javascript
     */
    def importJs = { attrs ->
        // jQuery (necessary for Bootstrap's JavaScript plugins)
        def text = imp.js(src: resource(dir: 'js/jquery-ui-1.11.2/external/jquery', file: 'jquery.js'))
        text += imp.js(src: resource(dir: 'js/jquery-ui-1.11.2/', file: 'jquery-ui.min.js'))
        // Include all compiled plugins (below), or include individual files as needed
        text += imp.js(src: resource(dir: 'bootstrap-3.3.4/dist/js', file: 'bootstrap.min.js'))

        out << text
    }

    /**
     * imports de librerías personlizadas javascript
     */
    def customJs = { attrs ->
        def text = imp.js(src: resource(dir: 'js', file: 'funciones.js'))
        text += imp.js(src: resource(dir: 'js', file: 'functions.js'))
        text += imp.js(src: resource(dir: 'js', file: 'ui.js'))
        out << text
    }

    /**
     * imports para el plugin de validacion
     */
    def validation = { attrs ->
        //context js
        def text = imp.js(src: resource(dir: 'js/plugins/jquery-validation-1.13.1/dist/', file: 'jquery.validate.min.js'))
        text += imp.js(src: resource(dir: 'js/plugins/jquery-validation-1.13.1/dist/localization', file: 'messages_es.min.js'))
        text += imp.js(src: resource(dir: 'js', file: 'jquery.validate.custom.lzm.js'))

        out << text
    }

    /**
     * imports de los plugins
     */
    def plugins = { attrs ->
        //bootbox
        def text = imp.js(src: resource(dir: 'js/plugins/bootbox-4.3.0/js', file: 'bootbox.js'))
        ///datepicker
        text += imp.js(src: resource(dir: 'js/plugins/moment-2.8.4.js', file: 'moment-with-locales.js'))
        text += imp.js(src: resource(dir: 'js/plugins/bootstrap-datetimepicker-3.1.3/build/js', file: 'bootstrap-datetimepicker.min.js'))
        text += imp.css(src: resource(dir: 'js/plugins/bootstrap-datetimepicker-3.1.3/build/css', file: 'bootstrap-datetimepicker.min.css'))
        text += imp.css(src: resource(dir: 'css/custom/', file: 'datepicker.css'))

        //maxlength
        text += imp.js(src: resource(dir: 'js/plugins/bootstrap-maxlength/js', file: 'bootstrap-maxlength.min.js'))

        //countdown
//        text += "    <script src=\"${resource(dir: 'js/plugins/jquery-countdown-2.0.1', file: 'jquery.countdown.js')}\"></script>"
//        text += "    <script src=\"${resource(dir: 'js/plugins/jquery-countdown-2.0.1', file: 'jquery.countdown-es.js')}\"></script>"

        //qtip2
        text += imp.js(src: resource(dir: 'js/plugins/jquery-qtip-2.2.1', file: 'jquery.qtip.min.js'))
        text += imp.css(src: resource(dir: 'js/plugins/jquery-qtip-2.2.1', file: 'jquery.qtip.min.css'))

        //pines notify
        text += imp.js(src: resource(dir: 'js/plugins/jquery-pnotify-2.0', file: 'pnotify.custom.min.js'))
        text += imp.css(src: resource(dir: 'js/plugins/jquery-pnotify-2.0', file: 'pnotify.custom.min.css'))

        //typeahead
        text += imp.js(src: resource(dir: 'js/plugins/jquery-typeahead-0.10.5', file: 'typeahead.js'))
        text += imp.css(src: resource(dir: 'js/plugins/jquery-typeahead-0.10.5', file: 'lzm-typeahead.css'))

        //context js
        text += imp.js(src: resource(dir: 'js/plugins/lzm.context/js', file: 'lzm.context-0.5.js'))
        text += imp.css(src: resource(dir: 'js/plugins/lzm.context/css', file: 'lzm.context-0.5.css'))

        //validation
        text += imp.validation()

        //switches
//        text += imp.js(src: resource(dir: 'js/plugins/bootstrap-switch-3/dist/js', file: 'bootstrap-switch.js'))
//        text += imp.css(src: resource(dir: 'js/plugins/bootstrap-switch-3/dist/css/bootstrap3', file: 'bootstrap-switch.css'))

        //para el formato de los numeros en los inputs
        text += imp.js(src: resource(dir: 'js/plugins/jquery-inputmask-3.1.49/dist', file: 'jquery.inputmask.bundle.min.js'))

        text += imp.js(src: resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js', file: 'bootstrap-select.min.js'))
        text += imp.js(src: resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js/i18n', file: 'defaults-es_CL.js'))
        text += imp.css(src: resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/css', file: 'bootstrap-select.min.css'))

        out << text
    }

    /**
     * creación de los spinners
     */
    def spinners = {
        def text = "<script type=\"text/javascript\">\n" +
                "            var spinner24Url = \"${resource(dir: 'images/spinners', file: 'spinner_24.GIF')}\";\n" +
                "            var spinner64Url = \"${resource(dir: 'images/spinners', file: 'spinner_64.GIF')}\";\n" +
                "\n" +
                "            var spinnerSquare64Url = \"${resource(dir: 'images/spinners', file: 'loading_new.GIF')}\";\n" +
                "\n" +
                "            var spinner = \$(\"<img src='\" + spinner24Url + \"' alt='Cargando...'/>\");\n" +
                "            var spinner64 = \$(\"<img src='\" + spinner64Url + \"' alt='Cargando...'/>\");\n" +
                "            var spinnerSquare64 = \$(\"<img src='\" + spinnerSquare64Url + \"' alt='Cargando...'/>\");\n" +
                "        </script>"
        out << text
    }

    /* ************************************************************** FUNCIONES ***********************************************************/
    /**
     * Dump out attributes in HTML compliant fashion.
     */
    void outputAttributes(attrs, writer, boolean useNameAsIdIfIdDoesNotExist = false) {
        attrs.remove('tagName') // Just in case one is left
        attrs.each { k, v ->
            writer << k
            writer << '="'
            writer << v.encodeAsHTML()
            writer << '" '
        }
        if (useNameAsIdIfIdDoesNotExist) {
            outputNameAsIdIfIdDoesNotExist(attrs, writer)
        }
    }

    private outputNameAsIdIfIdDoesNotExist(attrs, out) {
        if (!attrs.containsKey('id') && attrs.containsKey('name')) {
            out << 'id="'
            out << attrs.name?.encodeAsHTML()
            out << '" '
        }
    }
}
