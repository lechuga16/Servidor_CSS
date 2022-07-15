#pragma semicolon 1

#include <sourcemod>
#include <sdktools>

ConVar g_cvSoundPath;

public Plugin myinfo =
{
	name = "[ANY] Chat-Trigger Sound",
	author = "Player",
	description = "",
	version = "", 
	url = ""
};

public void OnPluginStart()
{
	AddCommandListener(Command_Say, "say");
	AddCommandListener(Command_Say, "say2");
	AddCommandListener(Command_Say, "say_team");
	
	g_cvSoundPath = CreateConVar("sm_chat_trigger_soundpath", "buttons/button14.wav", "relative to the sound folder");
	
	AutoExecConfig(true, "sm_chat_trigger_sound");
}

public void OnMapStart()
{
	char sFull[128];
	char sRelativ[128];
	
	GetConVarString(g_cvSoundPath, sRelativ, sizeof(sRelativ));
	FormatEx(sFull, sizeof(sFull), "sound/%s", sRelativ);
	
	AddFileToDownloadsTable(sFull);
	PrecacheSound(sRelativ, true);	
}

public Action Command_Say(int iClient, const char[] sCommand, int iArgs)
{
	char sBuffer[32];
	
	if(GetCmdArgString(sBuffer, sizeof(sBuffer)) >= 1)
	{
		if(sBuffer[1] == '!' || sBuffer[1] == '/')
		{
			char sSoundPath[128];
			GetConVarString(g_cvSoundPath, sSoundPath, sizeof(sSoundPath));
			
			EmitSoundToClient(iClient, sSoundPath);
		}
	}
	return Plugin_Continue;
}