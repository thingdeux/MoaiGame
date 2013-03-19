module(..., package.seeall);

function loadLevel()
  map = MOAIGrid.new()
  map:initRectGrid( 20, 16, 64, 64)
  map:setRow(1, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96,96,96,96,96,96)
  --map:setRow(2)
  --map:setRow(3, 0x0b)

  --map:setRow(2, 0xc2, 0x0b, 0x0c, 0x0d, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x92, 0x0b, 0x0d, 0x0b, 0x0b)
  --map:setRow(3, 0xc2)
  --map:setRect(10, 10, 20, 20)


  mapTileDeck = MOAITileDeck2D.new()
  mapTileDeck:setTexture(values.backgroundtilesheetlocation)
  mapTileDeck:setSize(16,16)

  map_Prop = MOAIProp2D.new()
  map_Prop:setDeck( mapTileDeck )
  map_Prop:setGrid( map )
  map_Prop:setLoc(-640,-525)

  layer:insertProp( map_Prop )


end