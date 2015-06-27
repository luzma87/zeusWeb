class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?" {
            constraints {
                // apply constraints here
            }
        }
        "/"(controller: "inicio", action: "index")

        "401"(controller: 'shield', action: 'unauthorized_401')
        "404"(controller: 'shield', action: 'notFound_404')
        "403"(controller: 'shield', action: 'forbidden_403')
        "500"(controller: 'shield', action: 'internalServerError_500')
    }
}
