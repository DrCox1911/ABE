require "BuildingObjects/ISBuildUtil";
require "BuildingObjects/ISWoodenWall";
require "BuildingObjects/ISDoubleTileFurniture";
require "BuildingObjects/ISDoubleDoor";
require "bcUtils";

-- Hotfixes
buildUtil.setInfo = function(javaObject, ISItem) 
	if  javaObject.setCanPassThrough     then  javaObject:setCanPassThrough(ISItem.canPassThrough or false);        end
	if  javaObject.setCanBarricade       then  javaObject:setCanBarricade(ISItem.canBarricade or false);            end
	if  javaObject.setThumpDmg           then  javaObject:setThumpDmg(ISItem.thumpDmg or false);                    end
	if  javaObject.setIsContainer        then  javaObject:setIsContainer(ISItem.isContainer or false);              end
	if  javaObject.setIsDoor             then  javaObject:setIsDoor(ISItem.isDoor or false);                        end
	if  javaObject.setIsDoorFrame        then  javaObject:setIsDoorFrame(ISItem.isDoorFrame or false);              end
	if  javaObject.setCrossSpeed         then  javaObject:setCrossSpeed(ISItem.crossSpeed or 1);                    end
	if  javaObject.setBlockAllTheSquare  then  javaObject:setBlockAllTheSquare(ISItem.blockAllTheSquare or false);  end
	if  javaObject.setName               then  javaObject:setName(ISItem.name or "Object");                         end
	if  javaObject.setIsDismantable      then  javaObject:setIsDismantable(ISItem.dismantable or false);            end
	if  javaObject.setCanBePlastered     then  javaObject:setCanBePlastered(ISItem.canBePlastered or false);        end
	if  javaObject.setIsHoppable         then  javaObject:setIsHoppable(ISItem.hoppable or false);                  end
	if  javaObject.setModData            then  javaObject:setModData(bcUtils.cloneTable(ISItem.modData));           end
	if  javaObject.setIsThumpable        then  javaObject:setIsThumpable(ISItem.isThumpable or true);               end

	if ISItem.containerType and javaObject:getContainer() then
		javaObject:getContainer():setType(ISItem.containerType);
	end
	if ISItem.canBeLockedByPadlock then
		javaObject:setCanBeLockByPadlock(ISItem.canBeLockedByPadlock);
	end
end

function ISDoubleTileFurniture:setInfo(square, north, sprite) 
	-- add furniture to our ground
	local thumpable = IsoThumpable.new(getCell(), square, sprite, north, self);
	-- name of the item for the tooltip
	buildUtil.setInfo(thumpable, self);
	-- the furniture have 200 base health + 100 per carpentry lvl
	thumpable:setMaxHealth(self:getHealth());
	-- the sound that will be played when our furniture will be broken
	thumpable:setBreakSound("breakdoor");
	square:AddSpecialObject(thumpable);
	thumpable:transmitCompleteItemToServer();

	self.javaObject = thumpable;
end

function ISWoodenStairs:setInfo(square, level, north, sprite, luaobject) 
	-- add stairs to our ground
	local pillarSprite = self.pillar;
	if north then
		pillarSprite = self.pillarNorth;
	end
	local thumpable = square:AddStairs(north, level, sprite, pillarSprite, luaobject);
	-- recalc the collide
	square:RecalcAllWithNeighbours(true);
	-- name of the item for the tooltip
	thumpable:setName("Wooden Stairs");
	-- we can't barricade/unbarricade the stairs
	thumpable:setCanBarricade(false);
	thumpable:setIsDismantable(true);
	-- the stairs have 500 base health + 100 per carpentry lvl
	thumpable:setMaxHealth(self:getHealth());
	thumpable:setIsStairs(true);
	thumpable:setIsThumpable(false)
	-- the sound that will be played when our stairs will be broken
	thumpable:setBreakSound("breakdoor");
	thumpable:setModData(copyTable(self.modData))
	thumpable:transmitCompleteItemToServer();

	self.javaObject = thumpable;
end


ABEObject = ISBuildingObject:derive("ABEObject");
ABEObject.addWoodXpOriginal = buildUtil.addWoodXp;
buildUtil.addWoodXp = function(ISItem)
	if ISItem.recipe then
		return;
	end
	ABEObject.addWoodXpOriginal(ISItem);
end

function ABEObject:create(x, y, z, north, sprite) 
  local cell = getWorld():getCell();
  self.sq = cell:getGridSquare(x, y, z);

  self.javaObject = IsoThumpable.new(cell, self.sq, "empty", north, self);
  buildUtil.setInfo(self.javaObject, self);
  self.javaObject:setBreakSound("breakdoor");
	self.sq:AddSpecialObject(self.javaObject);

  self.javaObject:transmitCompleteItemToServer();
	self.modData = self.javaObject:getModData();
	self.modData.recipe = bcUtils.cloneTable(self.recipe);
	self.modData.recipe.started = true;
	self.modData.recipe.ingredientsAdded = {};
	self.modData.recipe.x = x;
	self.modData.recipe.y = y;
	self.modData.recipe.z = z;
	self.modData.recipe.north = north;
	self.modData.recipe.sprite = sprite;
	self.modData.recipe.data.nSprite = self.nSprite; -- cheating ;)
	self.modData.recipe.usesLeft = {}
	
	for k,v in pairs(self.modData.recipe.ingredients) do
		self.modData.recipe.ingredientsAdded[k] = 0;
	end
	
	if self.recipe.use then
		for item,amount in pairs(self.recipe.use) do
			self.modData.recipe.usesLeft[item] = amount;
		end
	end

	self.javaObject:setOverlaySprite(self:getSprite(), 0, 1, 1, 0.6, true);
