//Repro written by Atomic Infinity
// Instructions added by Alistar Snook and written by Leviathan Linden 

integer count;
default
{

control(key id, integer levels, integer edges)
{
integer start = levels & edges;
integer end = ~levels & edges;
if (start & CONTROL_ROT_LEFT)
{
count = 0;
llSetTimerEvent(10.0);
llOwnerSay("Timer started.\nHold key on for 10 seconds.");
}
if (end & CONTROL_ROT_LEFT)
{
llSetTimerEvent(0.0);
}
count += 1;
}
timer()
{
llSetTimerEvent(0.0);
llOwnerSay("Timer stopped.\nControl events count per 10sec : "+(string)count);
}
attach(key ID)
{
if (ID != NULL_KEY)
{
    //Simple instructions added provided by Leviathan Linden
llInstantMessage( llGetOwner(), "Repro instructions - Please use an empty space without objects around (thanks to Leviathan Linden)\n\n(1) While standing still press the LeftTurn key and hold it for 10 seconds. --> the avatar won't turn because the left turn control has been taken and the script should report about 230 events in 10 seconds. This is ok. What is really happening is the viewer is sending AgentUpdates at about 1Hz (keep alive rate when nothing is changing) but the server notices the key is being held down so it generates repeat control events at about 23Hz.\n

(2) Repeat step (1) but this time while holding down the left turn also walk forward in a flat open area without obstacles --> after 10 seconds the script should report about 440 or more events in 10 seconds. This is because the avatar and camera are changing positions so AgentUpdate messages are sent more often, but still rate limited.\n

In the bugged version the control event rate when walking forward was lower than 440+ (I think)." );
llSetTimerEvent(0.0);
count = 0;
llRequestPermissions(ID, PERMISSION_TAKE_CONTROLS);
}
}
run_time_permissions(integer perm)
{
if (perm & PERMISSION_TAKE_CONTROLS)
{
 llTakeControls(CONTROL_ROT_LEFT, TRUE, FALSE);
}
}
}
