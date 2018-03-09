<?php
require_once("../database.php");
require_once("../utility.php");

function getWhatever($sql) {
  global $db;
  $userArray = array();
  
  $result = mysqli_query($db, $sql);
  if ($result) {
    while ($row = mysqli_fetch_assoc($result)) {
      array_push($userArray, $row);
    }
  } else {
    return "FAILURE";
  }
  return json_encode($userArray);
}

switch (requestVar("thing")) {
  case "users":
    echo(getWhatever(sql_getUserList()));
    break;
  case "cards":
    echo(getWhatever(sql_getAllOwnedCards()));
    break;
  case "chips":
    echo(getWhatever(sql_getAllOwnedChips()));
    break;
  default:
    echo("FAILURE");
}