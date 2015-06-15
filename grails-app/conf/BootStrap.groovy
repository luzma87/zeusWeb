import org.codehaus.groovy.grails.commons.ApplicationAttributes

class BootStrap {

    def init = { servletContext ->

        def ctx=servletContext.getAttribute(
                ApplicationAttributes.APPLICATION_CONTEXT)
        def dataSource = ctx.dataSourceUnproxied
//        println "datasource "+dataSource

        dataSource.setMinEvictableIdleTimeMillis(1000 * 60 * 10)
        dataSource.setTimeBetweenEvictionRunsMillis(1000 * 60 * 10)
        dataSource.setNumTestsPerEvictionRun(3)

        dataSource.setTestOnBorrow(true)
        dataSource.setTestWhileIdle(false)
        dataSource.setTestOnReturn(true)
        dataSource.setValidationQuery("SELECT 1")
        println "propiedades ----------------------------- "
        dataSource.properties.each { println it }
    }
    def destroy = {
    }
}
