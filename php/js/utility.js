function getData(url, callback) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      callback(this.responseText);
      return false;
    }
  };
  xhttp.open("GET", url, true);
  xhttp.send();
}

function giveFeedback(incomingString, targetElementId, callback) {
  var msgarea = document.getElementById(targetElementId);
  $("#" + targetElementId).hide();
  msgarea.innerText = incomingString;
  $("#" + targetElementId).fadeIn(1000);
  if (callback !== null) {
    setTimeout(function() { $("#" + targetElementId).fadeOut(); callback(); }, 5000);
  } else {
    setTimeout(function() { $("#" + targetElementId).fadeOut(); }, 5000);
  }
  return false;
}