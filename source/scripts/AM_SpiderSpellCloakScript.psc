Scriptname AM_SpiderSpellCloakScript extends Actor

Actor Property PlayerRef Auto

Spell Property SpiderSpellCloak Auto

Event OnLoad()

	Float AlchemyAV = PlayerRef.GetAV("Alchemy")
	Self.SetAV("Alchemy", AlchemyAV)
	SpiderSpellCloak.Cast(Self, Self)
	
EndEvent