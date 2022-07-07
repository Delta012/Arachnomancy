Scriptname AM_VendorsInjection extends Quest Hidden

MiscObject Property DLC2ExpSpiderAlbinoButt Auto
MiscObject Property DLC2ExpSpiderAlbinoButtDamaged Auto
LeveledItem Property LItemApothecaryIngredientsCommon75 Auto
LeveledItem Property LItemApothecaryIngredienstUncommon75 Auto
LeveledItem Property LItemApothecaryIngredienstRare75 Auto

Event OnInit()

		LItemApothecaryIngredientsCommon75.AddForm(DLC2ExpSpiderAlbinoButtDamaged, 1, 1)
		LItemApothecaryIngredienstUncommon75.AddForm(DLC2ExpSpiderAlbinoButt, 1, 1)
		LItemApothecaryIngredienstRare75.AddForm(DLC2ExpSpiderAlbinoButt, 1, 1)

EndEvent