<!-- Reads back the input command
 for debugging purposes only -->
<?php
if(isset($_POST['pass'])){
    echo($_POST['pass']);
} else {
    $self = file_get_contents(__FILE__);
    echo htmlspecialchars($self);
}
?>