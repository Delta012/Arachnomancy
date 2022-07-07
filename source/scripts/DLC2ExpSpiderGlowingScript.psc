Scriptname DLC2ExpSpiderGlowingScript extends Actor Hidden 

Bool Property bAlreadyForcedRef = False Auto Hidden
Bool Property bIsFriendly = False Auto

Explosion Property SpiderCrumbleExplosion Auto

Quest Property DLC2ExpSpiderQuest Auto

Spell Property SpellToCast Auto

Event OnLoad()

	ObjectReference mySelf = Self

	SpellToCast.Cast(Self)

	If bIsFriendly
		If bAlreadyForcedRef == False
			(DLC2ExpSpiderQuest as DLC2ExpGlowSpiderAliasArrayScript).ForceRefInto(mySelf)
			bAlreadyForcedRef = True
		endIf
	endIf

EndEvent

Event OnDying(Actor akKiller)

	SpiderCrumble()

EndEvent

Function SpiderCrumble()

	PlaceAtMe(SpiderCrumbleExplosion, 1)
	Self.SetAlpha(0)
	Self.DisableNoWait()
	Utility.Wait(1)

EndFunction 