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
				use = {["Base.BlowTorch"] = 7, ["Base.WeldingRods"] = 3.5},
				requirements = { any = { MetalWelding = { level = 1, time = 90 } } },
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