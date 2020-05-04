require "bcUtils_client"
require "BuildingObjects/ISBuildingObject" -- needed here because RainCollectorBarrel doesn't require() it
require "BuildingObjects/RainCollectorBarrel"

if not ABE then ABE = {} end
--[[
-- {{{
--To extend AbeObjs, just add to this object like this:
--Simple recipe:
--local recipe = {};
--recipe.name = "Makeshift chair";
--recipe.resultClass = "ISSimpleFurniture";
--recipe.images = { west = "chair_west", north = "chair_north", east = "chair_east", south = "chair_south" };
--recipe.tools = {}; -- no tools
--recipe.ingredients = { ["Base.Plank"] = 4, ["Base.RippedSheets"] = 4};
--recipe.requirements = { any = { any = { level = 0, time = 60, progress = 0 } } };
--table.insert(ABE.Recipes, recipe);
--
--More complex:
--local recipe = {};
--recipe.name = "Metal sheet wall";
--recipe.resultClass = "MyModMetalSheetWall";
--recipe.images = { west = "mymod_sheetwall_west", north = "mymod_sheetwall_north", east = nil, south = nil };
--recipe.tools = { "MyMod.Blowtorch", "MyMod.Simplegloves/MyMod.Workinggloves" }; -- require a blowtorch and either simple gloves or working gloves
--recipe.ingredients = { ["MyMod.Metalsheet"] = 4, ["MyMod.Blowtorchfuel"] = 1 };
--recipe.requirements = {
--	Engineer = {
--		Woodwork = { -- need an engineer with level 2 or better in woodwoorking for 600 minutes
--			level = 2,
--			time = 600,
--			progress = 0
--		}
--	},
--	Electrician = {
--		Electricity = { -- need an electrician with level 4 in electricity for 300 minutes
--			level = 4,
--			time = 300,
--			progress = 0
--		}
--	},
--	any = {
--		any = {
--			level = 0, -- need anyone else for 120 minutes
--			time = 120,
--			progress = 0
--		}
--	}
--};
--table.insert(ABE.Recipes, recipe);
-- }}}
--]] 

ABE.Recipes = { -- {{{

};
-- }}}

