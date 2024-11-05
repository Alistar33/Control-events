Repro instructions - Please use an empty space without objects around (thanks to Leviathan Linden)

(1) While standing still press the LeftTurn key and hold it for 10 seconds. --> the avatar won't turn because the left turn control has been taken and the script should report about 230 events in 10 seconds. This is ok. What is really happening is the viewer is sending AgentUpdates at about 1Hz (keep alive rate when nothing is changing) but the server notices the key is being held down so it generates repeat control events at about 23Hz.

(2) Repeat step (1) but this time while holding down the left turn also walk forward in a flat open area without obstacles --> after 10 seconds the script should report about 440 or more events in 10 seconds. This is because the avatar and camera are changing positions so AgentUpdate messages are sent more often, but still rate limited.

In the bugged version the control event rate when walking forward was lower than 440+ (I think).
