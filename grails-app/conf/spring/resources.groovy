// Place your Spring DSL code here
import org.springframework.aop.scope.ScopedProxyFactoryBean

beans = {
    cartServiceProxy(ScopedProxyFactoryBean) {
        targetBeanName = 'messageHandlerService'
        proxyTargetClass = true
    }
    cartServiceProxy(ScopedProxyFactoryBean) {
        targetBeanName = 'messageHandlerServicePoliciaService'
        proxyTargetClass = true
    }
}