ABE.startAbeObj = function(player, recipe) -- {{{
	local abeObj = ABEObject:new(recipe);

	abeObj.player = player;
	getCell():setDrag(abeObj, player);
end
-- }}}
ABE.buildAbeObj = function(player, object) -- {{{
	ABE.consumeMaterial(player, object);
	if not luautils.walkAdj(getSpecificPlayer(player), object:getSquare()) then return end
	local ta = ABETA:new(player, object, false);
	ISTimedActionQueue.add(ta);
end
-- }}}
ABE.deconstructAbeObj = function(player, object) -- {{{
	if not luautils.walkAdj(getSpecificPlayer(player), object:getSquare()) then return end
	local ta = ABETA:new(player, object, true);
	ISTimedActionQueue.add(ta);
end
-- }}}
ABE.storeItemInformation = function(recipe, item) -- {{{
	-- Copout for now -- Build 34.13
	local data = {};

	if instanceof(item, "IsoWorldInventoryObject") then
		item = item:getItem();
	end

	if instanceof(item, "DrainableComboItem") then
		data.UsedDelta = item:getUsedDelta();
		data.UseDelta = item:getUseDelta();
	end

	if  item.getA                     then  data.A                     =  item:getA()                     end;
	if  item.getR                     then  data.R                     =  item:getR()                     end;
	if  item.getG                     then  data.G                     =  item:getG()                     end;
	if  item.getB                     then  data.B                     =  item:getB()                     end;
	if  item.getName                  then  data.Name                  =  item:getName()                  end;
	if  item.getReplaceOnUse          then  data.ReplaceOnUse          =  item:getReplaceOnUse()          end;
	if  item.getConditionMax          then  data.ConditionMax          =  item:getConditionMax()          end;
	if  item.getTexture               then  data.Texture               =  item:getTexture()               end;
	if  item.getTexturerotten         then  data.Texturerotten         =  item:getTexturerotten()         end;
	if  item.getTextureCooked         then  data.TextureCooked         =  item:getTextureCooked()         end;
	if  item.getTextureBurnt          then  data.TextureBurnt          =  item:getTextureBurnt()          end;
	if  item.getUses                  then  data.Uses                  =  item:getUses()                  end;
	if  item.getAge                   then  data.Age                   =  item:getAge()                   end;
	if  item.getLastAged              then  data.LastAged              =  item:getLastAged()              end;
	if  item.getCookingTime           then  data.CookingTime           =  item:getCookingTime()           end;
	if  item.getMinutesToCook         then  data.MinutesToCook         =  item:getMinutesToCook()         end;
	if  item.getMinutesToBurn         then  data.MinutesToBurn         =  item:getMinutesToBurn()         end;
	if  item.getOffAge                then  data.OffAge                =  item:getOffAge()                end;
	if  item.getOffAgeMax             then  data.OffAgeMax             =  item:getOffAgeMax()             end;
	if  item.getWeight                then  data.Weight                =  item:getWeight()                end;
	if  item.getActualWeight          then  data.ActualWeight          =  item:getActualWeight()          end;
	if  item.getWorldTexture          then  data.WorldTexture          =  item:getWorldTexture()          end;
	if  item.getDescription           then  data.Description           =  item:getDescription()           end;
	if  item.getCondition             then  data.Condition             =  item:getCondition()             end;
	if  item.getOffString             then  data.OffString             =  item:getOffString()             end;
	if  item.getCookedString          then  data.CookedString          =  item:getCookedString()          end;
	if  item.getUnCookedString        then  data.UnCookedString        =  item:getUnCookedString()        end;
	if  item.getBurntString           then  data.BurntString           =  item:getBurntString()           end;
	if  item.getModule                then  data.Module                =  item:getModule()                end;
	if  item.getBoredomChange         then  data.BoredomChange         =  item:getBoredomChange()         end;
	if  item.getUnhappyChange         then  data.UnhappyChange         =  item:getUnhappyChange()         end;
	if  item.getStressChange          then  data.StressChange          =  item:getStressChange()          end;
	if  item.getReplaceOnUseOn        then  data.ReplaceOnUseOn        =  item:getReplaceOnUseOn()        end;
	if  item.getCount                 then  data.Count                 =  item:getCount()                 end;
	if  item.getLightStrength         then  data.LightStrength         =  item:getLightStrength()         end;
	if  item.getLightDistance         then  data.LightDistance         =  item:getLightDistance()         end;
	if  item.getFatigueChange         then  data.FatigueChange         =  item:getFatigueChange()         end;
	if  item.getCurrentCondition      then  data.CurrentCondition      =  item:getCurrentCondition()      end;
	if  item.getCustomMenuOption      then  data.CustomMenuOption      =  item:getCustomMenuOption()      end;
	if  item.getTooltip               then  data.Tooltip               =  item:getTooltip()               end;
	if  item.getDisplayCategory       then  data.DisplayCategory       =  item:getDisplayCategory()       end;
	if  item.getHaveBeenRepaired      then  data.HaveBeenRepaired      =  item:getHaveBeenRepaired()      end;
	if  item.getReplaceOnBreak        then  data.ReplaceOnBreak        =  item:getReplaceOnBreak()        end;
	if  item.getDisplayName           then  data.DisplayName           =  item:getDisplayName()           end;
	if  item.getBreakSound            then  data.BreakSound            =  item:getBreakSound()            end;
	if  item.getAlcoholPower          then  data.AlcoholPower          =  item:getAlcoholPower()          end;
	if  item.getBandagePower          then  data.BandagePower          =  item:getBandagePower()          end;
	if  item.getReduceInfectionPower  then  data.ReduceInfectionPower  =  item:getReduceInfectionPower()  end;
	if  item.getContentsWeight        then  data.ContentsWeight        =  item:getContentsWeight()        end;
	if  item.getEquippedWeight        then  data.EquippedWeight        =  item:getEquippedWeight()        end;
	if  item.getUnequippedWeight      then  data.UnequippedWeight      =  item:getUnequippedWeight()      end;
	if  item.getKeyId                 then  data.KeyId                 =  item:getKeyId()                 end;
	if  item.getRemoteControlID       then  data.RemoteControlID       =  item:getRemoteControlID()       end;
	if  item.getRemoteRange           then  data.RemoteRange           =  item:getRemoteRange()           end;
	if  item.getExplosionSound        then  data.ExplosionSound        =  item:getExplosionSound()        end;
	if  item.getCountDownSound        then  data.CountDownSound        =  item:getCountDownSound()        end;
	if  item.getColorRed              then  data.ColorRed              =  item:getColorRed()              end;
	if  item.getColorGreen            then  data.ColorGreen            =  item:getColorGreen()            end;
	if  item.getColorBlue             then  data.ColorBlue             =  item:getColorBlue()             end;
	if  item.getEvolvedRecipeName     then  data.EvolvedRecipeName     =  item:getEvolvedRecipeName()     end;

	if not recipe.ingredientData then recipe.ingredientData = {} end
	if not recipe.ingredientData[item:getFullType()] then recipe.ingredientData[item:getFullType()]= {} end
	table.insert(recipe.ingredientData[item:getFullType()], data);
end
-- }}}
ABE.consumeMaterial = function(player, object) -- {{{ -- taken and butchered from ISBuildUtil
	player = getSpecificPlayer(player);
  local inventory = player:getInventory();
  local recipe = object:getModData()["recipe"];
  local removed = false;
	for part,amount in pairs(recipe.ingredients) do
		if not recipe.ingredientsAdded then recipe.ingredientsAdded = {}; end
		if not recipe.ingredientsAdded[part] then recipe.ingredientsAdded[part] = 0; end

		amount = amount - recipe.ingredientsAdded[part];
		local checkGround = 0;
		-- if we didn't have all the required material inside our inventory,
		-- it's because the missing materials are on the ground, we gonna check them
		if inventory:getNumberOfItem(part) < amount then
			checkGround = amount - inventory:getNumberOfItem(part);
		end
		for i=1,(amount - checkGround) do
			local item = inventory:FindAndReturn(part);
			ABE.storeItemInformation(recipe, item);
			inventory:Remove(item);
			recipe.ingredientsAdded[part] = recipe.ingredientsAdded[part] + 1;
		end

		-- for each missing material in inventory
		if checkGround > 0 then
			-- check a 3x3 square around the player
			for x=math.floor(player:getX())-1,math.floor(player:getX())+1 do
				for y=math.floor(player:getY())-1,math.floor(player:getY())+1 do
					local square = getCell():getGridSquare(x,y,math.floor(player:getZ()));
					local wobs = square and square:getWorldObjects() or nil;

					-- do we have the needed material on the ground ?
					if wobs ~= nil then
						local itemToRemove = {};
						for m=0, wobs:size()-1 do
							local o = wobs:get(m);
							if instanceof(o, "IsoWorldInventoryObject") and o:getItem():getFullType() == part then
								table.insert(itemToRemove, o);
								checkGround = checkGround - 1;
								if checkGround == 0 then
									break;
								end
							end
						end
						for i,v in pairs(itemToRemove) do
							ABE.storeItemInformation(recipe, v);
							square:transmitRemoveItemFromSquare(v);
							square:removeWorldObject(v);
							recipe.ingredientsAdded[part] = recipe.ingredientsAdded[part] + 1;
							removed = true
						end
						if checkGround == 0 then
							break;
						end
						itemToRemove = {};
					end
				end
				if checkGround == 0 then
					break;
				end
			end
		end
	end
	if removed then ISInventoryPage.dirtyUI() end
end
--}}}

