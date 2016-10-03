<?php
/*
*Configuracion de la base de datos
-----------------------------------*/
//database server
define('SERVER', "");
//database port
define('PORT', "");
//database login name
define('USER', "");
//database login password
define('PASS', "");
//database name
define('DATABASE', "");
/*Fin configuracion de la base de datos
-----------------------------------*/
define('DOCUMENT_ROOT',$_SERVER["DOCUMENT_ROOT"]."/");
$base = ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] && ! in_array(strtolower($_SERVER['HTTPS']), array( 'off', 'no' ))) ? 'https' : 'http') . '://' . $_SERVER['HTTP_HOST']."/";
define('ROOT',$base);
?>