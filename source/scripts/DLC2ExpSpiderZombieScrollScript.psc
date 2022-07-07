Scriptname DLC2ExpSpiderZombieScrollScript extends ActiveMagicEffect  

Faction Property DLC2ExpSpiderFriendFaction Auto

Event OnEffectStart(actor akTarget, actor akCaster)
	akTarget.SetPlayerTeammate(True, False)
	akTarget.AddToFaction(DLC2ExpSpiderFriendFaction)
	akTarget.StopCombat()
EndEvent

Event OnEffectFinish(actor akTarget, actor akCaster)
	akTarget.SetPlayerTeammate(False, False)
	akTarget.RemoveFromFaction(DLC2ExpSpiderFriendFaction)
EndEvent