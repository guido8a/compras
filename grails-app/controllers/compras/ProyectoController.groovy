package compras

import com.itextpdf.text.DocumentException
import com.itextpdf.text.ExceptionConverter
import com.itextpdf.text.Rectangle
import com.itextpdf.text.pdf.PdfAnnotation
import com.itextpdf.text.pdf.PdfDictionary
import com.itextpdf.text.pdf.PdfFormField
import com.itextpdf.text.pdf.PdfName
import com.itextpdf.text.pdf.PdfReader
import com.itextpdf.text.pdf.PdfSignatureAppearance
import com.itextpdf.text.pdf.PdfStamper
import com.itextpdf.text.pdf.security.BouncyCastleDigest
import com.itextpdf.text.pdf.security.ExternalBlankSignatureContainer
import com.itextpdf.text.pdf.security.ExternalDigest
import com.itextpdf.text.pdf.security.ExternalSignature
import com.itextpdf.text.pdf.security.ExternalSignatureContainer
import com.itextpdf.text.pdf.security.MakeSignature
import com.itextpdf.text.pdf.security.PdfPKCS7
import com.itextpdf.text.pdf.security.PrivateKeySignature
import com.itextpdf.xmp.impl.Utils
import seguridad.Departamento
import seguridad.Persona

import java.security.spec.X509EncodedKeySpec
import java.security.cert.X509Certificate
import static org.apache.commons.codec.binary.Base64.decodeBase64
import static org.apache.commons.codec.binary.Base64.encodeBase64String
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.Security;
import java.security.cert.Certificate;
import java.util.Calendar;



import com.itextpdf.text.DocumentException;
import com.itextpdf.text.ExceptionConverter;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfDictionary;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfSignatureAppearance;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.security.BouncyCastleDigest;
import com.itextpdf.text.pdf.security.DigestAlgorithms;
import com.itextpdf.text.pdf.security.ExternalBlankSignatureContainer;
import com.itextpdf.text.pdf.security.ExternalSignatureContainer;
import com.itextpdf.text.pdf.security.MakeSignature;
import com.itextpdf.text.pdf.security.MakeSignature.CryptoStandard;
import com.itextpdf.text.pdf.security.PdfPKCS7;
import com.itextpdf.text.pdf.security.PrivateKeySignature;


import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.*;


class ProyectoController {

    def dbConnectionService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def registroProyecto () {

        def proyecto

        if(params.id){
            proyecto = Proyecto.get(params.id)
        }else{
            proyecto = new Proyecto()
        }


        def departamentoUtfpu = Departamento.findByCodigo('UTFPU')
        def responsables = Persona.findAllByDepartamento(departamentoUtfpu).sort{it.apellido}

        return [proyectoInstance: proyecto, reponsables:responsables, revisores: responsables, inspectores: responsables]
    }

    def buscarComunidad () {

    }

    def tablaComunidad () {

//        println("params tc " + params)

        def resultado

        def select = "select provnmbr, cntnnmbr, parrnmbr, cmndnmbr, prov.prov__id, cntn.cntn__id, " +
                "parr.parr__id, cmnd.cmnd__id from prov, cntn, parr, cmnd"
        def txwh = "where cntn.prov__id = prov.prov__id and parr.cntn__id = cntn.cntn__id and cmnd.parr__id = parr.parr__id"
        def campos = ['provnmbr', 'cntnnmbr', 'parrnmbr', 'cmndnmbr']
        def cmpo = params.sele.toInteger()
        def sqlTx = ""

        txwh += " and ${campos[cmpo - 1]} ilike '%${params.criterio}%'"


        if(params.criterio != ''){
            sqlTx = "${select} ${txwh} order by ${campos[cmpo - 1]} ".toString()
        }else{
            sqlTx = "${select} ${txwh} order by cntnnmbr".toString()
        }

        def cn = dbConnectionService.getConnection()
        resultado = cn.rows(sqlTx)

//        println("resultado " + resultado)
        return[lista:resultado]
    }


