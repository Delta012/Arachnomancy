Scriptname DLC2ExpSpiderDeadSpiderScript extends ObjectReference  
{For dead exploding spiders}

Actor Property PlayerRef Auto

Bool Property bFriendlyBomb = True Auto
{Default to True: Keeps bomb from exploding for the player/teammates}

Bool bBlockExplosion = True

Explosion Property SpiderExplosion Auto
{Explosion that comes from the corpse}

Faction Property DLC2ExpSpiderEnemyFaction Auto
{Faction to check against If this bomb isn't friendly}

Event OnLoad()

	Utility.Wait(0.1)
	bBlockExplosion = False
	
EndEvent

Auto State WaitingForTrigger
	
	Event OnTriggerEnter(ObjectReference akActionRef)

		If (bFriendlyBomb == False) && (!(akActionRef as Actor).IsInFaction(DLC2ExpSpiderEnemyFaction))
			If ((akActionRef as Actor).IsDead() == False)
				GoToState("BeenTriggered")
				DoExplosion()
			endIf
		endIf

		If bFriendlyBomb == True			
			If (akActionRef as Actor)
				If ((akActionRef as Actor).IsDead() == False)
					If (akActionRef as Actor).IsHostileToActor(PlayerRef)
						GoToState("BeenTriggered")
						DoExplosion()
					endIf
				endIf
			endIf
		endIf
		
	EndEvent

	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

		If ((akSource as Explosion) && !bBlockExplosion) || akProjectile
			GoToState("BeenTriggered")
			DoExplosion()
		endIf

	EndEvent

EndState


State BeenTriggered

EndState


Function DoExplosion()

	PlaceAtMe(SpiderExplosion, 1)

	Self.DisableNoWait()

EndFunction