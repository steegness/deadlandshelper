function loadCardTable() {
  getData("api/getThings.php?thing=cards", createCardTable)
}

function createCardTable(incomingJSON) {
  var theObject = JSON.parse(incomingJSON);
  var theTable = document.createElement("div");
  document.getElementById("CardTableSection").replaceChild(theTable, document.getElementById("CardTable"));
  theTable.setAttribute("id", "CardTable");
  var theRow;
  
  for (var i=0; i<theObject.length; i++) {
    var singleRow = theObject[i];
    if ($("#" + "CardUser" + singleRow.idOwner).length === 0) {
      theRow = document.createElement("div");
      theTable.append(theRow);
      theRow.setAttribute("id", "CardUser" + singleRow.idOwner);
      theRow.setAttribute("class", "CardUserRow playingCards simpleCards");
      theNameBox = document.createElement("div");
      theNameBox.setAttribute("class", "NameBox");
      theRow.append(theNameBox);
      theName = document.createTextNode(singleRow.firstName + " " + singleRow.lastName);
      theNameBox.append(theName);
      theCardBox = document.createElement("div");
      theCardBox.setAttribute("id", "Cards" + singleRow.idOwner);
    } else {
      theRow = document.getElementById("CardUser" + singleRow.idOwner);
      theCardBox = document.getElementById("Cards" + singleRow.idOwner);
    }
    var singleCard = cardElement(singleRow.value, singleRow.suit, singleRow.id);
    singleCard.setAttribute("onclick", "spendCard(" + singleRow.id + ")")
    singleCard.setAttribute("title", "Spend this card");
    theRow.append(singleCard); 
  }
}

function giveThisUserACard() {
  var dd = document.getElementById("userDropDown");
  getData("api/addThings.php?thing=cards&idUser=" + dd.options[dd.selectedIndex].value, giveCardFeedback);
}

function giveCardFeedback(incomingString) {
  giveFeedback(incomingString, "giveCardMessage", loadCardTable);
}

function suitName(suit) {
  switch (suit) {
    case 'C':
      return "clubs";
    case 'D':
      return "diams";
    case 'H':
      return "hearts";
    case 'S':
      return "spades";
    case "B":
      return 'little;';
    case "R":
      return 'big';
    default:
      return "error";
  }
}

function suitPicture(suit) {
  switch (suit) {
    case "C":
      return '&clubs;';
    case "D":
      return '&diams;';
    case "H":
      return '&hearts;';
    case "S":
      return '&spades;';
    case "B":
      return 'Black';
    case "R":
      return 'Red';
    default:
      return '&oslash;';
  }
}

function cardElement(rank, suit, idCard) {
  
  //returns an div element to be added to a hand
  var theCard = document.createElement("div");
  var classToSet = "card ";
  if (rank == "X") {
    classToSet = classToSet + "joker ";
  } else {
    classToSet = classToSet + "rank-" + rank.toLowerCase() + " ";
  }
  classToSet = classToSet + suitName(suit);
  theCard.setAttribute("class", classToSet);
  theCard.setAttribute("id", "Card" + idCard);
  var rankSpan = document.createElement("span");
  theCard.append(rankSpan);
  rankSpan.setAttribute("class", "rank");
  var rankText = document.createTextNode(rank);
  rankSpan.append(rankText)
  var suitSpan = document.createElement("span");
  theCard.append(suitSpan);
  suitSpan.setAttribute("class", "suit");
  suitSpan.innerHTML = suitPicture(suit);
  var idSpan = document.createElement("span");
  theCard.append(idSpan);
  var idText = document.createTextNode(idCard);
  idSpan.append(idText);
  idSpan.setAttribute("class", "CardId");
  
  return theCard;
  
}

function spendCard(idCard) {
  var cardDiv = document.getElementById("Card" + idCard);
  cardDiv.innerText = "";
  cardDiv.setAttribute("class", "spent");
  getData("api/spendThings.php?thing=cards&idCard=" + idCard, spendCardFeedback);
}

function spendCardFeedback(incomingString) {
  giveFeedback(incomingString, "spendCardMessage", loadCardTable);
}

function reshuffleAllCards() {
  getData("api/resetThings.php?thing=cards", reshuffleCardsFeedback);
}

function reshuffleCardsFeedback(incomingString) {
  giveFeedback(incomingString, "reshuffleMessage", loadCardTable);
}