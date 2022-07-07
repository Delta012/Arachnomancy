Scriptname DLC2ExpSpiderCraftingScript extends ObjectReference Hidden

Actor Property PlayerRef Auto

Bool Property bHasLoaded Auto Hidden

FormList Property RecipeList Auto
FormList Property ResultList Auto
FormList Property RecipeBookListStatic Auto

ObjectReference Property DropBox Auto

State Busy
	
	Event OnActivate(ObjectReference akActionRef)
	EndEvent

EndState

Auto State Ready

	Event OnCellAttach()
		
		If bHasLoaded == False
			bHasLoaded = True
			FillDynamicList()
		endIf

	EndEvent

	Event OnActivate(ObjectReference akActionRef)
			
		GoToState("Busy")

			ScanForRecipes(RecipeList, ResultList)
		
		GoToState("Ready")
		
	EndEvent

EndState

Bool Function ScanForRecipes(FormList Recipes, FormList Results)

	Int I = 0
	Int T = Recipes.GetSize()
	Bool FoundCombine = False
	Bool Checking = True
		
	While Checking == True && I < T
		FormList CurrentRecipe = (Recipes.GetAt(I)) as FormList
		If CurrentRecipe == None
			;nothing
		else 
			If ScanSubList(CurrentRecipe) == True
				RemoveIngredients(CurrentRecipe)
				FoundCombine = True
				Checking = False
			else
				;found nothing
			endIf
		endIf
		
		If FoundCombine == False
			;only increment If we are continuing to loop
			I += 1
		endIf
		
	endWhile
	
	
	If FoundCombine == True
		Utility.Wait(1.0)
		Float AlchemyCraftXP = 0.75*(Results.GetAt(I).GetGoldValue()*0.25)
		If Utility.RandomInt(0, 100) <= 5
			PlayerRef.AddItem(Results.GetAt(I), 8)
			Game.AdvanceSkill("Alchemy", AlchemyCraftXP * 4)
		elseIf Utility.RandomInt(0, 100) <= 15
			PlayerRef.AddItem(Results.GetAt(I), 4)
			Game.AdvanceSkill("Alchemy", AlchemyCraftXP * 2)
		else
			PlayerRef.AddItem(Results.GetAt(I), 2)
			Game.AdvanceSkill("Alchemy", AlchemyCraftXP * 1)
		endIf

		If GetLinkedRef().GetItemCount(RecipeBookListStatic.GetAt(I)) > 0
			GetLinkedRef().RemoveItem(RecipeBookListStatic.GetAt(I))
			PlayerRef.AddItem(RecipeBookListStatic.GetAt(I))
		endIf
		
		Return True
	else
		Return False
	endIf

EndFunction

Bool Function ScanSubList(FormList Recipe)
	
	Int Size = Recipe.GetSize()
	Int CNT = 0
	While CNT < Size
		Form ToCheck = Recipe.GetAt(CNT)
		If DropBox.GetItemCount(ToCheck) < 1
			Return False
		else
			;nothing
		endIf
		CNT += 1
	endWhile
	
	Return True
	
EndFunction

Function RemoveIngredients(FormList Recipe)

	 Int Size = Recipe.GetSize()
	 Int CNT = 0
	 While (CNT < Size)
		Form ToCheck = Recipe.GetAt(CNT)
		If ToCheck as FormList
			RemoveSubIngredients(ToCheck as FormList)
		else
			DropBox.RemoveItem(ToCheck, 1)
		endIf
		CNT += 1
	endWhile
	
EndFunction

Function RemoveSubIngredients(FormList SubIngredients)

	 Int Size = SubIngredients.GetSize()
	 Int CNT = 0
	 Bool Running = True
	 While (CNT < Size) && Running
		Form ToCheck = SubIngredients.GetAt(CNT)
		If DropBox.GetItemCount(ToCheck) > 0
			DropBox.RemoveItem(ToCheck, 1)
			Running = False
		endIf
		CNT += 1
	endWhile

EndFunction

Function FillDynamicList()

	 Int Size = RecipeBookListStatic.GetSize()
	 Int CNT = 0
	 While CNT < Size
		Form ToAdd = RecipeBookListStatic.GetAt(CNT)
		GetLinkedRef().AddItem(ToAdd)
		If GetLinkedRef().GetItemCount(ToAdd) > 1
			GetLinkedRef().RemoveItem(ToAdd, 1)
		endIf
		CNT += 1
	endWhile

EndFunction 