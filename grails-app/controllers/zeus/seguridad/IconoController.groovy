package arazu.seguridad

class IconoController {

    /**
     * Acción llamada con ajax que muestra los iconos disponibles para acciones y módulos
     */
    def dlgIconos_ajax() {
        def flaticons = [], fontawesome = [], mfizz = []

        def path = servletContext.getRealPath("/") + "fonts/"    //web-app/fonts

        def flaticonsPath = path + "flaticons-construction/flaticon.css"
        def fontawesomePath = path + "font-awesome-4.3.0/css/font-awesome.css"
        def mfizzPath = path + "font-mfizz-1.2/font-mfizz.css"

        def flaticonsFile = new File(flaticonsPath)
        def fontawesomeFile = new File(fontawesomePath)
        def mfizzFile = new File(mfizzPath)

        flaticonsFile.eachLine { ln ->
            if (ln.startsWith(".flaticon") && ln.contains("before")) {
                def parts = ln.split(":")
                if (!flaticons.contains(parts[0]))
                    flaticons += parts[0].replaceFirst("\\.", "")
            }
        }
        fontawesomeFile.eachLine { ln ->
            if (ln.startsWith(".fa") && ln.contains("before")) {
                def parts = ln.split(":")
                if (!fontawesome.contains(parts[0]))
                    fontawesome += "fa " + parts[0].replaceFirst("\\.", "")
            }
        }
        mfizzFile.eachLine { ln ->
            if (ln.startsWith(".icon") && ln.contains("before")) {
                def parts = ln.split(":")
                if (!mfizz.contains(parts[0]))
                    mfizz += parts[0].replaceFirst("\\.", "")
            }
        }
        return [icons: flaticons + fontawesome + mfizz, params: params]
    }
}
