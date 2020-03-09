package utilitarios

import org.apache.poi.xssf.usermodel.XSSFCell
import org.apache.poi.xssf.usermodel.XSSFRow
import org.apache.poi.xssf.usermodel.XSSFSheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.springframework.dao.DataIntegrityViolationException
import seguridad.ParametrosAux

//import jxl.Cell
//import jxl.Sheet
//import jxl.Workbook
//import jxl.WorkbookSettings
import java.text.DecimalFormat


class ParametrosController {
    def dbConnectionService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond parametrosService.list(params), model: [parametrosCount: parametrosService.count()]
    }

    def list() {

    }

    def formIva_ajax() {

    }

    def guardarIva_ajax() {
//        println("params gi " + params)

        def parametros = ParametrosAux.findByIdIsNotNull()
        parametros.iva = params.iva.toDouble()

        if (!parametros.save(flush: true)) {
            println("error al guardar el iva en parametros aux" + parametros.errors)
            render "no"
        } else {
            render "ok"
        }
    }


    def cargarDatos() {
        def cn = dbConnectionService.getConnectionVisor()
        def sql = ""
        def data = []

//        sql = "select magn__id, magnnmbr||'('||magnabrv||')' nombre from magn order by magnnmbr"
        sql = "select id magn__id, pname||'('||abbreviation||')' nombre from survey.magnitude order by pname"
        data = cn.rows(sql.toString())

        [magnitud: data]

    }

    def validar() {
        println "cargaArchivo.. $params"
        def contador = 0
        def cn = dbConnectionService.getConnectionVisor()
        def path = servletContext.getRealPath("/") + "xlsData/"   //web-app/archivos
        new File(path).mkdirs()

        def estc
        def vrbl = params.magnitud
        def cont = 0
        def repetidos = 0
        def inserta

        def f = request.getFile('file')  //archivo = name del input type file
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            def parts = fileName.split("\\.")
            println("parts " + parts)
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            def htmlInfo = "", errores = "", doneHtml = ""
            def cntanmro = 0
            def cntadscr = 0


            // archivos excel xls
            if (ext == 'xls') {

                def str = "<h3>Formato de archivo incorrecto</h3>"

                flash.message = "Seleccione un archivo Excel con extensión xlsx para ser procesado"
                redirect(action: 'cargarDatos', params: [html: str])


            } else if (ext == 'xlsx') {

                println("entro xlsx")

                params.tipoTabla = "Datos"

                fileName = params.tipoTabla
                def fn = fileName
                fileName = fileName + "." + ext

                def pathFile = path + fileName
                def src = new File(pathFile)

                def ij = 1
                while (src.exists()) {
                    pathFile = path + fn + "_" + ij + "." + ext
                    src = new File(pathFile)
                    ij++
                }

//                println "---- $pathFile"

//                f.transferTo(new File(pathFile))

//                InputStream ExcelFileToRead = new FileInputStream(pathFile);
                InputStream ExcelFileToRead = new FileInputStream('/home/fabricio/SO2.xlsx');
                XSSFWorkbook wb = new XSSFWorkbook(ExcelFileToRead);

                XSSFSheet sheet = wb.getSheetAt(0);
                XSSFRow row;
                XSSFCell cell;

                Iterator rows = sheet.rowIterator();

                while (rows.hasNext()) {
                    row = (XSSFRow) rows.next()
                    Iterator cells = row.cellIterator()
//                    def rgst = cells.toList()
                    def rgst = []
                    while (cells.hasNext()) {
                        cell = (XSSFCell) cells.next()
//                        println "cell: $cell tipo: --> ${cell.getCellType()}"

                        if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
                            if (cell.toString().contains('-')) {
                                rgst.add(cell.getDateCellValue())
                            } else
//                            rgst.add( new DecimalFormat('#.##').format(cell.getNumericCellValue()))
                                rgst.add(cell.getNumericCellValue())
                        } else {
                            rgst.add(cell.getStringCellValue())
                        }
                    }

                    if (rgst[0] == "FECHA") {
                        estc = datosEstaciones(rgst)
                        println "estaciones: $estc"
                    } else if (rgst[0]) {
                        println "---> Registro: $rgst"
                        inserta = cargarLecturas(vrbl, estc, rgst)
                        cont += inserta.insertados
                        repetidos += inserta.repetidos
                    }


//                    def cont = 0
//                    while (cells.hasNext()) {
//                        cells.next()
//                        cont++
//                    }
//                    println("cont " + cont)
//                    if (cont == 14) {
//                        println("cell " + row.getCell(1) + "")
//                    }

                } //sheet ! hidden
//                println "...$errores"
//                println "...$contador"
                flash.message = "Se ha cargado ${cont} datos, y han existido ${repetidos} valores repetidos"

                def str = htmlInfo
                str += doneHtml
                if (errores != "") {
                    str += "<h3>Errores al cargar el archivo de datos</h3>"
                    str += "<ol>" + errores + "</ol>"
                }

//                println "fin....."
                redirect(action: 'cargarDatos', params: [html: str])


            } else {
                flash.message = "Seleccione un archivo Excel con extensión xlsx para ser procesado"
                redirect(action: 'cargarDatos')
            }
        } else {
            flash.message = "Seleccione un archivo para procesar"
            redirect(action: 'cargarDatos')
        }
    }

    def leeCSV() {
        println ">>leeCSV.. *${params}*"
        def tipo = params.tipo
        def contador = 0
        def cn = dbConnectionService.getConnectionVisor()
        def estc
        def vrbl = params.magnitud
        def rgst = []
        def cont = 0
        def repetidos = 0
        def procesa = 5
        def crea_log = false
        def inserta
        def fcha
        def magn
        def sqlp


        def f = request.getFile('file')  //archivo = name del input type file
        def archivo = f.getOriginalFilename()
//        def directorio = '/home/guido/proyectos/visor/data/'
        def directorio = '/home/guido/proyectos/visor/datos/'
        if (tipo == 'Prueba') {  //botón: Prueba Minutos
            directorio = '/home/guido/proyectos/visor/data/'
            procesa = 5
/*
            def nmbr = ""
            def arch = ""
            def mg = ""
            new File(directorio).traverse(type: groovy.io.FileType.FILES, nameFilter: ~/.*\.csv/) { ar ->
                nmbr = ar.toString() - directorio
                arch = nmbr.substring(nmbr.lastIndexOf("/") + 1)
                mg = arch.split('_')[0]
                magn = buscaMagn(mg)

                println "${nmbr} --> ${arch} --> ${mg} --> magn: $magn"

                */
/*** procesa las 5 primeras líneas del archivo  **//*

                def line
                def cuenta = 0
                ar.withReader('UTF-8') { reader ->
                    while ((line = reader.readLine()) != null) {
                        if (cuenta < 5) {
                            println "${line}"

                            line = line.replace(",", ".")
                            rgst = line.split(';')
                            rgst = rgst*.trim()

                            println "***** $rgst, --> ${rgst[0].toString().toLowerCase()}"

                            if (cuenta == 0) {
                                estc = datosEstaciones(rgst)
                                println "estaciones: $estc"
                            } else if (rgst[0] && rgst[0] != 'Date') {
//                            println "\n cuenta: $cuenta, fecha: ${rgst[0]}"
                                fcha = new Date().parse('dd-MMM-yyyy HH:mm', rgst[0])
                                rgst[0] = fcha
                                println "---> Registro: $rgst"
                                inserta = cargarLecturas(magn, estc, rgst, tipo)
                                cont += inserta.insertados
                                repetidos += inserta.repetidos
                            }
                            cuenta++

                        }
                    }
                }
                println "---> archivo: ${ar.toString()} --> cont: $cont, repetidos: $repetidos"
            }
*/
//            flash.message = "Se han cargado ${contador} líneas de datos y ham existido : <<${repetidos}>> repetidos"
//            redirect(action: 'cargarDatos')
//            return
        }

        if (tipo == 'Minuto') { //botón: Cargar datos Minutos
            directorio = '/home/guido/proyectos/visor/data/'
            procesa = 100000000000
            crea_log = true
//            procesa = 10000
        }

        def nmbr = ""
        def arch = ""
        def mg = ""
        new File(directorio).traverse(type: groovy.io.FileType.FILES, nameFilter: ~/.*\.csv/) { ar ->
            nmbr = ar.toString() - directorio
            arch = nmbr.substring(nmbr.lastIndexOf("/") + 1)
            mg = arch.split('_')[0]
            magn = buscaMagn(mg)
//            print "Procesa el archivo: $ar"
//            println "${nmbr} --> ${arch} --> ${mg} --> magn: $magn"

            /*** procesa las 5 primeras líneas del archivo  **/
            def line
            def cuenta = 0
            cont = 0
            repetidos = 0
            ar.withReader('UTF-8') { reader ->
                sqlp = "select count(*) cnta from survey.file where name ilike '${arch}'"
//                println "... $sqlp"
                def procesado = cn.rows(sqlp.toString())[0].cnta

                if (!procesado) {
//                    println "Cargando datos desde: $arch"
                    print "Cargando datos desde: $ar "
                    while ((line = reader.readLine()) != null) {
                        if (cuenta < procesa) {
//                        println "${line}"

                            line = line.replace(",", ".")
                            rgst = line.split(';')
                            rgst = rgst*.trim()

//                        println "***** $rgst, --> ${rgst[0].toString().toLowerCase()}"

                            if (cuenta == 0) {
                                estc = datosEstaciones(rgst)
//                            println "estaciones: $estc"
                            } else if (rgst[0] && rgst[0] != 'Date') {
//                            println "\n cuenta: $cuenta, fecha: ${rgst[0]}"
                                fcha = new Date().parse('dd-MMM-yyyy HH:mm', rgst[0])
                                rgst[0] = fcha
//                            println "---> Registro: $rgst"

                                inserta = cargarLecturas(magn, estc, rgst, tipo)
                                cont += inserta.insertados
                                repetidos += inserta.repetidos
                            }
                            cuenta++

                        }
                    }
//                if(true) {
                    if (crea_log) {
//                    println "--- file: ${arch}"
                        archivoSubido(arch, cont, repetidos)
                    }
                    println "--> cont: $cont, repetidos: $repetidos"

                }

            }
//            println "---> archivo: ${ar.toString()} --> cont: $cont, repetidos: $repetidos"
        }


        /***********************/
/*
        def baseDir = new File(directorio)
        def arch_csv = baseDir.listFiles()
        def txto
//        println "inicia el proceso.."
        arch_csv.each() { ar ->
            txto = ar.toString() - directorio
            magn = buscaMagn(txto[0..-5])
            contador = 0
//            println "archivo csv $ar --> $magn"

            if (ar.toString().toLowerCase().contains('.csv') && magn) {
                print "Procesa el archivo: $ar"
//            File arch = new File('/home/guido/proyectos/visor/datos/' + archivo)
                File arch = new File(ar.toString())
                arch.eachLine { ln ->
                    rgst = ln.split(';')
                    rgst = rgst*.trim()

//                    println "***** $rgst, --> ${rgst[0].toString().toLowerCase()}"

                    if (contador == 0) {
                        estc = datosEstaciones(rgst)
//                        println "estaciones: $estc"
                    } else if (rgst[0] && rgst[0] != 'Date') {
//                        println "\n contador: $contador, fecha: ${rgst[0]}"
                        fcha = new Date().parse('dd-MMM-yyyy HH:mm', rgst[0])
                        rgst[0] = fcha
//                        println "---> Registro: $rgst"

                        inserta = cargarLecturas(magn, estc, rgst, tipo)

                        cont += inserta.insertados
                        repetidos += inserta.repetidos
                    }

                    contador++
                }
                println " --> $contador líneas"
            }
        }

//        println "archivo: ${f.getOriginalFilename()}"
*/

        flash.message = "Se han cargado ${cont} líneas de datos y ham existido : <<${repetidos}>> repetidos"
        redirect(action: 'cargarDatos')

    }


    def cargaIUV() {
//        println ">>cargaIUV.. *${params}*"
        def contador = 0
        def cn = dbConnectionService.getConnectionVisor()
        def vrbl = params.magnitud
        def rgst = []
        def cont = 0
        def repetidos = 0
        def procesa = 5
        def crea_log = false
        def inserta
        def fcha
        def magn
        def sqlp

        def directorio = '/home/guido/proyectos/visor/dataIUV/'
//        procesa = 3
        procesa = 100000000
        crea_log = true

        def nmbr = ""
        def arch = ""
        def mg = ""
        new File(directorio).traverse(type: groovy.io.FileType.FILES, nameFilter: ~/.*\.csv/) { ar ->
            nmbr = ar.toString() - directorio
            arch = nmbr.substring(nmbr.lastIndexOf("/") + 1)

            /*** procesa las 5 primeras líneas del archivo  **/
            def line
            def cuenta = 0
            cont = 0
            repetidos = 0
            ar.withReader('UTF-8') { reader ->
                sqlp = "select count(*) cnta from survey.file where name ilike '${arch}'"
//                println "... $sqlp"
                def procesado = cn.rows(sqlp.toString())[0].cnta

                if (!procesado) {
//                    println "Cargando datos desde: $arch"
                    print "Cargando datos desde: $ar "
                    while ((line = reader.readLine()) != null) {
                        if (cuenta < procesa) {
//                        println "${line}"

//                            line = line.replace(",", ".")
                            rgst = line.split(';')
                            rgst = rgst*.trim()

//                        println "***** $rgst, --> ${rgst[0].toString().toLowerCase()}"

                            if (cuenta == 0) {
                                mg = rgst[1..-1]
                                magn = buscaMagnIUV(mg)
//                                println ">>>> ${nmbr} --> ${arch} --> ${mg} --> magn: $magn"

                            } else if (rgst[0] && rgst[0] != 'FECHA') {
//                            println "\n cuenta: $cuenta, fecha: ${rgst[0]}"
                                fcha = new Date().parse('yyyy-MM-dd HH:mm:ss', rgst[0])
                                rgst[0] = fcha
//                            println "---> Registro: $rgst"

                                inserta = cargarLectIUV(rgst, magn)
                                cont += inserta.insertados
                                repetidos += inserta.repetidos
                            }
                            cuenta++

                        }
                    }
//                if(true) {
                    if (crea_log) {
//                    println "--- file: ${arch}"
                        archivoSubido(arch, cont, repetidos)
                    }
                    println "--> cont: $cont, repetidos: $repetidos"

                }

            }
//            println "---> archivo: ${ar.toString()} --> cont: $cont, repetidos: $repetidos"
        }

        flash.message = "Se han cargado ${cont} líneas de datos y ham existido : <<${repetidos}>> repetidos"
        render "ok"
    }



    def cargarLecturas(vrbl, estc, rgst, tipo) {
        def errores = ""
        def cnta = 0
        def insertados = 0
        def repetidos = 0
        def fcha
        def cn = dbConnectionService.getConnectionVisor()
        def sql = ""
        def tbla = "survey.data"

//        println "\n inicia cargado de datos para mag: $vrbl, .... $rgst"
        fcha = rgst[0]
        rgst.removeAt(0)  // elimina la fecha y quedan solo lecturas

        cnta = 0
        rgst.each() { rg ->
//            println "--> estación: ${estc[cnta]}, valor: $rg, tipo: ${rg.class}, ${rg.size()}"
            if (rg.toString().size() > 0) {
//                println "--> estación: ${estc[cnta]}, valor: $rg"
/*
                sql = "insert into ${tbla}(id, magnitude_id, opoint_id, datatype_id, datetime, avg1m) " +
                        "values(default, ${vrbl}, ${estc[cnta]}, 1, '${fcha.format('yyyy-MM-dd HH:mm')}', ${rg.toDouble()})"
*/
                sql = "insert into ${tbla}(id, magnitude_id, opoint_id, datatype_id, datetime, avg1m) " +
                        "values(default, ${vrbl}, ${estc[cnta]}, 1, '${fcha.format('yyyy-MM-dd HH:mm')}', ${rg.toDouble()}) " +
                        "on conflict (magnitude_id, opoint_id, datetime, datatype_id) " +
                        "do update set avg1m = ${rg.toDouble()}"
//                println "sql: $sql"
                try {
//                    println "inserta: $inserta"
                    cn.execute(sql.toString())
                    if (cn.updateCount > 0) {
                        insertados++
                    }
                } catch (Exception ex) {
                    repetidos++
//                    println "Error al insertar $ex"
                }

            }
            cnta++
        }

        return [errores: errores, insertados: insertados, repetidos: repetidos]
    }

    def cargarLectIUV(rgst, magn) {
        def errores = ""
        def cnta = 0
        def insertados = 0
        def repetidos = 0
        def fcha
        def cn = dbConnectionService.getConnectionVisor()
        def sql = ""

//        println "\n inicia cargado de datos para mag: $vrbl, .... $rgst"
        fcha = rgst[0]
        rgst.removeAt(0)  // elimina la fecha y quedan solo lecturas

        cnta = 0
        rgst.each() { rg ->
//            println "--> estación: ${estc[cnta]}, valor: $rg, tipo: ${rg.class}, ${rg.size()}"
            if (rg.toString().size() > 0) {
//                println "--> estación: ${estc[cnta]}, valor: $rg"
                sql = "insert into survey.data (id, magnitude_id, opoint_id, datatype_id, datetime, avg1m) " +
                        "values(default, ${magn[cnta]}, 4, 1, '${fcha.format('yyyy-MM-dd HH:mm')}', ${rg.toDouble()}) " +
                        "on conflict (magnitude_id, opoint_id, datetime, datatype_id) " +
                        "do update set avg1m = ${rg.toDouble()}"
//                println "sql: $sql"

                try {
//                    println "inserta: $inserta"
                    cn.execute(sql.toString())
                    if (cn.updateCount > 0) {
                        insertados++
                    }
                } catch (Exception ex) {
                    repetidos++
                    println "Error al insertar $ex"
                }

            }
            cnta++
        }

        return [errores: errores, insertados: insertados, repetidos: repetidos]
    }

    def cargarMinutos(vrbl, estc, rgst) {
        def errores = ""
        def cnta = 0
        def insertados = 0
        def repetidos = 0
        def fcha
        def cn = dbConnectionService.getConnectionVisor()
        def sql = ""

//        println "inicia cargado de datos para mag: $vrbl, .... $rgst"
        fcha = rgst[0]
        rgst.removeAt(0)  // elimina la fecha y quedan solo lecturas

        cnta = 0
        rgst.each() { rg ->
//            println "--> estación: ${estc[cnta]}, valor: $rg, tipo: ${rg.class}, ${rg.size()}"
            if (rg.toString().size() > 0) {
//                println "--> estación: ${estc[cnta]}, valor: $rg"
                sql = "insert into mnto(lctr__id, magn__id, estc__id, lctrvlor, lctrfcha, lctrvlda) " +
                        "values(default, ${vrbl}, ${estc[cnta]}, ${rg.toDouble()}, '${fcha.format('yyyy-MM-dd HH:mm')}', 'V')"
                println "sql: $sql"
                try {
//                    println "inserta: $inserta"
                    cn.execute(sql.toString())
                    insertados++
/*
                    if(cn.execute(sql.toString()) > 0){
                        cnta++
                    }
*/
                } catch (Exception ex) {
                    repetidos++
                    println "Error al insertar $ex"
                }

            }
            cnta++
        }

        return [errores: errores, insertados: insertados, repetidos: repetidos]
    }

    /**
     * Busca los ID de las estaciones
     * **/
    def datosEstaciones(rgst) {
        def cn = dbConnectionService.getConnectionVisor()
        def sql = ""
        def estc = []

//        if (rgst[0].toString().toLowerCase() == 'fecha') {
        rgst.removeAt(0)
        rgst.each() { rg ->
            sql = "select id from survey.opoint where pname ilike '${rg[0..1]}%${rg[-4..-1]}'"
//                println "sql: $sql"
            def resp = cn.rows(sql.toString())
//                println "---> $resp"
            def id = cn.rows(sql.toString())[0]?.id
//                println "---> $rg, id: ${estc__id}"
//                estc[rg] = estc__id
            estc.add(id)
        }
//        }

        return estc
    }

    def buscaMagn(ar) {
        def cn = dbConnectionService.getConnectionVisor()
        def sql = "select id from survey.magnitude where abbreviation ilike '${ar}' limit 1"
        println "sql: $sql"
        return cn.rows(sql.toString())[0]?.id
    }

    def buscaMagnIUV(ar) {
        def cn = dbConnectionService.getConnectionVisor()
        def sql = ""
        def magn = []
        ar.each { m ->
            sql = "select id from survey.magnitude where abbreviation ilike '${m}' limit 1"
//            println "sql: $sql"
            magn.add(cn.rows(sql.toString())[0]?.id)
        }
//        println ".... $magn"
        return magn
    }

    def archivoSubido(arch, cont, rept) {
        def cn = dbConnectionService.getConnectionVisor()
        def sql = "insert into survey.file(id, name, loaded, lines, errors) values(default, '${arch}', " +
                "'${new Date().format('yyyy-MM-dd HH:mm:ss')}', ${cont}, ${rept})"
//        println "sql: $sql"
        cn.execute(sql.toString())
    }

    def calcular() {
        println "calcular --> $params"
        def cn = dbConnectionService.getConnectionVisor()
        def cn1 = dbConnectionService.getConnectionVisor()
        def sql = ""
        def sql1 = ""
        def sqlp = ""
        def magn = []
        def estc = []
        def salida = ""
        def salidaTotal = ""
        def cnta = 0
        def desde
        def hasta
        def proceso
        def fcha
        def fchaFin

        sql = "select distinct magnitude_id id from survey.data where magnitude_id != 82 order by 1"
        magn = cn.rows(sql.toString())
//        println "....1"

        proceso = ['10 minutes', '1 hours', '8 hours', '24 hours', '72 hours']
        proceso.each { prcs ->
            magn.each { mg ->
//                sql = "select distinct opoint_id id from partitions.data${mg.id} where avg1m is not null order by 1"
                sql = "select distinct opoint_id id from survey.data where avg1m is not null order by 1"
//            println "ppp: $sql"
                estc = cn.rows(sql.toString())
//            println "....2 estc: ${estc}"

                estc.each { es ->
                    sql1 = "select min(datetime)::date fcin, max(datetime)::date fcfn from survey.data " +
                            "where magnitude_id = ${mg.id} and opoint_id = ${es.id} and avg1m is not null"
//                    print "mg--> ${mg.id}: $sql1"
                    cn.eachRow(sql1.toString()) { d ->
                        if(d.fcin && d.fcfn) {
//                            println "fcin: ${d.fcin}, fcfn: ${d.fcfn}"
                            desde = new Date().parse("yyyy-MM-dd", "${d.fcin}")
                            hasta = new Date().parse("yyyy-MM-dd", "${d.fcfn}")
                        } else {
                            desde = new Date()
                            hasta = desde
                        }
                    }
//                    println "desde: ${desde}, hasta: ${hasta}"

                    fcha = desde
                    fchaFin = new Date().parse("dd-MM-yyyy", "31-12-${fcha.format('yyyy')}")
//                    println "procesa desde ${desde} hasta: ${hasta}"
                    while (fcha < hasta) {
                        use(groovy.time.TimeCategory) {
//                            println "---> ${fcha} hasta ${fchaFin}"
                            sqlp = "select count(*) cnta from survey.process " +
                                    "where '${fcha.format('yyyy-MM-dd')}' between from_date and to_date and " +
                                    "'${fchaFin.format('yyyy-MM-dd')}' between from_date and to_date and " +
                                    "magnitude_id = ${mg.id} and opoint_id = ${es.id} and name ilike '${prcs}'"
//                            println "... $sqlp"
                            def procesado = cn.rows(sqlp.toString())[0].cnta
                            if (!procesado) {
                                print "*** ${prcs} mg--> ${mg.id}, estc: ${es.id} '${fcha.format('yyyy-MM-dd')}' a '${fchaFin.format('yyyy-MM-dd')}'"
                                sql = "select * from survey.promedios(${mg.id}, ${es.id}, '${prcs}', " +
                                        "'${fcha.format('yyyy-MM-dd')}', '${fchaFin.format('yyyy-MM-dd')}')"
//                            println "sql--> $sql"
                                cn.eachRow(sql.toString()) { dt ->
                                    salida = dt.promedios
                                }

                                println "procesa ${prcs}: magnitud: $mg con estc: $es --> $salida"
                                cnta++
                                procesoHecho(mg.id, es.id, prcs, salida, fcha.format('yyyy-MM-dd'), fchaFin.format('yyyy-MM-dd'), salida)
                                salidaTotal += salidaTotal ? "\n${salida}" : salida
                            }

                            fcha = fchaFin + 1.day
                            if (fchaFin + 1.year > hasta) {
                                fchaFin = hasta
                            } else {
                                fchaFin = fchaFin + 1.year
                            }
                        }
                    }

                }
            }

        }
        flash.message = "Porcesado: ${salidaTotal}"
        render "ok"
    }

    def calcularDir() {
        println "calcularDir --> $params"
        def cn = dbConnectionService.getConnectionVisor()
        def cn1 = dbConnectionService.getConnectionVisor()
        def sql = ""
        def sql1 = ""
        def sqlp = ""
        def magn = []
        def estc = []
        def salida = ""
        def salidaTotal = ""
        def cnta = 0
        def desde
        def hasta
        def proceso
        def fcha
        def fchaFin

        proceso = ['10 minutes', '1 hours', '8 hours', '24 hours', '72 hours']
        proceso.each { prcs ->
            sql = "select distinct opoint_id id from survey.data where magnitude_id = 82 and " +
                    "avg1m is not null order by 1"
            println "ppp: $sql"
            estc = cn.rows(sql.toString())
//            println "....2 estc: ${estc}"

            estc.each { es ->
                sql1 = "select min(datetime)::date fcin, max(datetime)::date fcfn from survey.data " +
                        "where magnitude_id = 82 and opoint_id = ${es.id} and avg1m is not null"
//                    print "mg--> ${mg.id}: $sql1"
                cn.eachRow(sql1.toString()) { d ->
//                    println "fcin: ${d.fcin}, fcfn: ${d.fcfn}"
                    desde = new Date().parse("yyyy-MM-dd", "${d.fcin}")
                    hasta = new Date().parse("yyyy-MM-dd", "${d.fcfn}")
                }
//                    println "desde: ${desde}, hasta: ${hasta}"

                fcha = desde
                fchaFin = new Date().parse("dd-MM-yyyy", "31-12-${fcha.format('yyyy')}")
//                    println "procesa desde ${desde} hasta: ${hasta}"
                while (fcha < hasta) {
                    use(groovy.time.TimeCategory) {
//                            println "---> ${fcha} hasta ${fchaFin}"
                        sqlp = "select count(*) cnta from survey.process " +
                                "where '${fcha.format('yyyy-MM-dd')}' between from_date and to_date and " +
                                "'${fchaFin.format('yyyy-MM-dd')}' between from_date and to_date and " +
                                "magnitude_id = 82 and opoint_id = ${es.id} and name ilike '${prcs}'"
//                            println "... $sqlp"
                        def procesado = cn.rows(sqlp.toString())[0].cnta
                        if (!procesado) {
                            print "*** Dir: ${prcs} estc: ${es.id} '${fcha.format('yyyy-MM-dd')}' a '${fchaFin.format('yyyy-MM-dd')}'"
                            sql = "select * from survey.promedios_dir(${es.id}, '${prcs}', " +
                                    "'${fcha.format('yyyy-MM-dd')}', '${fchaFin.format('yyyy-MM-dd')}')"
//                            println "sql--> $sql"
                            cn.eachRow(sql.toString()) { dt ->
                                salida = dt.promedios_dir
                            }

                            println "procesa dirección viento ${prcs} con estc: $es --> $salida"
                            cnta++
                            procesoHecho(82, es.id, prcs, salida, fcha.format('yyyy-MM-dd'), fchaFin.format('yyyy-MM-dd'), salida)
                            salidaTotal += salidaTotal ? "\n${salida}" : salida
                        }

                        fcha = fchaFin + 1.day
                        if (fchaFin + 1.year > hasta) {
                            fchaFin = hasta
                        } else {
                            fchaFin = fchaFin + 1.year
                        }
                    }
                }

            }

        }
        flash.message = "Porcesado: ${salidaTotal}"
        render "ok"
    }

    def procesoHecho(magn, estc, proc, txto, fcds, fchs, salida) {
        def cn = dbConnectionService.getConnectionVisor()
        def sql = "insert into survey.process(id, magnitude_id, opoint_id, name, from_date, to_date, " +
                "datetime, result) values(default, '${magn}', '${estc}', '${proc}', '${fcds}', '${fchs}'," +
                "'${new Date().format('yyyy-MM-dd HH:mm:ss')}', '${salida}')"
//        println "...---> $sql"
        cn.execute(sql.toString())
    }


}
