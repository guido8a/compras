package utilitarios

import org.apache.poi.xssf.usermodel.XSSFCell
import org.apache.poi.xssf.usermodel.XSSFRow
import org.apache.poi.xssf.usermodel.XSSFSheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.springframework.dao.DataIntegrityViolationException
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
        respond parametrosService.list(params), model:[parametrosCount: parametrosService.count()]
    }

    def list () {

    }


    def cargarDatos () {
        def cn = dbConnectionService.getConnectionVisor()
        def sql = ""
        def data = []

        sql = "select magn__id, magnnmbr||'('||magnabrv||')' nombre from magn order by magnnmbr"
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
                InputStream ExcelFileToRead = new FileInputStream('/home/guido/proyectos/visor/SO2.xlsx');
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

                        if(cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
                            if(cell.toString().contains('-')) {
                                rgst.add(cell.getDateCellValue())
                            } else
//                            rgst.add( new DecimalFormat('#.##').format(cell.getNumericCellValue()))
                            rgst.add(cell.getNumericCellValue())
                        } else {
                            rgst.add(cell.getStringCellValue())
                        }
                    }

                    if(rgst[0] == "FECHA") {
                        estc = datosEstaciones(rgst)
                        println "estaciones: $estc"
                    } else if(rgst[0]){
                        println "---> Registro: $rgst"
                        inserta = cargarLecturas (vrbl, estc, rgst)
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

    def cargarLecturas (vrbl, estc, rgst) {
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
            if(rg.toString().size() > 0 ){
                println "--> estación: ${estc[cnta]}, valor: $rg"
                sql = "insert into lctr(lctr__id, magn__id, estc__id, lctrvlor, lctrfcha, lctrvlda) " +
                        "values(default, ${vrbl}, ${estc[cnta]}, ${rg.toDouble()}, '${fcha.format('yyyy-MM-dd HH:mm')}', 'V')"
//                println "sql: $sql"
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
                cnta++
            }

        }

        return [errores: errores, insertados: insertados, repetidos: repetidos]
    }

    /**
     * Busca los ID de las estaciones
     * **/
    def datosEstaciones( rgst ) {
        def cn = dbConnectionService.getConnectionVisor()
        def sql = ""
        def estc = []

        if(rgst[0] == 'FECHA'){
            rgst.removeAt(0)
            rgst.each() {rg ->
                sql = "select estc__id from estc where estcnmbr ilike '%${rg}%'"
//                println "sql: $sql"
                def resp = cn.rows(sql.toString())
//                println "---> $resp"
                def estc__id = cn.rows(sql.toString())[0]?.estc__id
                println "---> $rg, id: ${estc__id}"
//                estc[rg] = estc__id
                estc.add(estc__id)
            }
        }

        return estc
    }

}