ABE.makeTooltip = function(player, recipe) -- {{{
	local haveMat = ISBuildMenu.haveSomethingtoBuild(player);
	local projectTag = getText("Tooltip_ABE_Project");
	local toolTip = ISToolTip:new();
	toolTip:initialise();
	toolTip:setName(projectTag..": "..getText(recipe.name));
	local images = ABE.getImages(getSpecificPlayer(player), recipe);
	toolTip:setTexture(images.west);

	local desc = projectTag..": "..getText(recipe.name).." <LINE> ";

	local needsTools = false;
	for _,tools in pairs(recipe.tools) do
		if not needsTools then
			needsTools = true;
			desc = desc .. getText("Tooltip_ABE_NeedsTools")..": <LINE> ";
		end

		local first = true;
		desc = desc .. "  - ";
		for _,tool in pairs(bcUtils.split(tools, "/")) do
			local item = ABE.GetItemInstance(tool);
			if not first then
				desc = desc .. " / ";
			end
			local color = "";
			if ISBuildMenu.countMaterial(player, tool) <= 0 then
				color = " <RED> ";
			else
				color = " <GREEN> ";
			end
			desc = desc .. color..item:getDisplayName().." <RGB:1,1,1> ";
			first = false;
		end
		desc = desc .. " <LINE> ";
	end

	if recipe.started then
		-- Project on the ground
		desc = desc .. getText("Tooltip_ABE_NeedsParts")..": <LINE> ";
		for ing,amount in pairs(recipe.ingredients) do
			local color = "";
			local item = ABE.GetItemInstance(ing);
			
			local avail = ISBuildMenu.countMaterial(player, ing);
			if avail + (recipe.ingredientsAdded and recipe.ingredientsAdded[ing] or 0) < amount then
				color = " <RED> ";
			else
				color = " <GREEN> ";
			end
			desc = desc .. "  - "..color..item:getDisplayName()..": "..((recipe.ingredientsAdded and recipe.ingredientsAdded[ing]) or 0).."+"..avail.."/"..amount.." <RGB:1,1,1>  <LINE> ";
		end
	else
		-- Tooltip in build menu
		desc = desc .. getText("Tooltip_ABE_NeedsParts")..": <LINE> ";
		for ing,amount in pairs(recipe.ingredients) do
			local color = "";
			local item = ABE.GetItemInstance(ing);
			
			local avail = ISBuildMenu.countMaterial(player, ing); -- needs ISBuildMenu.materialOnGround above
			if (avail or 0) < amount then
				color = " <RED> ";
			else
				color = " <GREEN> ";
			end
			desc = desc .. "  - "..color..item:getDisplayName()..": "..(avail or 0).."/"..amount.." <RGB:1,1,1>  <LINE> ";
		end
	end

	for k,profession in pairs(recipe.requirements) do
		desc = desc .. getText("Tooltip_ABE_Profession")..": "..getText("Tooltip_ABE_Profession_"..k).." <LINE> ";
		for k,skill in pairs(profession) do
			if k ~= "any" then
				desc = desc .. getText("Tooltip_ABE_Skill").."  : "..getText("Tooltip_ABE_Skill_"..k).." Level "..skill["level"].." <LINE> ";
			end
			desc = desc .. getText("Tooltip_ABE_Progress").."    : "..skill["progress"].." / "..skill["time"].." <LINE> ";
		end
	end

	toolTip.description = desc;

	return toolTip;
end
-- }}}

