//Función para validar CIF
function validarCif(abc){
	par = 0;
	non = 0;
	letras = "ABCDEFGHKLMNPQS";
	let = abc.charAt(0);

	if (abc.length!=9) {
		alert('El Cif debe tener 9 dígitos');
		document.getElementById('cif').focus();
		//return false;
	} else if (letras.indexOf(let.toUpperCase())==-1) {
		alert("El comienzo del Cif no es válido");
		document.getElementById('cif').focus();
		//return false;
		}else{
			for (zz=2;zz<8;zz+=2) {
				par = par+parseInt(abc.charAt(zz));
			}

			for (zz=1;zz<9;zz+=2) {
				nn = 2*parseInt(abc.charAt(zz));
				if (nn > 9) nn = 1+(nn-10);	
				non = non+nn;
			}

			parcial = par + non;
			control = (10 - ( parcial % 10));
			if (control==10){
				control=0;
			}

			if (control!=abc.charAt(8)) {
				alert("El Cif no es válido");
				document.getElementById('cif').focus();
				//return false;
			}else {
			//alert("El Cif es válido");
			//return true;
			}
		}
}

//Función para validar NIF
function validarNif(abc){
	dni=abc.substring(0,abc.length-1);
	let=abc.charAt(abc.length-1);
	if (!isNaN(let)) {
		alert('Falta la letra');
		//return false;
		document.getElementById('cif').focus();
	}else{
		cadena = "TRWAGMYFPDXBNJZSQVHLCKET";
		posicion = dni % 23;
		letra = cadena.substring(posicion,posicion+1);
		if (letra!=let.toUpperCase()){
			alert("Nif no válido");
			//return false;
			document.getElementById('cif').focus();
		} else {
			//alert("Nif válido")
			//return true;	
		}
	}
	
}

