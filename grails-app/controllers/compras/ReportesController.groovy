package compras

import com.itextpdf.awt.DefaultFontMapper
import com.itextpdf.awt.PdfGraphics2D
import com.itextpdf.text.pdf.PdfContentByte
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPCellEvent
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfTemplate
import com.itextpdf.text.pdf.codec.Base64
import com.itextpdf.text.Image;
import com.itextpdf.text.Document;
import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.*
import seguridad.ParametrosAux

import java.awt.Color


import com.itextpdf.text.BaseColor
//import com.lowagie.text.Document
//import com.lowagie.text.Element
//import com.lowagie.text.Font
//import com.lowagie.text.Image
//import com.lowagie.text.PageSize
//import com.lowagie.text.Paragraph
//import com.lowagie.text.pdf.PdfContentByte
//import com.lowagie.text.pdf.PdfImportedPage
//import com.lowagie.text.pdf.PdfPCell
//import com.lowagie.text.pdf.PdfPTable
//import com.lowagie.text.pdf.PdfReader
//import com.lowagie.text.pdf.PdfWriter


import java.awt.Color
import java.text.DecimalFormat


class ReportesController {

    def dbConnectionService

    def reporteProyecto (){

        println("params reporte " + params)


        def proyecto = Proyecto.get(params.id)

        def baos = new ByteArrayOutputStream()
        Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        Font fontTh = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLD);
        Font fontTh2 = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLDITALIC);
        Font fontTh7 = new Font(Font.FontFamily.TIMES_ROMAN, 7, Font.BOLD);
        Font fontTh6 = new Font(Font.FontFamily.TIMES_ROMAN, 6, Font.BOLD);

        Document document
//        document = new Document(PageSize.A4.rotate());
        document = new Document(PageSize.A4);
        document.setMargins(20,20,28,28)  // 28 equivale a 1 cm: izq, derecha, arriba y abajo

        def pdfw = PdfWriter.getInstance(document, baos);

        document.open();
        PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Reporte Proyecto");
        document.addSubject("Generado por el sistema COMPRAS");
        document.addKeywords("reporte, proyectos");
        document.addAuthor("COMPRAS");
        document.addCreator("Tedein SA");

        Paragraph preface = new Paragraph();
        preface.add(new Paragraph("Reporte", fontTitulo));

        //Imagen

