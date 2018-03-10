function loadChipTable() {
  getData("api/getThings.php?thing=chips", createChipTable)
}

function createChipTable(incomingJSON) {
  var theObject = JSON.parse(incomingJSON);
  var theTable = document.createElement("div");
  document.getElementById("ChipTableSection").replaceChild(theTable, document.getElementById("ChipTable"));
  theTable.setAttribute("id", "ChipTable");
  var theRow;
  
  for (var i=0; i<theObject.length; i++) {
    var singleRow = theObject[i];
    if ($("#" + "ChipUser" + singleRow.idOwner).length === 0) {
      theRow = document.createElement("div");
      theTable.append(theRow);
      theRow.setAttribute("id", "ChipUser" + singleRow.idOwner);
      theRow.setAttribute("class", "UserRow UserRow-Chips");
      theNameBox = document.createElement("div");
      theNameBox.setAttribute("class", "NameBox NameBox-Chips");
      theRow.append(theNameBox);
      theName = document.createTextNode(singleRow.firstName + " " + singleRow.lastName);
      theNameBox.append(theName);
      theChipBox = document.createElement("div");
      theChipBox.setAttribute("id", "ChipsFor" + singleRow.idOwner);
    } else {
      theRow = document.getElementById("ChipUser" + singleRow.idOwner);
      theChipBox = document.getElementById("Chips" + singleRow.idOwner);
    }
    
    var singleChip = document.createElement("div");
    theRow.append(singleChip);
    singleChip.setAttribute("id", "Chip" + singleRow.id);
    singleChip.setAttribute("class", "chip chip-" + singleRow.color)
    singleChip.setAttribute("onclick", "spendChip(" + singleRow.id + ")")
    singleChip.setAttribute("title", "Spend This Chip (Chip ID " + singleRow.id + ")");
  }
  
  return false;
}

function giveThisUserAChip() {
  var dd = document.getElementById("userDropDown");
  getData("api/addThings.php?thing=chips&idUser=" + dd.options[dd.selectedIndex].value, giveChipFeedback);
}

function giveThisUserASpecificChip(color) {
  var dd = document.getElementById("userDropDown");
  getData("api/addThings.php?thing=chips&idUser=" + dd.options[dd.selectedIndex].value + "&color=" + color, giveChipFeedback);
}


function giveChipFeedback(incomingString) {
  giveFeedback(incomingString, "giveChipMessage", loadChipTable);
}

function spendChip(idChip) {
  var chipDiv = document.getElementById("Chip" + idChip);
  chipDiv.innerText = "";
  chipDiv.setAttribute("class", "spent");
  getData("api/spendThings.php?thing=chips&idChip=" + idChip, spendChipFeedback);
}

function spendChipFeedback(incomingString) {
  giveFeedback(incomingString, "spendChipMessage", loadChipTable);
}