//Función para comprobar si es DNI o CIF
function comprobarNifCif(abc){
	var patronNum = /^[0-9]/;
	var patronLetra = /^[A-z]/;
	
	if (patronNum.test(abc)==true){
		validarNif(abc);
	} else if (patronLetra.test(abc)==true){
		validarCif(abc);
	} 

}
		

	
		var cont = 0;
		function crear_div() {
			cont++;
			cod++;
			//crea div
			var div1 = document.createElement('div');
			div1.setAttribute("id", "div_nomcto" + cont);
			div1.setAttribute("class", "col-lg-5 pull-left");
			
			var div2 = document.createElement('div');
			div2.setAttribute("id", "div_telcto" + cont);
			div2.setAttribute("class", "col-lg-3 pull-left");
			
			var div3 = document.createElement('div');
			div3.setAttribute("id", "div_emailcto" + cont);
			div3.setAttribute("class", "col-lg-4 pull-left");

			document.getElementById('div_nomcto').appendChild(div1);
			document.getElementById('div_nomcto').appendChild(div2);
			document.getElementById('div_nomcto').appendChild(div3);

			function crear_inputs(){
			
			
			//contador para que no haya ids ni nombres duplicacos
			
			
			
			
			//creacion de saltos de línea para tener salto de linea entre los inputs
			var salto_linea1 = document.createElement('br');
			salto_linea1.setAttribute("id","primer_salto" + cont);
			var salto_linea2 = document.createElement('br');
			salto_linea2.setAttribute("id","segundo_salto" + cont);
			var salto_linea3 = document.createElement('br');
			salto_linea3.setAttribute("id","tercer_salto" + cont);

			//label con el nombre
			var lbl_nombre = document.createElement('label');
			lbl_nombre.setAttribute("id", "nombre" + cont);
  			lbl_nombre.innerHTML = 'Nombre';

  			//label con el telefono
			var lbl_tel = document.createElement('label');
			lbl_tel.setAttribute("id", "tel" + cont);
  			lbl_tel.innerHTML = 'Telefono';
  			
  			//label con el nombre
			var lbl_mail = document.createElement('label');
			lbl_mail.setAttribute("id", "mail" + cont);
  			lbl_mail.innerHTML = 'E-mail';

			//campo oculton para meter valor de codigo de contactos
			var text_codcto = document.createElement('input');
			text_codcto.setAttribute("type","hidden");
			text_codcto.setAttribute("name","id_cto" + cont);
			text_codcto.setAttribute("id","id_cto" + cont);
			text_codcto.setAttribute("value",cod);


			//creacion de input para nombre de contacto y sus correspondientes atributos
			var text_nomcto = document.createElement('input');
			text_nomcto.setAttribute("type","text");
			text_nomcto.setAttribute("class","form-control");
			text_nomcto.setAttribute("id","nombre_cto" + cont);
			text_nomcto.setAttribute("placeholder","NOMBRE Y APELLIDOS");
			text_nomcto.setAttribute("maxlength","45");
			text_nomcto.setAttribute("name","nombre_cto" + cont);

			//creacion de input para telefono de contacto y sus correspondientes atributos
			var text_telcto = document.createElement('input');
			text_telcto.setAttribute("type","tel");
			text_telcto.setAttribute("class","form-control");
			text_telcto.setAttribute("id","tlf_cto" + cont);
			text_telcto.setAttribute("placeholder","Teléfono o móvil");
			text_telcto.setAttribute("maxlength","9");
			text_telcto.setAttribute("name","tlf_cto" + cont);

			//creacion de input para email de contacto y sus correspondientes atributos
			var text_emailcto = document.createElement('input');
			text_emailcto.setAttribute("type","email");
			text_emailcto.setAttribute("class","form-control");
			text_emailcto.setAttribute("id","email_cto" + cont);
			text_emailcto.setAttribute("placeholder","email@ejemplo.com");
			text_emailcto.setAttribute("name","email_cto" + cont);

			//Aqui introducimos los inputs hijos creados dentros de sus respectivos padres ya existentes en el codigo HTML
			
			document.getElementById('div_nomcto' + cont).appendChild(salto_linea1);
			document.getElementById('div_nomcto' + cont).appendChild(text_codcto);
			document.getElementById('div_nomcto' + cont).appendChild(lbl_nombre);
			document.getElementById('div_nomcto' + cont).appendChild(text_nomcto);
			document.getElementById('div_telcto' + cont).appendChild(salto_linea2);
			document.getElementById('div_telcto' + cont).appendChild(lbl_tel);
			document.getElementById('div_telcto' + cont).appendChild(text_telcto);
			document.getElementById('div_emailcto' + cont).appendChild(salto_linea3);
			document.getElementById('div_emailcto' + cont).appendChild(lbl_mail);
			document.getElementById('div_emailcto' + cont).appendChild(text_emailcto);

			//aumentamos el valor del contador
			document.getElementById('contador').value = cont;
		}

			crear_inputs();
		}

		

		function remover_inputs(){
			//Si contador mayor que cero se procede a borrar los ultimos inputs
			if (cont > 0){
				var salto1 = document.getElementById('primer_salto' + cont);
				var salto2 = document.getElementById('segundo_salto' + cont);
				var salto3 = document.getElementById('tercer_salto' + cont);
				var id_cto = document.getElementById('id_cto' + cont);
				var lbl_nombre = document.getElementById('nombre' + cont);
				var nom_cto = document.getElementById('nombre_cto' + cont);
				var lbl_tel = document.getElementById('tel' + cont);
				var tlf_cto = document.getElementById('tlf_cto' + cont);
				var lbl_mail = document.getElementById('mail' + cont);
				var email_cto = document.getElementById('email_cto' + cont);
				


				salto1.parentNode.removeChild(salto1);
				salto2.parentNode.removeChild(salto2);
				salto3.parentNode.removeChild(salto3);
				id_cto.parentNode.removeChild(id_cto);
				lbl_nombre.parentNode.removeChild(lbl_nombre)
				nom_cto.parentNode.removeChild(nom_cto);
				lbl_tel.parentNode.removeChild(lbl_tel);
				tlf_cto.parentNode.removeChild(tlf_cto);
				lbl_mail.parentNode.removeChild(lbl_mail);
				email_cto.parentNode.removeChild(email_cto);

				cont--;
				cod--;
				//disminuimos el valor del contador
				document.getElementById('contador').value = cont;
			}
			
		}
function mostrar(sel){
			if (sel.value=="dni/cif"){
				document.getElementById('txt_dnicif').style.display = 'block';
			}else{
				document.getElementById('txt_dnicif').style.display = 'none';
			}
			if (sel.value=="nombre"){
				document.getElementById('txt_nombre').style.display = 'block';
			}else{
				document.getElementById('txt_nombre').style.display = 'none';
			}
			if (sel.value=="domicilio"){
				document.getElementById('txt_domicilio').style.display = 'block';
			}else{
				document.getElementById('txt_domicilio').style.display = 'none';
			}
			if (sel.value=="localidad"){
				document.getElementById('txt_localidad').style.display = 'block';
			}else{
				document.getElementById('txt_localidad').style.display = 'none';
			}
		}

		function abrir_cli(){
			document.form_listar.submit();
		}

function mostrar_btn_add(){
			
				document.getElementById('anadir_contacto').style.display = 'block';
				document.getElementById('modificar_contacto').style.display = 'none';
				document.getElementById('nombre_cto').disabled = true;

		}

		function mostrar_btn_mod(){
			
				document.getElementById('anadir_contacto').style.display = 'none';
				document.getElementById('modificar_contacto').style.display = 'block';
				document.getElementById('nombre_cto').disabled = false;
		
		}

		function cargar(){
   		location.reload();
		}



