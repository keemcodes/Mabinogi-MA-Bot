;THIS CODE WAS DEVELOPED BY Refuser of Mabinogi Alexina aka Yisui Chaos aka Phazd :) - initials: - aa
;READ THIS 02/17/18 NEW IDEA TO HAVE MORE ACCURATE CLICKS... ran outta time to code it...
;Save first recorded image coords to global variable, reference that varible for the rest of run time rather than searching the same images over and over again.
; using same concept delevoped in enter/exit
; remember to MouseMove 0, 0 to avoid mouse causing errors.
; REMEMBER TO UTILIZE COUNTER CHECKS AS FAILSAFES
; EXAMPLE: -insertvariblehere-++1 each crisis escape after a certain amount of time double check to make sure mission isnt complete already, assume death after 4 minutes?

;#MaxThreadsPerHotkey 2
;#UseHook
;Tracking varibles used throughout script...
init = 0 ;this tracks whether im inside or outside MA
coordcheck = 1 ;this means the coords need to be saved
fhloop = 0 ;fh counter
fhloopend = 0
fhtab = 0 ;changes fh target
fhed = 0 ;switches weapon if fh was previously used
crisistimer = 0
rambo = 0
QWinOpen = 0
FinalHitVar = 0

InputBox, targetIDaddress, Target ID Address, Please enter the address for Target ID, , 680, 150

CustomColor = 000000
Gui +LastFound +AlwaysOnTop +ToolWindow -Caption
Gui, Color, %CustomColor%
Gui, Font, s10, Lucida Console
 
Gui, Add, Text, x50 y0 w385 BackgroundTrans 0x5
Gui, Add, Text, x50 y0 w385 BackgroundTrans cWhite, GMA Bot is Off, TargetID Address: %targetIDaddress%
WinSet, TransColor, %CustomColor% 230
 
Gui, Show

ReadMemory(MADDRESS,PROGRAM)
{
	winget, pid, PID, %PROGRAM%

	VarSetCapacity(MVALUE,4,0)
	ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
	DllCall("ReadProcessMemory", "UInt", ProcessHandle, "Ptr", MADDRESS, "Ptr", &MVALUE, "Uint",4)
	Loop 4
	result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)

	return, result
}

UpdateItemGUI()
{
	if init = 1
	{
		GuiControl, Text, Static2, GMA Bot is On! Running task: item2
	}
	else if init = 2
	{
		GuiControl, Text, Static2, GMA Bot is On! Running task: item3
	}
	else if init = 3
	{
		GuiControl, Text, Static2, GMA Bot is On! Running task: item4
	}			
	else
	{
		GuiControl, Text, Static2, GMA Bot is On! Running task: item1
	}	
}
return


QuestWindowStream() ;makes sure quest window is open
{
	global
	ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 questwindow.bmp
	if ErrorLevel = 1
	{		
		send {q}
		QWinOpwn = 1
	}
}
return



MoveToBattleZone() ;this function moves character to the spawn area -q pending massive update
;update will include a round tracking feature
{
	global
	GuiControl, Text, Static2, GMA Bot is On! Function: MoveToBattleZone
	Send {space}
	sleep, 250
	Send {d down}
	sleep, 200
	;--- add functions that dont mess up walk time here
	QuestWindowStream()
	sleep, 6300 ; previously, 6500 run time very important and dependant on race, char speed, equips etc
	Send {d up}
	sleep, 100 ;auto pov below
	Send {space}
}
return

ExitMA()
{
	global
	if (coordcheck = 1)
	{
		ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 postarts.bmp
		if ErrorLevel = 0
		{
			ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 exit2.bmp
			if ErrorLevel = 0
			{
				Click Left %FoundX%, %FoundY%
				Click Left %FoundX%, %FoundY%
				exitBMpX = %FoundX%
				exitBMpY = %FoundY%				
				sleep, 1000
				ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 ok.bmp
				if ErrorLevel = 0
				{
					Click Left %FoundX%, %FoundY%
					sleep, 150
					Click Left %FoundX%, %FoundY%
					okBMpX = %FoundX%
					okBMpY = %FoundY%
					sleep, 200				
					send {esc}
					sleep, 1000	
					send {esc}
					sleep, 100
					coordcheck = 0
					crisistimer = 0					
					init = 0
					GuiControl, Text, Static2, GMA Bot is On! Task: Pending Entry
				}
			}
		}
	}
	else
	{
		ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 postarts.bmp
		if ErrorLevel = 0
		{
			Click Left %exitBMpX%, %exitBMpY%
			Click Left %exitBMpX%, %exitBMpY%		
			sleep, 1000
			Click Left %okBMpX%, %okBMpY%
			sleep, 150
			Click Left %okBMpX%, %okBMpY%
			sleep, 200				
			send {esc}
			sleep, 1000	
			send {esc}
			sleep, 100
			init = 0
			GuiControl, Text, Static2, GMA Bot is On! Task: Pending Entry
		}
	}
}
return


