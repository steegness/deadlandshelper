function createUserDropdown(incomingJSON) {
  userList = JSON.parse(incomingJSON);
  ddDiv = document.getElementById("UserDropDownSection");
  var theDropdown = document.createElement("select");
  ddDiv.append(theDropdown);
  theDropdown.setAttribute("id", "userDropDown");
  
  for (var i=0; i<userList.length; i++) {
    var singleRow = userList[i];
    var userOption = document.createElement("option");
    theDropdown.append(userOption);
    userOption.setAttribute("value", singleRow.id);
    theName = document.createTextNode(singleRow.firstName + " " + singleRow.lastName);
    userOption.append(theName);
  }
}

function loadUserDropdown() {
  getData("api/getThings.php?thing=users", createUserDropdown)
}