Scriptname DLC2ExpSpiderPackmuleSCRIPT extends ObjectReference Hidden 

Bool Property bAlreadyForcedRef = False Auto Hidden
Bool Property bIsFriendly = False Auto

Quest Property DLC2ExpSpiderQuest Auto

Spell Property SpiderSpellCloak Auto

Event OnLoad()

	ObjectReference mySelf = self
	If bIsFriendly
		(mySelf as Actor).SetPlayerTeammate()
		If !bAlreadyForcedRef
			(DLC2ExpSpiderQuest as DLC2ExpPackSpiderAliasArrayScript).ForceRefInto(mySelf)
			bAlreadyForcedRef = True
		endIf
		
		If (SpiderSpellCloak)
			SpiderSpellCloak.Cast(Self)
		endIf

	endIf

EndEvent

Event OnActivate(ObjectReference akActivateRef)
	
	ObjectReference mySelf = Self
	(mySelf as Actor).UnequipAll()
	(mySelf as Actor).OpenInventory(True)
	
EndEvent 