<!DOCTYPE html>
<html lang="es">
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html ; charset=UTF-8">
 <title>Gesti&oacuten Comercia - Login</title>
  <link href="css/bootstrap.css" rel="stylesheet" type="txt/css">
  <link href="css/login.css" rel="stylesheet" type="txt/css">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

  <div class="jumbotron boxlogin">  
    <form action="iniciosesion.asp" method="POST" name="form_login" id="form_login">
      <img src="img/moneleg.gif" class="img-responsive" alt="Responsive image" hspace="50px"> 
        <label>Nombre Usuario:</label>    
        <input type="text" name="username" size="10" maxlength="50" class="form-control" autofocus>
        <label>Contraseña:</label>
        <input type="password" name="password" maxlength="9" class="form-control">
        <input type="submit" name="login" value="Iniciar" class="btn btn-success">
     </form>
</div>

</body>
</html>