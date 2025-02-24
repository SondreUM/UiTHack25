<?php
# Reads back the input command
# for debugging purposes only -->
if(isset($_POST['password'])){
    #@eval($_POST['password']);
    echo($_POST['password']);
} else {
    $self = file_get_contents(__FILE__);
    echo htmlspecialchars($self);
}
?>