ABE.GetItemInstance = function(type) -- {{{ taken from ISCraftingUI.lua
	if not ABE.ItemInstances then ABE.ItemInstances = {} end
	local item = ABE.ItemInstances[type];
	if not item then
		item = InventoryItemFactory.CreateItem(type);
		if item then
			ABE.ItemInstances[type] = item;
			ABE.ItemInstances[item:getFullType()] = item;
		else
			print("ERROR! Item not found: "..type);
		end
	end
	return item;
end
-- }}}

ABE.sanitizeRecipe = function(recipe) -- {{{
	-- do some sanity checks that modders / devs might forget / omit
	for pkey,pval in pairs(recipe.requirements) do
		for skey,sval in pairs(pval) do
			sval.progress = sval.progress or 0;
		end
	end
	if not recipe.tools then
		recipe.tools = {};
	end
	if not recipe.data then
		recipe.data = {};
	end
	if not recipe.data.modData then
		recipe.data.modData = {};
	end
end
-- }}}

ABE.WorldMenu = function(player, context, worldObjects) -- {{{
-- worldObjects passed here are b0rked. Work around it.
	local firstObject;
	for _,o in ipairs(worldObjects) do
		if not firstObject then firstObject = o; end
	end
	worldObjects = firstObject:getSquare():getObjects();

	for i=0,worldObjects:size()-1 do
		local object = worldObjects:get(i);
		if instanceof(object, "IsoThumpable") then
			local md = object:getModData();
			if md.recipe then
				local o = context:addOption(getText("ContextMenu_ContinueABEObj").." "..getText(md.recipe.name), player, ABE.buildAbeObj, object);
				o.toolTip = ABE.makeTooltip(player, md.recipe);
				local o = context:addOption(getText("ContextMenu_DeconstructABEObj").." "..getText(md.recipe.name), player, ABE.deconstructAbeObj, object);
				o.toolTip = ABE.makeTooltip(player, md.recipe);
			end
		end
	end

	local subMenu = ISContextMenu:getNew(context);
	local buildOption = context:addOption(getText("ContextMenu_MainABEEntry"));
	context:addSubMenu(buildOption, subMenu);

	ABE.doMenuRecursive(subMenu, ABE.Recipes, player);
end
-- }}}
ABE.doMenuRecursive = function(menu, recipes, player) -- {{{
	for name,recipe in pairs(recipes) do
		--print(name)
		--print(recipe)
		if name ~= "isCategory" then

			if recipe.isCategory then
				local subMenu = ISContextMenu:getNew(menu);
				local subMenuOption = menu:addOption(getText(name));
				menu:addSubMenu(subMenuOption, subMenu);
				ABE.doMenuRecursive(subMenu, recipe, player);
			else
				ABE.sanitizeRecipe(recipe);
				local o = menu:addOption(getText(name), player, ABE.startAbeObj, recipe);
				o.toolTip = ABE.makeTooltip(player, recipe);
			end
		end

	end
end
-- }}}
Events.OnFillWorldObjectContextMenu.Add(ABE.WorldMenu);
--Events.OnFillWorldObjectContextMenu.Remove(ISBuildMenu.doBuildMenu);

--[[ TODO
function ABE.loadGridsquare(square)
	if not isClient() then return; end
	-- does this square have a ABE
	for i=0,square:getObjects():size()-1 do
		local obj = square:getObjects():get(i)
		if obj:getModData()["recipe"] then
		end
	end
end
Events.LoadGridsquare.Add(ABE.loadGridSquare);
--]]
