<?php
require_once("../database.php");
require_once("../utility.php");

function resetWhatever($sql) {
  global $db;
  $result = mysqli_multi_query($db, $sql);
  if ($result) {
    $returnValue = "SUCCESS";
  } else {
    $returnValue = "FAILURE";
  }
  return $returnValue;
}

switch (requestVar("thing")) {
  case "cards":
    echo(resetWhatever(sql_reshuffleCards()));
    break;
  default:
    echo("FAILURE");
}