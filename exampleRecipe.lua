--[[
#########################################################################################################
#	@mod:		ABE - Advanced Building Environment    		                                            #
#	@author: 	Dr_Cox1911					                                                            #
#	@notes:		Many thanks to blindcoder and his mod CraftTec											#
#	@notes:		For usage instructions check github page below                                 			#
#	@link: 		https://github.com/DrCox1911/ABE/wiki											       										#
#########################################################################################################
--]]


ExampleRecipe = {
	ContextMenu_Metalworking = {
		isCategory = true,
		ContextMenu_Metal_Containers = {
			isCategory = true,
			ContextMenu_Metal_Crate = {
				name = "ContextMenu_Metal_Crate",
				resultClass = "ISWoodenContainer",
				ingredients = {
					["Base.MetalPipe"] = 2,
					["Base.SmallSheetMetal"] = 2,
					["Base.SheetMetal"] = 2,
					["Base.ScrapMetal"] = 1
				},
				images = {
					MetalWelding = {
						[0] = {
							west = "constructedobjects_01_45", north = "constructedobjects_01_44", east = nil, south = nil
						}
					}
				},
				tools = {"Base.BlowTorch", "Base.WeldingMask", "Base.WeldingRods"},
				primaryItem = "Base.BlowTorch",
				secondaryItem = "Base.WeldingMask",
				use = {["Base.BlowTorch"] = 7, ["Base.WeldingRods"] = 4},
				requirements = { any = { MetalWelding = { level = 0, time = 90 } } },
				gameRecipe = "Make Metal Containers",
				data = {
					canBeAlwaysPlaced = true,
					renderFloorHelper = true,
				},
				modData = {}
			},
		}
	}
}

ExampleRecipeDoubleDoor = {
	ContextMenu_Metal_Big_Metal_Double_Metal_Door = {
				name = "ContextMenu_Metal_Big_Metal_Double_Metal_Door",
				resultClass = "ISDoubleDoor",
				ingredients = {
					["Base.MetalPipe"] = 8,
					["Base.Wire"] = 4
				},
				images = {
					MetalWelding = {
						[0] = {
							west = "fixtures_doors_fences_01_77", north = "fixtures_doors_fences_01_71", east = nil, south = nil
						}
					}
				},
				spriteMulti = "fixtures_doors_fences_01_",
				spriteIndex = 72,
				tools = {"Base.BlowTorch", "Base.WeldingMask", "Base.WeldingRods"},
				primaryItem = "Base.BlowTorch",
				secondaryItem = "Base.WeldingMask",
				use = {["Base.BlowTorch"] = 8, ["Base.WeldingRods"] = 4},
				playSound = "Sawing",
				requirements = { any = { MetalWelding = { level = 0, time = 30 } } },
				gameRecipe = "Make Metal Fences",
				data = {
					canBeAlwaysPlaced = true,
					renderFloorHelper = true,
				},
				modData = {
					doubleDoor = {
						spriteIndex = 72
					}
				}
			}
}