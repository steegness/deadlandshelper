<?php
require_once("../database.php");
require_once("../utility.php");

function addWhatever($sql) {
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
    echo(addWhatever(sql_assignRandomCardToUser(requestVar("idUser"))));
    break;
  case "chips":
    if (requestVar("color")) {
      echo(addWhatever(sql_assignSpecificChipToUser(requestVar("idUser"), requestVar("color"))));
    } else {
      echo(addWhatever(sql_assignRandomChipToUser(requestVar("idUser"))));
    }
    break;
  default:
    echo("FAILURE");
}