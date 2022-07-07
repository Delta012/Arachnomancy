Scriptname DLC2EncExpSpiderGenericControlScript extends ObjectReference Hidden 

Bool Property bAlreadyForcedRef = False Auto Hidden
Bool Property bDisableOnDeath = True Auto
{Whether or not this actor should disable on death (True)}

Explosion Property SpiderCrumbleExplosion Auto
{Explosion that comes from the spider when he dies without exploding}

Faction Property DLC2ExpSpiderFriendFaction Auto
{Faction to check for before adding this spider to the list of spawned spiders}

Quest Property DLC2ExpSpiderQuest Auto
{Quest that holds the script/aliases we need}

Event OnLoad()
	
	ObjectReference mySelf = Self
	If (mySelf as Actor).IsInFaction(DLC2ExpSpiderFriendFaction)
		If !bAlreadyForcedRef
			(DLC2ExpSpiderQuest as DLC2ExpSpiderAliasArrayScript).ForceRefInto(mySelf)
			bAlreadyForcedRef = True
		endIf
	endIf

EndEvent

Function ClearActor()

	ObjectReference mySelf = Self
	If (mySelf as Actor).IsInFaction(DLC2ExpSpiderFriendFaction)
		(DLC2ExpSpiderQuest as DLC2ExpSpiderAliasArrayScript).ClearRefFrom(mySelf)
	endIf

EndFunction

Function SpiderCrumble()
	
	ObjectReference mySelf = Self
	If (mySelf as Actor).IsInFaction(DLC2ExpSpiderFriendFaction)
		If (mySelf.IsDisabled() == False)
			If bDisableOnDeath
				PlaceAtMe(SpiderCrumbleExplosion, 1)
				(mySelf as Actor).SetAlpha(0)
				(mySelf as Actor).DisableNoWait()
			endIf
		endIf
	endIf

EndFunction 