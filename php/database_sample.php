<?php
//copy this file, change these values, and rename the copy as "database.php".
$db = mysqli_connect("server", "username", "password", "databasename");  

function sql_getUserList() {
	$sql = "
SELECT
	users.id,
	users.firstName,
	users.lastName
FROM
	users
ORDER BY
	users.lastName
	";
	return $sql;
}

function sql_getAllOwnedChips() {
  $sql = "
SELECT
  chips.id,
  chips.color,
  chips.idOwner,
  users.firstName,
  users.lastName,
  CASE when chips.lastUpdated = mostRecentChipDateTime() THEN 'true' ELSE 'false' END as mostRecentUpdate
FROM
  chips
  INNER JOIN users on users.id = chips.idOwner
WHERE
  idOwner is not null
ORDER BY
  users.lastName,
  chips.color DESC
  ";
  return $sql;
}

function sql_getAllOwnedCards() {
  $sql = "
SELECT
  cards.id,
  cards.rank,
  cards.value,
  cards.suit,
  cards.idOwner,
  users.firstName,
  users.lastName
FROM
  cards
  INNER JOIN users on users.id = cards.idOwner
WHERE
  idOwner is not null
ORDER BY
  users.lastName,
  cards.id
  ";
  return $sql;
}

function sql_assignRandomChipToUser($idUser) {
  $sql = "
SET @ruc := randomUnownedChip();
UPDATE chips
SET 
  idOwner = " . $idUser . ", 
  lastUpdated = CURRENT_TIMESTAMP
WHERE id = @ruc;
  ";
  return $sql;
}

function sql_assignSpecificChipToUser($idUser, $color) {
	$sql = "
SET @suc := specificUnownedColoredChip(\"" . $color . "\");
UPDATE chips
SET 
  idOwner = " . $idUser . ", 
  lastUpdated = CURRENT_TIMESTAMP
WHERE id = @suc;
	";
	return $sql;
}

function sql_assignRandomCardToUser($idUser) {
  $sql = "
SET @ruc := randomUnownedCard();
UPDATE cards
SET 
  idOwner = " . $idUser . ", 
  lastUpdated = CURRENT_TIMESTAMP
WHERE id = @ruc;
  ";
  return $sql;
}

function sql_spendChip($idChip) {
  $sql = "
UPDATE chips
SET
  idOwner = NULL,
  lastUpdated = CURRENT_TIMESTAMP
WHERE id = " . $idChip . "
  ";
  return $sql;
}

function sql_spendCard($idCard) {
  $sql = "
UPDATE cards
SET
  idOwner = NULL,
  lastUpdated = CURRENT_TIMESTAMP
WHERE id = " . $idCard . "
  ";
  return $sql;
}

function sql_reshuffleCards() {
  $sql = "
UPDATE cards
SET idOwner = NULL
  ";
  return $sql;
}

