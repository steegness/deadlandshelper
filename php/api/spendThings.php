<?php
require_once("../database.php");
require_once("../utility.php");

function spendWhatever($sql) {
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
    echo(spendWhatever(sql_spendCard(requestVar("idCard"))));
    break;
  case "chips":
    echo(spendWhatever(sql_spendChip(requestVar("idChip"))));
    break;
  default:
    echo("FAILURE");
}