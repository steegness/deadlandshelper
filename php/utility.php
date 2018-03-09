<?php

function sanitize($input) {
  $data = trim($input);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

function requestVar($var, $default = NULL) {
  if (isset($_REQUEST[$var])) {
    return sanitize($_REQUEST[$var]);
  } else {
    return $default;
  }
}