MissionCompletionCheck() ;makes sure quest window is open
{
	global
	QuestWindowStream()
	sleep, 500
	ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 postarts.bmp
	if ErrorLevel = 0
	{		
		ExitMA()
	}
}
return

;this spawns colossus, crisis, act 4 then despawns at the end
;need too work on puppet alive/dead detection and/or health monitoring...
Poopet()
{
	GuiControl, Text, Static2, GMA Bot is On! Function: Poopet 
	Send {-}
	sleep, 2000
	Send {3}
	sleep, 100
	Send {3}
	sleep, 100
	send {0}
	sleep, 200
	send {0}
	Send {3}
	sleep, 200 
	Send {3}
	sleep, 250 
	Send {3}
	sleep, 200 
	Send {3}
	sleep, 200
	Send {3}
	sleep, 200 
	Send {3}
	sleep, 200 
	Send {3}
	sleep, 100 
	send {Numpad0}		
	sleep, 200 
	send {Numpad0}	
	Send {3}		
	sleep, 200
	Send {3}
	sleep, 200 
	Send {3}		
	sleep, 200
	Send {3}
	sleep, 200
	Send {3}
	sleep, 200
	Send {3}
	sleep, 200
	Send {3}
	sleep, 250
	Send {3}
	sleep, 250
	Send {3}	
	sleep, 200
	Send {3} ;refer to text below, allows to this aswell
	sleep, 200 ;remove 6 of these if issues occur	
	Send {4}
	sleep, 200
	Send {4}
	sleep, 200
	Send {4}
	sleep, 200
	Send {4}
	sleep, 200
	Send {4}	
	sleep, 200
	Send {4}
	sleep, 200
	Send {4}
	sleep, 200
	Send {4}
	sleep, 200
	Send {4}
	sleep, 200
	Send {4}
	sleep, 200
	Send {4}
	Send {esc}
	sleep, 150	
	Send {esc}
	sleep, 150		
	Send {-}
	sleep, 200
	Send {-}
	sleep, 200
	Send {-}
	sleep, 200
	Send {-}
	sleep, 200	
	Send {-}
	sleep, 200		
}
return

;this is basically the 'heartbeat' of the script
;item 1 is the main thread. It waits until I'm inside to execute battle functions then forwards loop back to item1 unless....
;item 3 is called, this happens when it recieves the pm "fh" in which it will then proceed to fh
ScrollLock::
{
	;UpdateItemGUI()
	GuiControl, Text, Static2, GMA Bot is On! Task: Pending Entry
	Toggle := !Toggle
	While Toggle
	{
		if init = 1
		{
			;Timer("Two",120000)	; (20 seconds for testing)
			Item2()
		}
		else if init = 2
		{
			Item3()
		}		
		else
		{
			Item1()
		}			
	}
}
return
		
!NumLock::
{
	FinalHitVar = 1
	GuiControl, Text, Static2, GMA Bot is On! Task: Pending Final Hit!
}
return

!ScrollLock::
{
	sleep, 100
	send {6}
	sleep, 750
	send {numpad0}
	sleep, 100
	send {numpad0}
	sleep, 100
	send {numpad0}
	sleep, 100
	send {7}
	sleep, 750
	send {numpad0}
	sleep, 100
	send {numpad0}
	sleep, 100
	send {numpad0}
	sleep, 100	
	send {8}
	sleep, 750
	send {numpad0}
	sleep, 100
	send {numpad0}
	sleep, 100
	send {numpad0}
	sleep, 100	
}
return

/*
Screen:	666, 490 (less often used)
Window:	674, 498 (default)
Client:	666, 467 (recommended)
Color:	B2B8BA (Red=B2 Green=B8 Blue=BA)
*/
;!NumLock::mousemove 674, 498
    
