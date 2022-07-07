Scriptname DLC2EncExplodingSpiderScript extends Actor Hidden 

Bool Property bShouldExplode = True Auto
{Whether or not this spider should explode (Default = True)}
Bool Property bShouldHandleOnHit = True Auto
{Whether or not we should handle the OnHit() block. Default = True}
Bool bWasHit = False 

Explosion Property SpiderExplosion Auto
{Explosion that comes from the spider when he explodes near you}
Explosion Property SpiderCrumbleExplosion Auto
{Explosion that comes from the spider when he dies without exploding}

Int Property iElementalResist = 0 Auto
{Which element this spider resists, If any. 0 = Nothing (Default), 1 = Fire, 2 = Frost, 3 = Shock, 4 = Poison}

Keyword Property MagicDamageFire Auto
Keyword Property MagicDamageFrost Auto
Keyword Property MagicDamageShock Auto
Keyword Property MAG_MagicDamagePoison Auto

;Register for anim event so we know it's attacking
Event OnLoad()

	Self.SetAlpha(1)
	RegisterForAnimationEvent(Self, "MLh_SpellFire_Event")
	If (bShouldHandleOnHit)
		bShouldHandleOnHit = False
		Utility.Wait(1)
		bShouldHandleOnHit = True
	endIf

EndEvent

;When the spider attacks make it explode then clean it up
Event OnAnimationEvent(ObjectReference akSource, string EventName)

	Self.SetAlpha(0)
	((Self as ObjectReference) as DLC2EncExpSpiderGenericControlScript).ClearActor()
	Self.DisableNoWait()
	Self.DeleteWhenAble()

EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
	
	If bShouldHandleOnHit
		If (akSource as Spell) && ((akSource as Spell).IsHostile() == False)
			;Nothing
		elseIf (akSource as Spell)
			int iSpellType
			If Self.GetAV("FireResist") >= 100 && Self.GetAV("FrostResist") >= 100 && Self.GetAV("ElectricResist") >= 100
				iSpellType = 5
			elseIf (akSource as Spell).HasKeyword(MagicDamageFire)
				iSpellType = 1
			elseIf (akSource as Spell).HasKeyword(MagicDamageFrost)
				iSpellType = 2
			elseIf (akSource as Spell).HasKeyword(MagicDamageShock)
				iSpellType = 3
			elseIf (akSource as Spell).HasKeyword(MAG_MagicDamagePoison)
				iSpellType = 4
			endIf

			If (iElementalResist == 0) || (iSpellType != iElementalResist)
				bWasHit = True
				Self.Kill()
			else
 				;Nothing
			endIf

		else
			bWasHit = True
			Self.Kill()
		endIf
	endIf

EndEvent

Event OnDying(Actor akKiller)
	
	If (bShouldExplode == True) && (bWasHit == False)
		SpiderExplode()
	else
		SpiderCrumble()		
	endIf
	
	((Self as ObjectReference) as DLC2EncExpSpiderGenericControlScript).ClearActor()

EndEvent

Function SpiderExplode()

	PlaceAtMe(SpiderExplosion, 1)
	
	Self.SetAlpha(0)
	Self.DisableNoWait()
	Utility.Wait(1)

EndFunction

Function SpiderCrumble()

	PlaceAtMe(SpiderCrumbleExplosion, 1)
	Self.SetAlpha(0)
	Self.DisableNoWait()
	Utility.Wait(1)

EndFunction