end 
function ABEObject:tryBuild(x, y, z) 
	-- We're just a 'plan' thingie with little to no effect on the world.
	-- Just place the item...
	-- What could possibly go wrong?
	self:create(x, y, z, self.north, self:getSprite());
end

function ABEObject:new(recipe) 
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o.recipe = recipe;

	local images = ABE.getImages(getPlayer(), recipe);
	o:setSprite(images.west);
	o:setNorthSprite(images.north);
	o:setEastSprite(images.east);
	o:setSouthSprite(images.south);

	o.name = o.recipe.name;

	o.canBarricade = false;
	o.canPassThrough = true;
	o.blockAllTheSquare = true;
	o.dismantable = false;
	o.renderFloorHelper = recipe.data.renderFloorHelper or false;
	o.canBeAlwaysPlaced = recipe.data.canBeAlwaysPlaced or false;
	o.needToBeAgainstWall = recipe.data.needToBeAgainstWall or false;
	o.isValid = _G[recipe.resultClass].isValid;
	o.noNeedHammer = true; -- do not need a hammer to _start_, but maybe later to _build_

	if (o.recipe.resultClass == "ISDoubleTileFurniture") then
		o.getSquare2Pos = ISDoubleTileFurniture.getSquare2Pos;
	elseif (o.recipe.resultClass == "ISDoubleDoor") then
		local sprite = o.recipe.spriteMulti;
		local spriteIndex = o.recipe.spriteIndex;
		o.getSquare2Pos = ISDoubleDoor.getSquare2Pos;
		o.getSquare3Pos = ISDoubleDoor.getSquare3Pos;
		o.getSquare4Pos = ISDoubleDoor.getSquare4Pos;

		o.partExists = ISDoubleDoor.partExists;

		o:setSprite(sprite .. spriteIndex);
		o.sprite2 = sprite .. spriteIndex+1;
		o.sprite3 = sprite .. spriteIndex-8;
		o.sprite4 = sprite .. spriteIndex-7;
		o.northSprite = sprite .. spriteIndex-6;
		o.northSprite2 = sprite .. spriteIndex-5;
		o.northSprite3 = sprite .. spriteIndex+2;
		o.northSprite4 = sprite .. spriteIndex+3;
	else
		o.getSquare2Pos = ISWoodenStairs.getSquare2Pos; -- dirty hack :-(
		o.getSquare3Pos = ISWoodenStairs.getSquare3Pos;
	end
	return o;
end 

function ABEObject:render(x, y, z, square) 
	local data = {};
	data.x = x;
	data.y = y;
	data.z = z;
	data.square = square;
	data.done = false;
	triggerEvent("WorldCraftingRender", self, data);
	if data.done then return end

	ISBuildingObject.render(self, x, y, z, square);
	--local sprite = IsoSprite.new()
	--sprite:LoadFramesNoDirPageSimple(self:getModData()["recipe"].sprite)
	--sprite:LoadFramesNoDirPageSimple(self.recipe.sprite)
	--sprite:RenderGhostTile(x, y, z)
end

ABEObject.renderISDoubleFurniture = function(self, data) 
	local md = self.recipe;
	if md.resultClass ~= "ISDoubleTileFurniture" then return end;

	local images = ABE.getImages(getPlayer(), self.recipe);
	for k,v in pairs(images) do
		if not self[k] then
			self[k] = v
		end
	end
	data.done = true;
	ISDoubleTileFurniture.render(self, data.x, data.y, data.z, data.square);
	return;
end

ABEObject.renderISWoodenStairs = function(self, data) 
	local md = self.recipe;
	if md.resultClass ~= "ISWoodenStairs" then return end;

	local images = ABE.getImages(getPlayer(), self.recipe);
	for k,v in pairs(images) do
		if not self[k] then
			self[k] = v
		end
	end
	data.done = true;
	ISWoodenStairs.render(self, data.x, data.y, data.z, data.square);
	return;
end

ABEObject.renderISDoubleDoor = function(self, data)
	local md = self.recipe;
	if md.resultClass ~= "ISDoubleDoor" then return end;

	local images = ABE.getImages(getPlayer(), self.recipe);
	for k,v in pairs(images) do
		if not self[k] then
			self[k] = v
		end
	end
	data.done = true;
	ISDoubleDoor.render(self, data.x, data.y, data.z, data.square);
	return;
end



LuaEventManager.AddEvent("WorldCraftingRender");
Events.WorldCraftingRender.Add(ABEObject.renderISDoubleFurniture);
Events.WorldCraftingRender.Add(ABEObject.renderISWoodenStairs);
Events.WorldCraftingRender.Add(ABEObject.renderISDoubleDoor);