    def save () {
//        println("params sp " + params)

        def proyectoInstance

        params.codigo = params.codigo.toUpperCase();

        if(params.id) {
            proyectoInstance = Proyecto.get(params.id)
            if(!proyectoInstance) {
                render "no_No se encontró el proyecto"
                return
            }//no existe el objeto

            if(proyectoInstance?.codigo == params.codigo){
                proyectoInstance.properties = params
            }else{
                if(Proyecto.findAllByCodigo(params.codigo)){
                    render "no_Ya existe un proyecto registrado con este código!"
                    return
                }else{
                    proyectoInstance.properties = params
                }
            }
        }//es edit
        else {
            if(Proyecto.findAllByCodigo(params.codigo)){
                render "no_Ya existe un proyecto registrado con este código!"
                return
            }else{
                params.estado = 'N'
                proyectoInstance = new Proyecto(params)

            }
        } //es create

        proyectoInstance.fechaCreacion = new Date()

        if (!proyectoInstance.save(flush: true)) {
            println("error al guardar el proyecto " + proyectoInstance?.errors)
            render "no_Error al guardar el proyecto"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el proyecto_" + proyectoInstance?.id
            } else {
                render "ok_Se ha creado correctamente el proyecto_" + proyectoInstance?.id
            }
        }
    }


    def list () {

    }

    def tablaProyecto () {
//        println("params tp " + params )

        def resultado

        def select = "select proy.proy__id, proycdgo, proynmbr, proyetdo, tppydscr, tpaddscr,  " +
                "cmndnmbr, dptodscr from proy, cmnd, tppy, tpad, dpto where cmnd.cmnd__id = proy.cmnd__id and " +
                "tppy.tppy__id = proy.tppy__id and tpad.tpad__id = proy.tpad__id and dpto.dpto__id = proy.dpto__id"

        def campos = ['proycdgo', 'proynmbr', 'tppydscr', 'cmndnmbr', 'dptodscr']
        def cmpo
        def txwh = ''
        def sqlTx

//        println("sql " + select)

        if(params.criterio != ''){
            if(params.tipo != ''){
                cmpo = params.tipo.toInteger()
                txwh += " and ${campos[cmpo - 1]} ilike '%${params.criterio}%'"
                sqlTx = "${select} ${txwh} order by ${campos[cmpo - 1]} limit 20".toString()
            }else{
                sqlTx = "${select} ${txwh} order by proynmbr limit 20".toString()
            }
        }else{
            sqlTx = "${select} ${txwh} order by proynmbr limit 20".toString()
        }

        def cn = dbConnectionService.getConnection()
        resultado = cn.rows(sqlTx)

//        println("sql " + sqlTx)
//        println("resultado " + resultado)

        return[lista:resultado]
    }

    def cambiarEstado_ajax () {
        def proyecto = Proyecto.get(params.id)

        def detalle = DetalleProyecto.findAllByProyecto(proyecto)
        def precio = Precio.findAllByDetalleProyectoInList(detalle)


        if(proyecto.estado == 'N'){
            proyecto.estado = 'R'
        }else{
            if(precio.size() > 0){
                render "er_" + precio?.detallePrecio?.proyecto?.nombre
                return false
            }else{
                proyecto.estado = 'N'
            }
        }

        if(!proyecto.save(flush:true)){
            render "no"
        }else{
            render "ok"
        }
    }

    def detalle () {
        def proyecto = Proyecto.get(params.id)
        return[proyecto: proyecto]
    }

    def buscarItem () {

    }

    def tablaItem () {
//        println("params " + params)
        def sql = "select item__id, itemnmbr, itemcdgo, undddscr from item, undd, tpit where undd.undd__id = item.undd__id " +
                "and tpit.tpit__id = item.tpit__id and tpitcdgo ilike 'I' and itemnmbr ilike '%${params.descripcion}%' " +
                "and itemcdgo ilike '%${params.codigo}%' order by itemnmbr limit 20"

//        println("sql " + sql)
        def cn = dbConnectionService.getConnection()
        def resultado = cn.rows(sql)

        return[lista: resultado]
    }

    def buscarPrecio () {

//        println("params " + params)

        def proyectoN = Proyecto.get(params.id)
        def item = Item.get(params.item)
//        def detalles = DetalleProyecto.findAllByItemAndProyectoNotEqual(item, proyecto).sort{it.proyecto.fechaCreacion}


        def detalles = DetalleProyecto.withCriteria {

            eq("item", item)
            and{
                ne("proyecto", proyectoN)
            }

            proyecto{
                lt("fechaCreacion", proyectoN?.fechaCreacion)
                order("fechaCreacion", "desc")
            }
        }

//        println("Detalles " + detalles)
//        def proformas = DetalleProforma.findAllByItem(item).sort{it.proforma.fecha}

        def proformas = DetalleProforma.withCriteria {

            eq("item", item)

            proforma{
                ne("estado","N")
                order("fecha")
            }
        }

        def resultados = [:]

        detalles.each {d->
            resultados.put(d.id, [d.item] + [d.precioUnitario] + ["DETALLE"] + [d.proyecto.nombre] + ['---'] + ["D"] + [d.fuente])
        }

        proformas.each{p->
            resultados.put(p.id, [p.item] + [p.precioUnitario] + ["PROFORMA"] + [p.proforma.descripcion] + [p.proforma.proveedor.nombre] + ["P"] + [p.procedencia])
        }

//        println("detalles " + detalles)
//        println("proformas " + proformas)

//        println("resultados " + resultados)

        return[detalles: detalles, proyecto: proyectoN, proformas: proformas, lista: resultados, item: params.item]
    }

    def tablaBuscarPrecio_ajax() {

//        println("params " + params)

        def proyectoN = Proyecto.get(params.id)
        def item = Item.get(params.item)
        def detalles = DetalleProyecto.withCriteria {

            eq("item", item)
            and{
                ne("proyecto", proyectoN)
            }

            proyecto{
                lt("fechaCreacion", proyectoN?.fechaCreacion)
                order("fechaCreacion", "desc")
                ne("estado","N")
            }
        }

//        println("Detalles " + detalles)

//        def proformas = DetalleProforma.findAllByItem(item).sort{it.proforma.fecha}


        def proformas = DetalleProforma.withCriteria {

            eq("item", item)

            proforma{
                ne("estado","N")
                order("fecha")
            }
        }

        def resultados = [:]

        detalles.each {d->
            resultados.put(d.id, [d.item] + [d.precioUnitario] + ["DETALLE"] + [d.proyecto.nombre] + ['---'] + ["D"] + [d.fuente])
        }

        proformas.each{p->
            resultados.put(p.id, [p.item] + [p.precioUnitario] + ["PROFORMA"] + [p.proforma.descripcion] + [p.proforma.proveedor.nombre] + ["P"] + [p.procedencia])
        }

        return[detalles: detalles, proyecto: proyectoN, proformas: proformas, lista: resultados]
    }

    def firma () {

    }

    def firmar () {

//        def archivoPath = servletContext.getRealPath("/") + "prueba111.txt"
        def archivoPath = servletContext.getRealPath("/") + "reporte.pdf"
        def archivoRes = servletContext.getRealPath("/") + "reporte_firmado.pdf"
        def archivoPath2 = servletContext.getRealPath("/")

        try {
            // Get instance and initialize a KeyPairGenerator object.
            KeyPairGenerator keyGen = KeyPairGenerator.getInstance("DSA", "SUN");
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG", "SUN");
            keyGen.initialize(1024, random);

            // Get a PrivateKey from the generated key pair.
            KeyPair keyPair = keyGen.generateKeyPair();
            PrivateKey privateKey = keyPair.getPrivate();

            // Get an instance of Signature object and initialize it.
            Signature signature = Signature.getInstance("SHA1withDSA", "SUN");
            signature.initSign(privateKey);

            // Supply the data to be signed to the Signature object
            // using the update() method and generate the digital
            // signature.
            byte[] bytes = Files.readAllBytes(Paths.get(archivoPath));
            signature.update(bytes);
            byte[] digitalSignature = signature.sign();

            println("digital signature: " + digitalSignature)

            // Save digital signature and the public key to a file.
//            Files.write(Paths.get(archivoPath2, "archivoFirmado.txt"), digitalSignature);
            Files.write(Paths.get(archivoRes), digitalSignature);
            Files.write(Paths.get(archivoPath2,"publickey"), keyPair.getPublic().getEncoded());

        } catch (Exception e) {
            println("error <<<<<<<<<<<<<<-" + e)
            e.printStackTrace();
        }
    }

    def verificar() {

//        def original = servletContext.getRealPath("/") + "prueba111.txt"
        def original = servletContext.getRealPath("/") + "reporte.pdf"
        def archivoPath2 = servletContext.getRealPath("/")

        try {
            byte[] publicKeyEncoded = Files.readAllBytes(Paths.get(archivoPath2, "publickey"));
            byte[] digitalSignature = Files.readAllBytes(Paths.get(archivoPath2, "reporte_firmado.pdf"));

            X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(publicKeyEncoded);
            KeyFactory keyFactory = KeyFactory.getInstance("DSA", "SUN");

            PublicKey publicKey = keyFactory.generatePublic(publicKeySpec);
            Signature signature = Signature.getInstance("SHA1withDSA", "SUN");
            signature.initVerify(publicKey);

            byte[] bytes = Files.readAllBytes(Paths.get(original));
            signature.update(bytes);

            boolean verified = signature.verify(digitalSignature);
            if (verified) {
                println("Verificado.");
            } else {
                println("No se puede verificar.");
            }
        } catch (Exception e) {
            println("error ->>>>>>>>>>>>>>>>>> " + e)
            e.printStackTrace();
        }
    }

    def firmar2 () {

        def archivoPath = servletContext.getRealPath("/") + "reporte.pdf"
        def archivoIntermedio = servletContext.getRealPath("/") + "reporte_intermedio.pdf"
        def archivoRes = servletContext.getRealPath("/") + "reporte_firmadoV2.pdf"
        def archivoPath2 = servletContext.getRealPath("/")
        char c = '\0'

//        PdfReader reader = new PdfReader(archivoPath);
        FileOutputStream os = new FileOutputStream(archivoRes);
        FileOutputStream inter = new FileOutputStream(archivoIntermedio);

        PdfReader reader = new PdfReader(archivoPath);
        PdfStamper stamper = new PdfStamper(reader, inter);
        PdfFormField field = PdfFormField.createSignature(stamper.getWriter());
        field.setFieldName("Signature");
        field.setWidget(new Rectangle(30, 830, 170, 770), PdfAnnotation.HIGHLIGHT_NONE);
        stamper.addAnnotation(field, 1);
        stamper.close();

        PdfReader reader2 = new PdfReader(archivoIntermedio);
        PdfStamper stamper2 = PdfStamper.createSignature(reader2, os, c)
        PdfSignatureAppearance appearance = stamper2.getSignatureAppearance();
        appearance.setReason("reason");
        appearance.setLocation("location");
        appearance.setCertificationLevel(PdfSignatureAppearance.CERTIFIED_NO_CHANGES_ALLOWED);
        appearance.setVisibleSignature("Signature");

        KeyPairGenerator keyGen = KeyPairGenerator.getInstance("DSA", "SUN");
//        SecureRandom random = SecureRandom.getInstance("SHA1withDSA", "SUN");
        SecureRandom random = SecureRandom.getInstance("SHA1PRNG", "SUN");
        keyGen.initialize(1024, random);
        KeyPair keyPair = keyGen.generateKeyPair();
        PrivateKey privateKey = keyPair.getPrivate();

        Signature signature = Signature.getInstance("SHA1withDSA", "SUN");
        signature.initSign(privateKey);
        byte[] bytes = Files.readAllBytes(Paths.get(archivoPath));
        signature.update(bytes);
        byte[] digitalSignature = signature.sign();

        println("digital signature: " + digitalSignature)

        Files.write(Paths.get(archivoRes), digitalSignature);
        Files.write(Paths.get(archivoPath2,"publickey"), keyPair.getPublic().getEncoded());



//        ExternalSignature pks = new PrivateKeySignature(privateKey, "SHA1PRNG", "SUN");
//        ExternalDigest digest = new BouncyCastleDigest();
//        MakeSignature.signDetached(appearance, digest, pks, null, null, null, null, 0, MakeSignature.CryptoStandard.CMS);

    }

    def firmar3 () {
        def archivoPath = servletContext.getRealPath("/")
        def origen = servletContext.getRealPath("/") + "reporte.pdf"
        def intermedio = servletContext.getRealPath("/") + "reporte_intermedio.pdf"
        def resultado = servletContext.getRealPath("/") + "reporte_firmado.pdf"
        def llave = servletContext.getRealPath("/") + "sender_keystore.p12"
        def certificado = servletContext.getRealPath("/") + "sender_certificate.cer"

        InputStream llaveInput = new FileInputStream(llave)

        String digestAlgorithm = "SHA512";
        CryptoStandard subfilter = CryptoStandard.CMS;

        InputStream resource = new FileInputStream(origen)
        OutputStream os = new FileOutputStream(intermedio)
        PdfReader reader = new PdfReader(resource);
        PdfStamper stamper = new PdfStamper(reader, os);
        PdfFormField field = PdfFormField.createSignature(stamper.getWriter());
        field.setFieldName("Signature");
        field.setWidget(new Rectangle(30, 830, 170, 770), PdfAnnotation.HIGHLIGHT_NONE);
        stamper.addAnnotation(field, 1);
        stamper.close();

        char c = '\0'
        char[] p = 'changeit'.toCharArray()
//        Certificate[] chain = new Certificate[]
        InputStream resource2 = new FileInputStream(intermedio)
        OutputStream os2 = new FileOutputStream(resultado)
        PdfReader reader2 = new PdfReader(resource2);
        PdfStamper stamper2 = PdfStamper.createSignature(reader2, os2, c);

        PdfSignatureAppearance appearance = stamper2.getSignatureAppearance();
        appearance.setReason("reason");
        appearance.setLocation("location");
        appearance.setCertificationLevel(PdfSignatureAppearance.CERTIFIED_NO_CHANGES_ALLOWED);
        appearance.setVisibleSignature("Signature");

        KeyStore keyStore = KeyStore.getInstance("PKCS12");
        InputStream inputstream = new FileInputStream(llave);
        keyStore.load(inputstream, p);

        PrivateKey privateKey = (PrivateKey) keyStore.getKey("senderKeyPair", p);

        ExternalSignature pks = new PrivateKeySignature(privateKey, digestAlgorithm, "BC");
        ExternalDigest digest = new BouncyCastleDigest();
        MakeSignature.signDetached(appearance, digest, pks, null, null, null, null, 0, subfilter);

    }

    def firmar4 () {

    }







}
