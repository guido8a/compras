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

    }

    def validar() {
        println "cargaArchivo.. $params"
        def contador = 0
        def tipo = params.tipoTabla
        def univ = params.universidad
        def prdo = params.periodo
        def cn = dbConnectionService.getConnection()
        def path = servletContext.getRealPath("/") + "xlsData/"   //web-app/archivos
        new File(path).mkdirs()

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

                f.transferTo(new File(pathFile))

                InputStream ExcelFileToRead = new FileInputStream(pathFile);
                XSSFWorkbook wb = new XSSFWorkbook(ExcelFileToRead);

                XSSFWorkbook test = new XSSFWorkbook();

                XSSFSheet sheet = wb.getSheetAt(0);
                XSSFRow row;
                XSSFCell cell;

                Iterator rows = sheet.rowIterator();

                while (rows.hasNext()) {
                    row = (XSSFRow) rows.next()
                    Iterator cells = row.cellIterator()
//                    def rgst = cells.toList()
                    def rgst = []
//                    while (cells.hasNext()) {
//                        cell = (XSSFCell) cells.next()
//                        if(cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
//                            rgst.add( new DecimalFormat('#').format(cell.getNumericCellValue()))
//                        } else {
//                            rgst.add(cell.getStringCellValue())
//                        }
//                    }


                    def col1 = row[0].toString().trim()
                    def col4 = row[3].toString().trim()
                    println("1 -> " + col1)
                    println("4 -> " + col4)



//                    def cont = 0
//                    while (cells.hasNext()) {
//                        cells.next()
//                        cont++
//                    }
//                    println("cont " + cont)
//                    if (cont == 14) {
//                        println("cell " + row.getCell(1) + "")
//                    }

//                    switch (tipo) {
//                        case 'Facultades':
//                            def rslt = cargarDatosFacultades(univ, rgst)
//                            errores += rslt.errores
//                            contador += rslt.cnta
//                            break
//                        case 'Escuelas':
//                            def rslt = cargarDatosEscuelas(rgst)
//                            errores += rslt.errores
//                            contador += rslt.cnta
//                            break
//                        case 'Profesores':
//                            def rslt = cargarDatosProfesor(rgst)
//                            errores += rslt.errores
//                            contador += rslt.cnta
//                            break
//                        case 'Estudiantes':
//                            def rslt = cargarDatosEstudiante(rgst)
//                            errores += rslt.errores
//                            contador += rslt.cnta
//                            break
//                        case 'Materias':
//                            def rslt = cargarDatosMaterias(rgst)
//                            errores += rslt.errores
//                            contador += rslt.cnta
//                            break
//                        case 'Cursos':
//                            def rslt = cargarDatosCursos(rgst)
//                            errores += rslt.errores
//                            contador += rslt.cnta
//                            break
//                        case 'Materias que se dictan':
//                            def rslt = cargarDatosDictan(rgst, params.periodo)
//                            errores += rslt.errores
//                            contador += rslt.cnta
//                            break
//                        case 'Matriculados por materia':
//                            def rslt = cargarDatosMatriculados(rgst, params.periodo)
//                            errores += rslt.errores
//                            contador += rslt.cnta
//                            break
//                        case 'Todo':
//                            def rslt = cargaDatos(univ, rgst, prdo)
//                            errores += rslt.errores
//                            contador += rslt.cnta
//                            break
//                    }
                } //sheet ! hidden
//                println "...$errores"
//                println "...$contador"
                htmlInfo += "<p>Se han procesado $contador registros</p>"

                if (contador > 0) {
                    doneHtml = "<div class='alert alert-success'>Se ha verificado correctamente $contador registros</div>"
                    doneHtml += "<p>Existen $cntanmro registros con código repetido y, </p>"
                    doneHtml += "<p>existen $cntadscr registros con nombre repetido</p>"
                }

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
}