Item1()
{
	global
	;MissionCompletionCheck()
	;Click Right 0, 0
	sleep, 1500
    ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 exit2.bmp
    if ErrorLevel = 0
	{
		;ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 fh.bmp
		if FinalHitVar = 0
		{	
			Click Right 674, 498 ;in SM for now :/
			MoveToBattleZone()
			;-utilize this 5 second time slot for additional failsafes and checks
			sleep, 1000
			send {3} ;auto weapon convert to make sure bars are equiped
			sleep, 4250
			Poopet() ; spawn, poopet, crisis, act 4, despawn poopet...1111111
			sleep, 250
			send {9}
			init = 1
			GuiControl, Text, Static2, GMA Bot is On! Task: Poopet/Hide/Exit
						
		}
		else
		{
			Click Right 674, 498
			;sleep, 2000
			MoveToBattleZone()
			;-utilize this 6.5 second time slot for additional failsafes and checks
			sleep, 1000
			send {2} ;uses bash then presses esc, utilizing weapon auto convert to make sure swords are equipped prior to fh
			sleep, 1500
			send {esc}
			sleep, 4250
			send {f6}
			sleep, 100
			send {tab}
			init = 2
			GuiControl, Text, Static2, GMA Bot is On! Task: Final Hit!
			rambo = 0			
		}
	}
}
return


Item2()
{
	global
	QuestWindowStream()
    sleep, 1000
	if (coordcheck = 1)
	{
		ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 postarts.bmp
		if ErrorLevel = 0
		{
			ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 exit2.bmp
			if ErrorLevel = 0
			{
				Click Left %FoundX%, %FoundY%
				Click Left %FoundX%, %FoundY%
				exitBMpX = %FoundX%
				exitBMpY = %FoundY%				
				sleep, 1000
				ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 ok.bmp
				if ErrorLevel = 0
				{
					Click Left %FoundX%, %FoundY%
					sleep, 150
					Click Left %FoundX%, %FoundY%
					okBMpX = %FoundX%
					okBMpY = %FoundY%
					sleep, 200				
					send {esc}
					sleep, 1000	
					send {esc}
					sleep, 100
					coordcheck = 0
					crisistimer = 0					
					init = 0
					GuiControl, Text, Static2, GMA Bot is On! Task: Pending Entry
				}
			}
		}
		else
		{
			if (crisistimer > 5)
			{
				
				ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 onrambo.bmp
				if ErrorLevel = 0
				{
					rambo = 1
				}
				ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 offrambo.bmp
				if ErrorLevel = 0
				{
					rambo = 0
				}
				if (rambo = 1)
				{
					send {esc}
					sleep, 500
					Poopet()
					crisistimer = 0
				}
				if (rambo = 0)
				{
					send {9}
					;send {f10}
					sleep, 1000
				}	
					
			}
			else
			{
				send {9}
				;send {f10}
				crisistimer++
				sleep, 1000
			}
		}
	}
	else
	{
		ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 postarts.bmp
		if ErrorLevel = 0
		{
			Click Left %exitBMpX%, %exitBMpY%
			Click Left %exitBMpX%, %exitBMpY%		
			sleep, 1000
			Click Left %okBMpX%, %okBMpY%
			sleep, 150
			Click Left %okBMpX%, %okBMpY%
			sleep, 200				
			send {esc}
			sleep, 1000	
			send {esc}
			sleep, 100
			init = 0
			GuiControl, Text, Static2, GMA Bot is On! Task: Pending Entry
		}
		else
		{
			if (crisistimer > 5)
			{			
				ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 onrambo.bmp
				if ErrorLevel = 0
				{
					rambo = 1
				}
				ImageSearch, FoundX, FoundY, 1,1,%A_ScreenWidth%,%A_ScreenHeight%, *50 offrambo.bmp
				if ErrorLevel = 0
				{
					rambo = 0
				}
				if (rambo = 1) 
				{
					send {esc}
					sleep, 500
					Poopet() 
					crisistimer = 0
				}
				if (rambo = 0)
				{
					send {9}
					;send {f10}
					sleep, 1000				
				}
					
			}
			else
			{
				send {9}
				;send {f10}
				crisistimer++
				sleep, 1000
			}
		}
	}
}
return
/*
Item3()
{
	global
	if (fhloop < 60) 
	{
		if (fhtab = 0)
		{
			fhtab = 1
		}		
		sleep, 100
		send {1}
		sleep, 150
		send {1}	
		fhloop++
	}
	else if (fhloop < 120) 
	{
		if (fhtab = 1)
		{
			send {tab}
			fhtab = 2
		}		
		sleep, 100
		send {1}
		sleep, 150
		send {1}
		fhloop++
	}
	;causes bot to often miss "next.bmp" to exit because it disappears before code reaches there. 
	;note: Use Quest menu to code more reliable exit trigger
	else if (fhloop < 140) 
	{
		if (fhtab = 2)
		{
			send {tab}
			fhtab = 0
		}
		sleep, 100
		send {1}
		sleep, 150
		send {1}
		fhloop++
	}
	else
	{
		fhloop = 0
		fhed = 1
		init = 1
	}
}
return
*/
Item3()
{
	global
	targetid := ReadMemory(targetIDaddress, "Mabinogi") ;0x81AD4A88
	if (!targetid2) 
	{
		targetid2 := targetid
	}
	if (targetid = 0) 
	{
		if (fhloop > 20)
		{
			;msgbox endlooptest
			fhloop = 0
			fhloopend = 0
			fhed = 1
			init = 1
			FinalHitVar = 0
			GuiControl, Text, Static2, GMA Bot is On! Task: Poopet/Hide/Exit
		}
		;msgbox first if tid:%targetid% and tid2:%targetid2%
		send {tab}
		sleep, 100
		send {1}
		sleep, 150
		send {1}	
		fhloop++
	}
	else
	{
		if (fhloopend > 125)
		{
			send {esc}
			fhloop = 0
			fhloopend = 0
			fhed = 1
			init = 1
			FinalHitVar = 0
			GuiControl, Text, Static2, GMA Bot is On! Task: Poopet/Hide/Exit
		}		
		;msgbox 2nd if tid:%targetid% and tid2:%targetid2%
		;send {tab}
		sleep, 100
		send {1}
		sleep, 150
		send {1}
		fhloopend++
		targetid2 := targetid
	}
}
return

