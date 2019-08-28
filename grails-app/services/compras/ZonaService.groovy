package compras

import grails.gorm.services.Service

@Service(Zona)
interface ZonaService {

    Zona get(Serializable id)

    List<Zona> list(Map args)

    Long count()

    void delete(Serializable id)

    Zona save(Zona zona)

}