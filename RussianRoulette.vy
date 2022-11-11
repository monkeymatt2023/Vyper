players: DynArray[address, 100]
loser: DynArray[address, 100]
odds: public(uint256)
playersTurn: public(uint256)
creator: public(address)

@external
def __init__():
    self.creator = msg.sender
    self.odds = 0
    self.playersTurn = 0

@external
def setOdds(oneInThisMany: uint256):
    if self.creator == msg.sender:
        self.odds = oneInThisMany

@external
def addPlayer(Player: address):
    assert Player not in self.players
    assert Player not in self.losers
    self.players.append(Player)

@internal
def lose(Player: address):
    self.losers.append(Player)
    for i in range(len(players)):
        self.players.pop()

@internal
def random() -> uint256:
    assert self.odds > 0
    return block.number % self.odds

@external
def play():
    num: uint256 = self.random()
    if (num == 1):
        self.lose(self.players[self.playersTurn])
    else:
        self.playersTurn += 1

@external
def isALoser(person: address):
    assert person in self.losers