;Pause::Reload

; all done by yours truly :)
UpdateGui:
	Timer()
	TimeLeft := Timer("One","Left")
	MinutesLeft := Round(TimeLeft/60000-.5)
	SecondsLeft := Round((TimeLeft-(MinutesLeft*60000))/1000)
	TimeLeft := MinutesLeft " Minutes and " SecondsLeft " Seconds Left`nWorking on: Item" Item_Index "`nToggle State: "
	TimeLeft .= Toggle ? "On" : "Off"
	GuiControl,,TimeLeft,%TimeLeft%
return



;{ Timer
; Fanatic Guru
; 2014 04 10
;
; FUNCTION to Create and Manage Timers
;
;------------------------------------------------
;
; Method:
;   Timer(Name of Timer, Options)
;   All times are in milliseconds and use A_TickCount which is milliseconds since computer boot up
;
;   Parameters:
;   1) {Name of Timer} A Unique Name for Timer to Create or Get Information About
;   2) {Option = {Number}} Set Period of Timer, creates or resets existing timer to period
;      {Option = R or RESET} Reset existing timer
;      {Option = U or UNSET} Unset existing timer ie. remove from Timer array
;      {Option = D or DONE} Return true or false if timer is done and period has passed
;      {Option = S or START} Return start time of timer
;      {Option = F or FINISH} Return finish time of timer
;      {Option = L or LEFT} Return time left of timer, will return a negative number if timer is done
;      {Option = N or NOW} Return time now
;      {Option = P or PERIOD} Return period of timer ie. duration, span, length
;      {Option = E or ELAPSE} Return elapse time since timer started
;      Optional, Default = "D"
;
; Returns:
;   Creates or Returns Information About Timer Based on Options
;   Timer() refreshes all timers which updates the information in the Timer array
;
; Global:
;   Timer.{Timer Name}.Start|Finish|Period|Done|Left|Now|Elapse
;     Creates a global array called Timer that contains all the timer information at the time of last function call
;	  To use a variable to retrieve Timer information use [] array syntax
;     Timer[Variable_Name,"Left"]
;   Timer_Count = number of Timers created
;	  Variables contain the information the last time function was called
;	  To obtain current information either call the Timer specifically by Name of Timer or use Timer() to update all variables
;
; Examples:
;   Timer("Cooldown",8000)		; <-- Creates a Timer named Cooldown with an 8 second period
;   Timer("Cooldown")			; <-- Returns True if Timer is Done, False if not Done
;   Timer("Cooldown,"L")		; <-- Returns updated time Left on Timer
;   Timer(VariableName,30000)		; <-- Creates A Timer named the contents of VariableName with a 30 second period
;
;   When Name of Timer = Cooldown
;   Timer.Cooldown.Period		; <-- Variable created by Function that contains Period (Duration) of Timer named Cooldown
;   Timer.Cooldown.Start		; <-- Variable created by Function that contains internal clock time when Timer Started
;   Timer.Cooldown.Finish		; <-- Variable created by Function that contains internal clock time when Timer will Finish
;   Timer.Cooldown.Now			; <-- Variable created by Function that contains internal clock time last time function was called
;   Timer.Cooldown.Done			; <-- Variable created by Function that contains Done status last time function was called
;   Timer.Cooldown.Left			; <-- Variable created by Function that contains time Left last time function was called
;   Timer.Cooldown.Elapse		; <-- Variable created by Function that contains Elapse time since start of timer and last time function was called
;   Timer["Cooldown","Period"]		; <-- Equivalent to above . array syntax but works better if using Variable to replace literal strings
;
;   For index, element in Timer		; <-- Useful for accessing information for all timers stored in the array Timer 
;
;	It is important to understand that () are used to call the function and [] are used to access global variables created by function
;	The function can be used for many applications without ever accessing the variable information
;	I find it useful to have access to these variables outside the function so made them Global but they could probably be made Static
;
Timer(Timer_Name := "", Timer_Opt := "D")
{
	static
	global Timer, Timer_Count
	if !Timer
		Timer := {}
	if (Timer_Opt = "U" or Timer_Opt = "Unset")
		if IsObject(Timer[Timer_Name])
		{
			Timer.Remove(Timer_Name)
			Timer_Count --=
			return true
		}
		else
			return false
	if RegExMatch(Timer_Opt,"(\d+)",Timer_Match)
	{
		if !(Timer[Timer_Name,"Start"])
			Timer_Count += 1
		Timer[Timer_Name,"Start"] := A_TickCount
		Timer[Timer_Name,"Finish"] := A_TickCount + Timer_Match1
		Timer[Timer_Name,"Period"] := Timer_Match1
	}
	if RegExMatch(Timer_Opt,"(\D+)",Timer_Match)
		Timer_Opt := Timer_Match1
	else
		Timer_Opt := "D"
	if (Timer_Name = "")
	{
		for index, element in Timer
			Timer(index)
		return
	}
	if (Timer_Opt = "R" or Timer_Opt = "Reset")
	{
		Timer[Timer_Name,"Start"] := A_TickCount
		Timer[Timer_Name,"Finish"] := A_TickCount + Timer[Timer_Name,"Period"]
	}
	Timer[Timer_Name,"Now"] := A_TickCount
	Timer[Timer_Name,"Left"] := Timer[Timer_Name,"Finish"] - Timer[Timer_Name,"Now"]
	Timer[Timer_Name,"Elapse"] := Timer[Timer_Name,"Now"] - Timer[Timer_Name,"Start"]
	Timer[Timer_Name,"Done"] := true
	if (Timer[Timer_Name,"Left"] > 0)
		Timer[Timer_Name,"Done"] := false
	if (Timer_Opt = "D" or Timer_Opt = "Done")
		return Timer[Timer_Name,"Done"]
	if (Timer_Opt = "S" or Timer_Opt = "Start")
		return Timer[Timer_Name,"Start"]
	if (Timer_Opt = "F" or Timer_Opt = "Finish")
		return Timer[Timer_Name,"Finish"]
	if (Timer_Opt = "L" or Timer_Opt = "Left")
		return Timer[Timer_Name,"Left"]
	if (Timer_Opt = "N" or Timer_Opt = "Now")
		return Timer[Timer_Name,"Now"]
	if (Timer_Opt = "P" or Timer_Opt = "Period")
		return Timer[Timer_Name,"Period"]
	if (Timer_Opt = "E" or Timer_Opt = "Elapse")
		return Timer[Timer_Name,"Elapse"]
}
;}

/* Notes

*Code a fucking detection for quest box to make sure it's on the right tab. Sometimes it's not on the right tab. This should only need to be checked once.
*Code a check function to keep track on character data. Like HP etc.
*Add a GUI Window to toggle script on/off ingame










































*/
