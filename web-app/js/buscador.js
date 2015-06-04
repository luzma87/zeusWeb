$(".buscador").css({fontSize:10});
$("#btn_reporte").click(function(){
    if($("#tablaBuscador").html()){
        var data = "";
        $(".crit").each(function(){
            data+="&campos="+$(this).attr("campo");
            data+="&operadores="+$(this).attr("operador");
            data+="&criterios="+$(this).attr("criterio");
        });
        if(data.length<2){
            data="tc="+$("#tipoCampo").val()+"&campos="+$("#campo :selected").val()+"&operadores="+$("#operador :selected").val()+"&criterios="+$("#criterio").val()
        }
        data+="&ordenado="+$("#campoOrdn :selected").val()+"&orden="+$("#orden :selected").val();

        var div = $("#tablaBuscador").parent()
        //console.log(headers)
        location.href =div.attr("url")+"?"+data+"&reporte=1"
    }

});
$("#btn_excel").click(function(){
    if($("#tablaBuscador").html()){
        var data = "";
        $(".crit").each(function(){
            data+="&campos="+$(this).attr("campo");
            data+="&operadores="+$(this).attr("operador");
            data+="&criterios="+$(this).attr("criterio");
        });
        if(data.length<2){
            data="tc="+$("#tipoCampo").val()+"&campos="+$("#campo :selected").val()+"&operadores="+$("#operador :selected").val()+"&criterios="+$("#criterio").val()
        }
        data+="&ordenado="+$("#campoOrdn :selected").val()+"&orden="+$("#orden :selected").val();

        var div = $("#tablaBuscador").parent()
        location.href =div.attr("url")+"?"+data+"&excel=1"
    }

});

$("#campo").change(function() {
    cambiaOperador()
});
$("#reset").click(function(){
    $(".crit").remove()
});

$("#mas").unbind()
$("#mas").bind("click",function(){
    var tipoCampo=$("#tipoCampo")
    var campo = $("#campo :selected")
    var operador = $("#operador :selected")
    var criterio = $("#criterio")
    var div =$("<div>")
    div.html(campo.text()+" "+operador.text()+" a '"+criterio.val()+"'").addClass("crit ui-corner-all")
    div.attr("campo",campo.val()).attr("operador",operador.val()).attr("criterio",criterio.val())
    div.css({float:"left",height:"25px",minWith :"60px",background:"rgba(248, 192, 60,0.5)",lineHeight:"25px",paddingLeft:"5px",paddingRight:"5px",marginLeft:"5px",marginTop:"5px",border:"1px solid rgb(248, 192, 60)",cursor:"pointer"})
    div.click(function(){
        $(this).remove()
    })
    $("#criterios").append(div)




});


function cambiaOperador() {
    if ($("#campo option:selected").attr("tipo") == 'string') {
        $("#operador option").remove();
        var opt = $("<option value=\'like\'>Contiene</option>");
        $("#operador").append(opt);
        opt = $("<option value=\'like der\'>Empieza</option>");
        $("#operador").append(opt);
        opt = $("<option value=\'igual\'>Igual</option>");
        $("#operador").append(opt);
    }
    if ($("#campo :selected").attr("tipo") == "number" || $("#campo :selected").attr("tipo") == "date" ) {
        $("#Doperador").html('<select name="operador" id="operador" style="width: 80px;font-size: 10px"><option value="=">Igual</option><option value=">">Mayor</option><option value="<">Menor</option>  </select>');
        $("#tipoCampo").val("number");
    }
    if ($("#campo :selected").attr("tipo") == "-1") {
        $("#Doperador").html('<select name="operador" style="width: 80px;font-size: 10px"></select>');
    }
}

$("#criterio").keypress(function(event){
    if(parseInt(event.keyCode) == 13){
        $("#buscarDialog").click()
    }
});
$(".bsc_desc").keypress(function(){
    return false
});
$(".bsc_desc").click(function(){
    $("#"+$(this).attr("dialog")).modal("show")
});
$(".bsc_desc").focus(function(){
    $("#"+$(this).attr("dialog")).modal("show")
});