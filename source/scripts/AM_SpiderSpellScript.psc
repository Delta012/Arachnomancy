Scriptname AM_SpiderSpellScript extends ActiveMagicEffect

Actor Property PlayerRef Auto

Spell Property SpiderSpell Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	SpiderSpell.Cast(PlayerRef, akTarget)
	
EndEvent