//        def logoPath = servletContext.getRealPath("/") + "images/logo_gadpp_reportes.png"
//        Image logo = Image.getInstance(logoPath);
//        logo.setAlignment(Image.LEFT | Image.TEXTWRAP)

        Paragraph lineaVacia = new Paragraph(" ", fontTitulo)

        def columnas = [15, 15, 20, 20, 15, 15]
        PdfPTable tabla1 = new PdfPTable(columnas.size());

        addCellTabla(tabla1, new Paragraph("", fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, new Paragraph("GOBIERNO AUTONOMO DECENTRALIZADO DE LA PROVINCIA DE PICHINCHA", fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, new Paragraph(proyecto?.codigo?.toString(), fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])

        addCellTabla(tabla1, new Paragraph("ESTUDIO DE MERCADO PARA LA DETERMINACIÓN DEL PRESUPUESTO REFERENCIAL", fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])

        addCellTabla(tabla1, new Paragraph("UNIDAD REQUIRENTE:", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, new Paragraph(proyecto?.unidadRequirente?.nombre ?: '', fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 4])
        addCellTabla(tabla1, new Paragraph("NOMBRE DEL PROYECTO:", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, new Paragraph(proyecto?.nombre ?: '', fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 4])

        addCellTabla(tabla1, new Paragraph("FECHA:", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tabla1, new Paragraph(proyecto?.fechaCreacion?.format("dd-MM-yyyy"), fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tabla1, new Paragraph("CANTÓN:", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tabla1, new Paragraph(proyecto?.comunidad?.parroquia?.canton?.nombre, fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tabla1, new Paragraph("SITIO DE ENTREGA:", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tabla1, new Paragraph(proyecto?.sitioEntrega, fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tabla1, new Paragraph("PARROQUIA:", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tabla1, new Paragraph(proyecto?.comunidad?.parroquia?.nombre, fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tabla1, new Paragraph("SITIO:", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tabla1, new Paragraph(proyecto?.sitio ?: '', fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tabla1, new Paragraph("DISTANCIA:", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tabla1, new Paragraph(proyecto?.distancia?.toString() + " KM", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tabla1, new Paragraph("CATEGORÍA DEL PRODUCTO CPC:", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, new Paragraph((proyecto?.codigoComprasPublicas?.numero?.toString() ?: '') + "- "+ (proyecto?.codigoComprasPublicas?.descripcion ?: '') , fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 4])

        addCellTabla(tabla1, new Paragraph("MARCO LEGAL:", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, new Paragraph("Art. 9 Fase preparatoria y contractual SECCIÓN I Documentos relevantes en las " +
                "fases contractual y precontractual comunes a los procedimientos de Contratación Pública. CAPITULO III DOCUMENTOS " +
                "CONSIDERADOS COMO RELEVANTES QUE DEBEN SER PUBLICADOS EN EL PORTAL INSTITUCIONAL DEL SERVICIO NACIONAL DE CONTRATACIÓN" +
                " PÚBLICA EN LOS PROCEDIMIENTOS DE CONTRATACIÓN PÚBLICA." , fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 4])

        addCellTabla(tabla1, new Paragraph("1.- ANÁLISIS DEL BIEN O SERVICIO A SER ADQUIRIDO", fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])

        addCellTabla(tabla1, new Paragraph("TIPO", fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, new Paragraph("BIENES" , fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 4])

        addCellTabla(tabla1, new Paragraph("1.1 CARACTERISTICAS TÉCNICAS", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, new Paragraph(proyecto?.caracteristicasTecnicas , fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 4])

        addCellTabla(tabla1, new Paragraph("1.2 ORIGEN DEL PRODUCTO", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, new Paragraph(proyecto?.origen , fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 4])

        def columnas2 = [15,15,15,15,20,20]
        PdfPTable tb1 = new PdfPTable(columnas2.size());
        tb1.setWidthPercentage(100);
        addCellTabla(tb1, new Paragraph("CODIGO CPC NIVEL 5 DEL OBJETO DE CONTRATACION", fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 5])
        addCellTabla(tb1, new Paragraph("36320", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb1, new Paragraph("La facilidad de adquisición en el mercado, fue analizada considerando la cantidad de Oferentes " +
                "registrados en el CPC del objeto de contratación", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5])
        addCellTabla(tb1, new Paragraph("CPC", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tb1, new Paragraph("PROVINCIA", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb1, new Paragraph("TODAS", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb1, new Paragraph("CANTÓN", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb1, new Paragraph("", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb1, new Paragraph("NÚMERO DE OFERENTES REGISTRADOS EN SERCOP", fontTh6), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb1, new Paragraph("4117", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tabla1, new Paragraph("1.3 FACILIDAD DE ADQUISICIÓN", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, tb1, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 4])

        def columnas4 = [100]
        PdfPTable tb3 = new PdfPTable(columnas4.size());
        tb3.setWidthPercentage(100);
        addCellTabla(tb3, new Paragraph("TIPO DE MONEDA", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tb3, new Paragraph("DÓLAR", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])

        def columnas3 = [50,50]
        PdfPTable tb2 = new PdfPTable(columnas3.size());
        tb2.setWidthPercentage(100);
        addCellTabla(tb2, tb3, [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tb2, new Paragraph("No existe Riesgo Cambiario en vista de que el análisis de los precios  y costos se realizó en Dólares.", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tabla1, new Paragraph("1.4  RIESGO CAMBIARIO", fontTh7), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tabla1, tb2, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 4])

        addCellTabla(tabla1, new Paragraph("2.- MONTOS DE ADJUDICACIONES SIMILARES REALIZADAS EN AÑOS PASADOS", fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])

        addCellTabla(tabla1, new Paragraph("Se han analizado los montos de adjudicaciones similares de años pasados, las cuales se han considerado" +
                " para el cálculo del presupuesto referencial en el cuadro de procesos similares", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5])
        addCellTabla(tabla1, new Paragraph("" , fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tabla1, new Paragraph("3.- VARIACIÓN DE PRECIOS LOCALES E/O IMPORTADOS", fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])

        addCellTabla(tabla1, new Paragraph("De las adjudicaciones de procesos similares encontrados a través de las herramientas del " +
                "SERCOP se han registrado en el cuadro respectivo  y se procedió a realizar el análisis  para determinar el valor actualizado, aplicando " +
                "el porcentaje de inflación mensual acumulada. ", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5])
        addCellTabla(tabla1, new Paragraph("" , fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tabla1, new Paragraph("4.- POSIBILIDAD DE EXISTENCIA DE PRODUCTOS O SERVICIOS  SUSTITUTOS", fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])

        addCellTabla(tabla1, new Paragraph("La unidad requirente para  la preparación del estudio de mercado ha considerado los productos o " +
                "servicios mas eficientes y disponibles en el país y en el mercado local, por lo tanto no se considera la posibilidad de existencia " +
                "de productos sustitutos.", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5])
        addCellTabla(tabla1, new Paragraph("" , fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tabla1, new Paragraph("5.-INFORMACIÓN  DE PRECIOS POR PROVEEDOR ", fontTh), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])

        addCellTabla(tabla1, new Paragraph("La Coordinación de Fijación de Precios Unitarios dentro del la preparación del Estudio de Mercado para " +
                "la determinación del presupuesto referencial, ha considerado toda información que contenga precios actualizados de los productos " +
                "a la fecha del estudio.", fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5])
        addCellTabla(tabla1, new Paragraph("" , fontTh), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])

        //firmas


        def columnas6 = [100]
        PdfPTable tb5 = new PdfPTable(columnas6.size());
        tb5.setWidthPercentage(100);

        addCellTabla(tb5, new Paragraph("_______________________________", fontTh), [border: BaseColor.WHITE, bcl: BaseColor.BLACK, bcb: BaseColor.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb5, new Paragraph(proyecto?.responsable?.nombre + " " + proyecto?.responsable?.apellido, fontTh7), [border: BaseColor.WHITE, bg: BaseColor.WHITE, bcl: BaseColor.WHITE, bct: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb5, new Paragraph("RESPONSABLE", fontTh2), [border: BaseColor.WHITE, bg: BaseColor.WHITE, bcl: BaseColor.WHITE, bct: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        PdfPTable tb6 = new PdfPTable(columnas6.size());
        tb6.setWidthPercentage(100);

        addCellTabla(tb6, new Paragraph("_______________________________", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb6, new Paragraph(proyecto?.revisor?.nombre + " " + proyecto?.revisor?.apellido , fontTh7), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb6, new Paragraph("REVISOR" , fontTh2), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        def columnas5 = [20,20,20,20,20]
        PdfPTable tb4 = new PdfPTable(columnas5.size());
        tb4.setWidthPercentage(100);

        addCellTabla(tb4, tb5, [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tb4, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tb4, tb6, [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])

        addCellTabla(tabla1, tb4, [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6, bwt: 40])

        document.add(lineaVacia)
        document.add(tabla1)
        document.close();

        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + 'reporteProyectos_' + new Date().format("dd-MM-yyyy") + ".pdf")
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def reporteProcesos (){

//        println("params reporte pro " + params)

        def proyecto = Proyecto.get(params.id)
        def detalles = DetalleProyecto.findAllByProyecto(proyecto).sort{it.orden}

        def baos = new ByteArrayOutputStream()
        Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        Font fontTh = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLD);
        Font fontTh2 = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLDITALIC);
        Font fontTh7 = new Font(Font.FontFamily.TIMES_ROMAN, 7, Font.BOLD);
        Font fontTh6 = new Font(Font.FontFamily.TIMES_ROMAN, 6, Font.BOLD);
        Font fontTh5 = new Font(Font.FontFamily.TIMES_ROMAN, 5, Font.BOLD);
        Font fontTh4 = new Font(Font.FontFamily.TIMES_ROMAN, 4, Font.BOLD);

        Document document
        document = new Document(PageSize.A4.rotate());
//        document = new Document(PageSize.A4);
        document.setMargins(20,20,28,28)  // 28 equivale a 1 cm: izq, derecha, arriba y abajo

        def pdfw = PdfWriter.getInstance(document, baos);

        document.open();
        PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Reporte Procesos");
        document.addSubject("Generado por el sistema COMPRAS");
        document.addKeywords("reporte, proyectos");
        document.addAuthor("COMPRAS");
        document.addCreator("Tedein SA");

        Paragraph preface = new Paragraph();
        preface.add(new Paragraph("Reporte_procesos", fontTitulo));

        //Imagen
//        def logoPath = servletContext.getRealPath("/") + "images/logo_gadpp_reportes.png"
//        Image logo = Image.getInstance(logoPath);
//        logo.setAlignment(Image.LEFT | Image.TEXTWRAP)

        Paragraph lineaVacia = new Paragraph(" ", fontTitulo)

        def columnasT = [10,10,30,30,10,10]
        PdfPTable tablaT = new PdfPTable(columnasT.size())
        tablaT.setWidthPercentage(100);

        addCellTabla(tablaT, new Paragraph("2. MONTOS DE ADJUDICACIONES SIMILARES REALIZADAS EN AÑOS PASADOS", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])
        addCellTabla(tablaT, new Paragraph(proyecto?.nombre, fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])

        addCellTabla(tablaT, new Paragraph("Fecha:", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph(proyecto?.fechaCreacion?.format("dd/MM/yyyy")?.toString(), fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tablaT, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph(proyecto?.codigo, fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tablaT, new Paragraph("Preparado por:", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_CENTER, colspan: 1])
        addCellTabla(tablaT, new Paragraph(proyecto?.responsable?.nombre + " " + proyecto?.responsable?.apellido, fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tablaT, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        PdfPTable tablaC = new PdfPTable(1, 4, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1)
//        tablaC.setWidthPercentage(100);

        addCellTabla(tablaC, new Paragraph("N°", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("DESCRIPCIÓN", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("ATRIBUTO", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("CARACTERÍSTICAS TÉCNICAS", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("UNIDAD", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("ADJUDICACIÓN SIMILAR", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("FECHA DE ADJUDICACIÓN", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("PRECIO UNITARIO", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("INFLACIÓN ACUMULADA A LA FECHA", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("PRECIO ACTUALIZADO", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("PRECIO MAS CONVENIENTE", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("CRITERIOS DE SELECCIÓN", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        detalles.each { detalle->
            addCellTabla(tablaC, new Paragraph(detalle?.orden?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.item?.nombre, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph("", fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph("", fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.item?.unidad?.codigo, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

            def precios = Precio.findAllByDetallePrecioAndDetalleProyectoIsNotNull(detalle)

            def columnasP = [100]
            PdfPTable tbP1 = new PdfPTable(columnasP.size());
            tbP1.setWidthPercentage(100);

            def columnasFecha = [100]
            PdfPTable tbP2 = new PdfPTable(columnasFecha.size());
            tbP2.setWidthPercentage(100);

            def columnasP2 = [100]
            PdfPTable tbP3 = new PdfPTable(columnasP2.size());
            tbP3.setWidthPercentage(100);

            def columnasP3 = [100]
            PdfPTable tbP4 = new PdfPTable(columnasP3.size());
            tbP4.setWidthPercentage(100);

            def columnasP4 = [100]
            PdfPTable tbP5 = new PdfPTable(columnasP4.size());
            tbP5.setWidthPercentage(100);

            def anio
            def inflacion

            precios.each {precio->
                anio = Anio.findByAnio(precio?.detalleProyecto?.proyecto?.fechaCreacion?.format("yyyy")?.toString())
                if(anio){
                    inflacion = ValoresAnuales.findByAnio(anio).inflacion + " %"
                }else{
                    inflacion = "No ingresada"
                }
                if(precios.size() == 1){
                    addCellTabla(tbP1, new Paragraph(precio?.detalleProyecto?.proyecto?.codigo, fontTh6), [pt: 12, pb: 12, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tbP2, new Paragraph(precio?.detalleProyecto?.proyecto?.fechaCreacion?.format("dd/MM/yyyy"), fontTh6), [pt: 12, pb: 12, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tbP3, new Paragraph(precio?.valor?.toString(), fontTh6), [pt: 12, pb: 12, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tbP4, new Paragraph(inflacion?.toString(), fontTh6), [pt: 12, pb: 12, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tbP5, new Paragraph(precio?.valor?.toString(), fontTh6), [pt: 12, pb: 12, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                }else{
                    if(precios.size() == 2){
                        addCellTabla(tbP1, new Paragraph(precio?.detalleProyecto?.proyecto?.codigo, fontTh6), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                        addCellTabla(tbP2, new Paragraph(precio?.detalleProyecto?.proyecto?.fechaCreacion?.format("dd/MM/yyyy"), fontTh6), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                        addCellTabla(tbP3, new Paragraph(precio?.valor?.toString(), fontTh6), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                        addCellTabla(tbP4, new Paragraph(inflacion?.toString(), fontTh6), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                        addCellTabla(tbP5, new Paragraph(precio?.valor?.toString(), fontTh6), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    }else{
                        addCellTabla(tbP1, new Paragraph(precio?.detalleProyecto?.proyecto?.codigo, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                        addCellTabla(tbP2, new Paragraph(precio?.detalleProyecto?.proyecto?.fechaCreacion?.format("dd/MM/yyyy"), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                        addCellTabla(tbP3, new Paragraph(precio?.valor?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                        addCellTabla(tbP4, new Paragraph(inflacion?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                        addCellTabla(tbP5, new Paragraph(precio?.valor?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    }
                }
            }

            addCellTabla(tablaC, tbP1, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, tbP2, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, tbP3, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, tbP4, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, tbP5, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.precioProyecto?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.criterioProyecto?.descripcion, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        }

        document.add(lineaVacia)
        document.add(tablaT)
        document.add(lineaVacia)
        document.add(tablaC)
        document.close();

        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + 'reporteProyectos_' + new Date().format("dd-MM-yyyy") + ".pdf")
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }


    def reporteProformas (){

        println("params reporte proformas " + params)

        def proyecto = Proyecto.get(params.id)
        def detalles = DetalleProyecto.findAllByProyecto(proyecto).sort{it.orden}

        def baos = new ByteArrayOutputStream()
        Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        Font fontTh = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLD);
        Font fontTh2 = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLDITALIC);
        Font fontTh7 = new Font(Font.FontFamily.TIMES_ROMAN, 7, Font.BOLD);
        Font fontTh6 = new Font(Font.FontFamily.TIMES_ROMAN, 6, Font.BOLD);
        Font fontTh5 = new Font(Font.FontFamily.TIMES_ROMAN, 5, Font.BOLD);
        Font fontTh4 = new Font(Font.FontFamily.TIMES_ROMAN, 4, Font.BOLD);

        Document document
        document = new Document(PageSize.A4.rotate());
//        document = new Document(PageSize.A4);
        document.setMargins(20,20,28,28)  // 28 equivale a 1 cm: izq, derecha, arriba y abajo

        def pdfw = PdfWriter.getInstance(document, baos);

        document.open();
        PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Reporte Proformas");
        document.addSubject("Generado por el sistema COMPRAS");
        document.addKeywords("reporte, proyectos");
        document.addAuthor("COMPRAS");
        document.addCreator("Tedein SA");

        Paragraph preface = new Paragraph();
        preface.add(new Paragraph("Reporte_proformas", fontTitulo));

        //Imagen
//        def logoPath = servletContext.getRealPath("/") + "images/logo_gadpp_reportes.png"
//        Image logo = Image.getInstance(logoPath);
//        logo.setAlignment(Image.LEFT | Image.TEXTWRAP)

        Paragraph lineaVacia = new Paragraph(" ", fontTitulo)

        def columnasT = [10,10,30,30,10,10]
        PdfPTable tablaT = new PdfPTable(columnasT.size())
        tablaT.setWidthPercentage(100);

        def columnasS = [10,10,30,30,10,10]
        PdfPTable tablaS = new PdfPTable(columnasS.size())
        tablaS.setWidthPercentage(100);

        addCellTabla(tablaT, new Paragraph("2.INFORMACIÓN DE PRECIOS POR PROVEEDOR", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])
        addCellTabla(tablaT, new Paragraph(proyecto?.nombre, fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])

        addCellTabla(tablaT, new Paragraph("Fecha proformas:", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph(proyecto?.fechaCreacion?.format("dd/MM/yyyy")?.toString(), fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tablaT, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph(proyecto?.codigo, fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tablaT, new Paragraph("Preparado por:", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_CENTER, colspan: 1])
        addCellTabla(tablaT, new Paragraph(proyecto?.responsable?.nombre + " " + proyecto?.responsable?.apellido, fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tablaT, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph("", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tablaS, new Paragraph("Mediante correo electrónico a la fecha de este estudio se solicitó " +
                "cotizaciones así como los listados de precios vigentes de los " +
                "productos abajo citados obteniendo la siguiente información:", fontTh6), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])

        PdfPTable tablaC = new PdfPTable(1, 4, 1, 1, 1, 2, 1, 1, 1, 1)
//        tablaC.setWidthPercentage(100);

        addCellTabla(tablaC, new Paragraph("N°", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("DESCRIPCIÓN", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("ATRIBUTO", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("CARACTERÍSTICAS TÉCNICAS", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("UNIDAD", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("INFORMACIÓN PROVEEDOR", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("PRECIO UNITARIO", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("PRECIO MAS CONVENIENTE", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("PROCEDENCIA", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("CRITERIOS DE SELECCIÓN", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        detalles.each { detalle->
            addCellTabla(tablaC, new Paragraph(detalle?.orden?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.item?.nombre, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph("", fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph("", fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.item?.unidad?.codigo, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

//            def precios = Precio.findAllByDetallePrecioAndDetalleProyectoIsNotNull(detalle)
            def precios = Precio.findAllByDetallePrecioAndDetalleProformaIsNotNull(detalle)

            def columnasP = [100]
            PdfPTable tbP1 = new PdfPTable(columnasP.size());
            tbP1.setWidthPercentage(100);

            def columnasFecha = [100]
            PdfPTable tbP2 = new PdfPTable(columnasFecha.size());
            tbP2.setWidthPercentage(100);

            def columnasP2 = [100]
            PdfPTable tbP3 = new PdfPTable(columnasP2.size());
            tbP3.setWidthPercentage(100);

            def columnasP3 = [100]
            PdfPTable tbP4 = new PdfPTable(columnasP3.size());
            tbP4.setWidthPercentage(100);

            def columnasP4 = [100]
            PdfPTable tbP5 = new PdfPTable(columnasP4.size());
            tbP5.setWidthPercentage(100);

            def anio
            def inflacion
            def precioMenor = 0
            def precioAnterior = 0

            precios.each {precio->

                if(precios.size() == 1){
                    addCellTabla(tbP1, new Paragraph(precio?.detalleProforma?.proforma?.proveedor?.nombre, fontTh6), [pt: 12, pb: 12, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tbP3, new Paragraph(precio?.valor?.toString(), fontTh6), [pt: 12, pb: 12, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                }else{
                    if(precios.size() == 2){
                        addCellTabla(tbP1, new Paragraph(precio?.detalleProforma?.proforma?.proveedor?.nombre, fontTh6), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                        addCellTabla(tbP3, new Paragraph(precio?.valor?.toString(), fontTh6), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    }else{
                        addCellTabla(tbP1, new Paragraph(precio?.detalleProforma?.proforma?.proveedor?.nombre, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                        addCellTabla(tbP3, new Paragraph(precio?.valor?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    }
                }
            }

            addCellTabla(tablaC, tbP1, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, tbP3, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
//            addCellTabla(tablaC, tbP5, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.precioProforma?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph((detalle?.fuente == 'N' ? 'NACIONAL' : 'EXTRANJERO'), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.criterioProforma?.descripcion, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        }

        document.add(lineaVacia)
        document.add(tablaT)
        document.add(lineaVacia)
        document.add(tablaS)
        document.add(tablaC)
        document.close();

        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + 'reporteProformas_' + new Date().format("dd-MM-yyyy") + ".pdf")
        response.setContentLength(b.length)
        response.getOutputStream().write(b)

    }

    def reportePresupuesto (){

//        println("params reporte pro " + params)

        def proyecto = Proyecto.get(params.id)
        def detalles = DetalleProyecto.findAllByProyecto(proyecto).sort{it.orden}

        def baos = new ByteArrayOutputStream()
        Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        Font lineaV = new Font(Font.FontFamily.HELVETICA, 6, Font.BOLD);
        Font fontTh = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLD);
        Font fontTh2 = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLDITALIC);
        Font fontTh7 = new Font(Font.FontFamily.TIMES_ROMAN, 7, Font.BOLD);
        Font fontTh6 = new Font(Font.FontFamily.TIMES_ROMAN, 6, Font.BOLD);
        Font fontTh5 = new Font(Font.FontFamily.TIMES_ROMAN, 5, Font.BOLD);
        Font fontTh4 = new Font(Font.FontFamily.TIMES_ROMAN, 4, Font.BOLD);

        Document document
        document = new Document(PageSize.A4.rotate());
//        document = new Document(PageSize.A4);
        document.setMargins(20,20,28,28)  // 28 equivale a 1 cm: izq, derecha, arriba y abajo

        def pdfw = PdfWriter.getInstance(document, baos);

        document.open();
        PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Reporte Presupuesto");
        document.addSubject("Generado por el sistema COMPRAS");
        document.addKeywords("reporte, presupuesto");
        document.addAuthor("COMPRAS");
        document.addCreator("Tedein SA");

        Paragraph preface = new Paragraph();
        preface.add(new Paragraph("Reporte_presupuesto", fontTitulo));

        //Imagen
//        def logoPath = servletContext.getRealPath("/") + "images/logo_gadpp_reportes.png"
//        Image logo = Image.getInstance(logoPath);
//        logo.setAlignment(Image.LEFT | Image.TEXTWRAP)

        Paragraph lineaVacia = new Paragraph(" ", fontTitulo)
        Paragraph lineaVacia2 = new Paragraph(" ", lineaV)

        def columnasT = [10,10,30,30,10,10]
        PdfPTable tablaT = new PdfPTable(columnasT.size())
        tablaT.setWidthPercentage(100);

        addCellTabla(tablaT, new Paragraph("PRESUPUESTO REFERENCIAL", fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])
        addCellTabla(tablaT, new Paragraph(proyecto?.nombre, fontTh), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 6])

        addCellTabla(tablaT, new Paragraph("Fecha:", fontTh6), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph(proyecto?.fechaCreacion?.format("dd/MM/yyyy")?.toString(), fontTh6), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph("", fontTh6), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tablaT, new Paragraph("", fontTh6), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaT, new Paragraph(proyecto?.codigo, fontTh6), [border: BaseColor.WHITE, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        PdfPTable tablaC = new PdfPTable(1, 4, 1, 2, 1, 1, 1, 1, 1, 1, 1)

        def columnasP = [100]
        PdfPTable tbP1 = new PdfPTable(columnasP.size());
        tbP1.setWidthPercentage(100);

        addCellTabla(tbP1, new Paragraph("PRECIO DE ADJUDICACIONES SIMILARES", fontTh4), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tbP1, new Paragraph("1", fontTh6), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tbP1, new Paragraph("Precio Unitario", fontTh4), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])

        def columnasP2 = [100]
        PdfPTable tbP2 = new PdfPTable(columnasP2.size());
        tbP2.setWidthPercentage(100);

        addCellTabla(tbP2, new Paragraph("PRECIO DE INFORMACIÓN PROVEEDOR", fontTh4), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tbP2, new Paragraph("2", fontTh6), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tbP2, new Paragraph("Precio Unitario", fontTh4), [pt: 7, border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaC, new Paragraph("N°", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("DESCRIPCIÓN", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("ATRIBUTO", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("CARACTERÍSTICAS TÉCNICAS", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("UNIDAD", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("CANTIDAD", fontTh5), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, tbP1, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, tbP2, [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("PRECIO MAS CONVENIENTE", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("JUSTIFICATIVO DE SELECCIÓN", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaC, new Paragraph("SUBTOTAL", fontTh4), [border: BaseColor.BLACK, bg: BaseColor.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])


        def total = 0

        detalles.each { detalle->
            addCellTabla(tablaC, new Paragraph(detalle?.orden?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.item?.nombre, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph("", fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph("", fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.item?.unidad?.codigo, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.cantidad?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.precioProyecto?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.precioProforma?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.precioUnitario?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.criterio?.descripcion, fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            addCellTabla(tablaC, new Paragraph(detalle?.subtotal?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
            total += detalle?.subtotal
        }

        def iva = (ParametrosAux.findByIdIsNotNull().iva)/100
        def subtotalConIva = (iva * total) ?: 0
        def totalFinal = (total + subtotalConIva) ?: 0

        PdfPTable tablaTotales = new PdfPTable(1, 4, 1, 2, 1, 1, 1, 1, 1, 1, 1)
        addCellTabla(tablaTotales, new Paragraph("", fontTh6), [border: BaseColor.WHITE, bcr: BaseColor.BLACK, bct: BaseColor.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 8])
        addCellTabla(tablaTotales, new Paragraph("SUB TOTAL SIN IVA", fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tablaTotales, new Paragraph(total?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tablaTotales, new Paragraph("", fontTh6), [border: BaseColor.WHITE, bcr: BaseColor.BLACK, bct: BaseColor.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 8])
        addCellTabla(tablaTotales, new Paragraph("IVA", fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaTotales, new Paragraph(ParametrosAux.findByIdIsNotNull().iva?.toString() + " %" , fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])
        addCellTabla(tablaTotales, new Paragraph(subtotalConIva?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        addCellTabla(tablaTotales, new Paragraph("", fontTh6), [border: BaseColor.WHITE, bcr: BaseColor.BLACK, bct: BaseColor.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 8])
        addCellTabla(tablaTotales, new Paragraph("TOTAL", fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tablaTotales, new Paragraph(totalFinal?.toString(), fontTh6), [border: BaseColor.BLACK, bg: BaseColor.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, colspan: 1])

        document.add(lineaVacia)
        document.add(tablaT)
        document.add(lineaVacia)
        document.add(tablaC)
        document.add(lineaVacia2)
        document.add(tablaTotales)
        document.close();

        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + 'reportePresupuesto_' + new Date().format("dd-MM-yyyy") + ".pdf")
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }



    private static void addCellTabla(PdfPTable table, paragraph, params) {
        PdfPCell cell = new PdfPCell(paragraph);

//        cell.setBorderColor(BaseColor.WHITE)
//        cell.setBorderColorBottom(BaseColor.BLACK)
//        cell.setBorderColorRight(com.itextpdf.text.BaseColor.BLACK)

        if (params.height) {
            cell.setFixedHeight(params.height.toFloat());
        }
        if (params.border) {
            cell.setBorderColor(params.border)
        }
        if (params.bg) {
            cell.setBackgroundColor(params.bg);
        }
        if (params.colspan) {
            cell.setColspan(params.colspan);
        }
        if (params.align) {
            cell.setHorizontalAlignment(params.align);
        }
        if (params.valign) {
            cell.setVerticalAlignment(params.valign);
        }
        if (params.w) {
            cell.setBorderWidth(params.w);
            cell.setUseBorderPadding(true);
        }
        if (params.bwl) {
            cell.setBorderWidthLeft(params.bwl.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwb) {
            cell.setBorderWidthBottom(params.bwb.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwr) {
            cell.setBorderWidthRight(params.bwr.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwt) {
            cell.setBorderWidthTop(params.bwt.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bcl) {
            cell.setBorderColorLeft(params.bcl);
        }
        if (params.bcb) {
            cell.setBorderColorBottom(params.bcb);
        }
        if (params.bcr) {
            cell.setBorderColorRight(params.bcr);
        }
        if (params.bct) {
            cell.setBorderColorTop(params.bct);
        }
        if (params.padding) {
            cell.setPadding(params.padding.toFloat());
        }
        if (params.pl) {
            cell.setPaddingLeft(params.pl.toFloat());
        }
        if (params.pr) {
            cell.setPaddingRight(params.pr.toFloat());
        }
        if (params.pt) {
            cell.setPaddingTop(params.pt.toFloat());
        }
        if (params.pb) {
            cell.setPaddingBottom(params.pb.toFloat());
        }

        table.addCell(cell);
    }




}
