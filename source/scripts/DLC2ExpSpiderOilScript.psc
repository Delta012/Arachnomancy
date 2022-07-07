Scriptname DLC2ExpSpiderOilScript extends ObjectReference Hidden 

Import Utility
Import Debug

Activator Property OilPool Auto

Bool bPlaceOil

Explosion Property DLC2ExpSpiderOilCrumbleExplosion Auto
Explosion Property SpiderExplosion Auto
Explosion Property TrapOilExplosion01 Auto

Float Property fTimeBetweenPlacement = 0.3 Auto

Keyword Property MagicDamageFire Auto

ObjectReference mySelf

Event OnLoad()

	mySelf = Self

	If (mySelf as Actor).IsDead() == False
		bPlaceOil = True
		DropOilPools()
	endIf

EndEvent

Event OnCellDetach()

	bPlaceOil = False

EndEvent

Event OnDying()

	bPlaceOil = False
	SpiderCrumble()

EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

	If (akSource as Spell)
		If (akSource as Spell).HasKeyword(MagicDamageFire)
			bPlaceOil = False
			DoExplosion()
			SpiderCrumble()
		endIf
	endIf
	
	If (akSource as Explosion)
		If (akSource as Explosion) == TrapOilExplosion01
			bPlaceOil = False
			DoExplosion()
			SpiderCrumble()
		endIf
	endIf

EndEvent

Function DropOilPools()

	While(bPlaceOil)
		If (mySelf as Actor).IsDead() == 0
			If ((mySelf as Actor).IsInCombat())
				ObjectReference OilPoolRef = PlaceAtMe(OilPool, 1, False, False)
				OilPoolRef.SetAngle(0,0,0)
			endIf
		else
			bPlaceOil = False
		endIf

		Wait(fTimeBetweenPlacement)

	endWhile

EndFunction

Function SpiderCrumble()

	PlaceAtMe(DLC2ExpSpiderOilCrumbleExplosion, 1)
	Self.DisableNoWait()
	Utility.Wait(1)

EndFunction

Function DoExplosion()
	
	PlaceAtMe(SpiderExplosion, 1)
	Self.DisableNoWait()

EndFunction