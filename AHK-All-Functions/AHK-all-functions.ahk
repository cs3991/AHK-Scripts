#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetDefaultMouseSpeed, 0


#Include ..\Common\BrightnessSetter.ahk
#Include ..\Common\common-functions.ahk



RControl & F12:: suspend



;---- Hotstrings : autocomplete mail address ----

:*:sim@::simardced31@gmail.com
:*:inp@::cedric.simard@grenoble-inp.org
:*:fre@::cedric.simard@free.fr

; --- Greek letters


;:o:\alpha::{asc 945}
:o:\alpha::α
;:o:\beta::{asc 946}
;:o:\beta::{Alt Down}{Numpad2}{Numpad2}{Numpad5}{Alt Up}
:o:\beta::ß
;:o:\gamma::{asc 947}
:o:\gamma::γ
;:o:\Gamma::{asc 915}
:o:\Gamma::Γ
;:o:\delta::{asc 948}
:o:\delta::δ
;:o:\Delta::{asc 916}
:o:\Delta::Δ
;:o:\epsilon::{asc 949}
:o:\epsilon::ε
;:o:\zeta::{asc 950}
:o:\zeta::ζ
;:o:\eta::{asc 951}
:o:\eta::η
;:o:\theta::{asc 952}
:o:\theta::θ
:o:\Theta::Θ
;:o:\kappa::{asc 954}
:o:\iota::ι
:o:\Iota::Ι
:o:\kappa::κ
;:o:\lambda::{asc 955}
:o:\lambda::λ
:o:\Lambda::Λ
;:o:\mu::{asc 956}
:o:\mu::�]
:o:\nu::ν
;:o:\xi::{asc 958}
:o:\xi::ξ
:o:\xi::Ξ
;:o:\sigma::{asc 963}
:o:\sigma::σ
;:o:\Sigma::{asc 931}
:o:\Sigma::Σ
;:o:\pi::{asc 960}
:o:\pi::π
:o:\Pi::Π
;:o:\rho::{asc 961}
:o:\rho::ρ
;:o:\tau::{asc 964}
:o:\tau::τ
;:o:\phi::{asc 966}
:o:\phi::φ
;:o:\Phi::{asc 934}
:o:\Phi::Φ
;:o:\chi::{asc 967}
:o:\chi::χ
;:o:\psi::{asc 968}
:o:\psi::ψ
;:o:\Psi::{asc 936}
:o:\Psi::Ψ
;:o:\omega::{asc 969}
:o:\omega::ω
;:o:\Omega::{asc 937} 
:o:\Omega::Ω

; ----- Maths ---------
:o:\A::∀
:o:\pderiv::∂
:o:\existe::∃
:o:\vide::∅
:o:\in::∈
:o:\!in::∉
:o:\times::×
:o:\inf::∞
:o:\=>::⇒
:o:\<=>::⇔
:o:\<=::⇐
:o:\sqrt::√


; ----- General hotstrings ------
::bcp::beaucoup
::Bcp::Beaucoup
::...::…
::\iexcl::¡
::\iquest::¿
::" :"::" :"

;---- Accents ---

;!a:: ; alt + a = ae
;Send {Alt Down}{Numpad0}{Numpad2}{Numpad3}{Numpad0}{Alt Up}
;return
;!+a:: ; alt + shift + a = AE
;Send {Alt Down}{Numpad0}{Numpad1}{Numpad9}{Numpad8}{Alt Up}
;return
!+à:: ; shift + alt + à = a accent maj
Send {Alt Down}{Numpad0}{Numpad1}{Numpad9}{Numpad2}{Alt Up}
return
!+é:: ; shift + alt + é = e accent aigu maj
Send {Alt Down}{Numpad0}{Numpad2}{Numpad0}{Numpad1}{Alt Up}
return
!+è:: ; shift + alt + è = e accent grave maj
Send {Alt Down}{Numpad0}{Numpad2}{Numpad0}{Numpad0}{Alt Up}
return
!+ç:: ; alt + shift + c = c cedille maj
Send {Alt Down}{Numpad0}{Numpad1}{Numpad9}{Numpad9}{Alt Up}
return
<^>!space:: ; AltGr + space = espace insecable
Send {Alt Down}{Numpad0}{Numpad1}{Numpad6}{Numpad0}{Alt Up}
return
<^>!;:: ; altGr + point-virgule = point median
Send {Alt Down}{Numpad0}{Numpad1}{Numpad8}{Numpad3}{Alt Up}
return

; ------ AltTab ------
RControl & RShift::AltTab  ; Hold down right-control then press right-shift repeatedly to move forward.
RControl & Enter::ShiftAltTab  ; Without even having to release right-control, press Enter to reverse direction.


WheelDown::AltTab
WheelUp::ShiftAltTab

;---- Media ----
^Numpad4::
F13::
Send {Media_Play_Pause}
return

^NumpadMult::
F13 & RButton::
Send {Media_Next}
return

^Numpad6::
F13 & LButton::
Send {Media_Prev}
return

; ----- Brightness adjust with Win + Wheel -----

#WheelDown::BrightnessSetter.SetBrightness(-7)

#WheelUp::BrightnessSetter.SetBrightness(7)


;---- Raccourcis clavier pour lancer des programmes -----

^!R::
run, D:\simar\Documents\Applis\Everything\Everything.exe
return

^!M::
run, thunderbird.exe
return

^!F::
run, C:\Program Files\Mozilla Firefox\firefox.exe
return



;---- Instant applications switcher ----

!é::       ; Firefox
IfWinNotExist, ahk_class MozillaWindowClass
	Run, firefox.exe
if WinActive("ahk_exe firefox.exe")
	Send ^{tab}
else{
	WinActivatebottom ahk_exe firefox.exe
		;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
		;the below code should fix that.
	WinGet, hWnd, ID, ahk_class MozillaWindowClass
	DllCall("SetForegroundWindow", UInt, hWnd) 
}
return

!&::     ; Explorer
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, explorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, explorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
return

!"::      ; Discord
If(!WinExist(ahk_exe Discord.exe)){
	Run, C:\Users\simar\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk
}
if(!winActive(ahk_exe Discord.exe)){
	WinActivate, ahk_exe Discord.exe
}
return


!'::     ; Configurable	
KeyWait, ', T1
if(ErrorLevel){
	global shortcut_1_id
	WinGet, shortcut_1_id, ID, A
	tt("Configured", 1)
}
else{
	WinActivate, shortcut_1_id
	tt("Activated", 1)
}
KeyWait, '
return



;---- Record Key remapping ----
^+F22::
SendInput, {F21}
return


; ----- Rctrl for mute -----
RControl & AppsKey::Return
Rcontrol::Send {F21}


;------ Hotkeys to desactivate while in game --------
#if, is_not_in_game()
	
; ----- alt to activate window -----
Alt & AppsKey::Return
~Alt::
MouseGetPos, Xmouse, Ymouse, window_under_mouse
if (window_under_mouse != WinActive("A"))
	WinActivate, ahk_id %window_under_mouse%
return


;---- Better autoscroll ----
; Permet d'attraper la scrollbar d'une fenetre depuis n'importe ou


XButton2::
MouseGetPos, Xmouse, Ymouse, window_under_mouse
if (window_under_mouse != WinActive("A"))
	WinActivate, ahk_id %window_under_mouse%
err := FindToolBar(XScrollbar, YtopScrollbar, YbotScrollbar)
if (err = 0){
	ymidScrollbar := (YtopScrollbar + YbotScrollbar) / 2
	MouseMove, XScrollbar, ymidScrollbar
	click, down, %XScrollbar%, %ymidScrollbar%	; on clique sur le milieu de la scrollbar 
	;Box(XScrollbar, YtopScrollbar, xScrollbar, YbotScrollbar, 2, "O")
	while GetKeyState("XButton2", "P"){		; pour eviter de trop décaler la souris latéralement 
		MouseGetPos, currentXMouse, currentYMouse
		;if (currentXMouse < xScrollbar - 50 or currentXMouse > xScrollbar + 50)
		MouseMove, xScrollbar, currentYMouse
	}
	click, up
	MouseMove, %Xmouse%, %Ymouse% 	; la souris est replacée à la position d'origine
	
}
else{
	tt("Impossible de trouver une barre de défilement : erreur " . err, 2)
	
}
return



;---- Fermer appli avec un clic du bouton du milieu dans la taskbar ----

ShouldActivateMButton() {
	MouseGetPos, xpos, ypos, , ControlUnderMouse
	return ControlUnderMouse = "MSTaskListWClass1"
}

; Méthode 1 : ne marche pas avec toutes les applis

MButton::
if (ShouldActivateMButton()){
	MouseClick, Right
	Sleep, 700
	Send, {Up}
	Send, {Enter}
}
else {
	Send, {MButton}
}
return


;; Méthode 2, affiche la fenetre brievement avant la fermeture
;MButton::
;if (ShouldActivateMButton()){
;	MouseClick, Left
;	Sleep, 50
;	Send, !{F4}
;}
;else {
;	Send, {MButton}
;}
;return


;---- copie chemin d'accès à un fichier avec ctrl shift c ----


#IfWinActive ahk_class CabinetWClass ; If Windows Explorer window is active
	
^+C:: 
SendInput, !^+C
SendInput, ^c
Sleep 100
Clipboard := Clipboard
Return

; ---- Ouvrir avec Notepad++ ------
^w::
SendInput, ^c
Sleep 100
Clipboard := clipboard
file_name := clipboard
file_directory := RegExReplace(file_name, "(.*)\\[^\\]*", "$1")
file_name := RegExReplace(file_name, ".*\\([^\\]*)", "$1")
Run, "C:\Program Files (x86)\Notepad++\notepad++.exe" "%file_directory%\%file_name%" 
return

; --- New file ---
^!n::
SendInput, !^+C
ClipWait, 2
FullPath := Clipboard
InputBox, UserInput, New File (example: foo.txt), , ,400, 100
if ErrorLevel ; cancel
{
	tt("Erreur", 1)
	return
}
; success! output file with user input
else
{
	FileAppend, ,% FullPath . "\" . UserInput
	if ErrorLevel 
		tt("Erreur", 1)
}
return

#IfWinActive, ahk_exe Spotify.exe
	!s::
WinGetTitle, Query, A
StringReplace, Query, Query, `r`n, %A_Space%, All 
StringReplace, Query, Query, %A_Space%, `%20, All
StringReplace, Query, Query, #, `%23, All
Query := Trim(Query)
run, http://www.google.com/search?hl=fr&q=%Query%`%20lyrics
return

#IfWinActive, Among Us
	z::w
	q::a

#IfWinActive
	


FindToolBar(ByRef XScrollbar, ByRef YtopScrollbar, ByRef YbotScrollbar) {
	
; Cherche la scrollbar la plus appropriée selon la position du curseur. Renvoie sa position en X et la position de ses extremités en Y
	
	MouseGetPos,,,, control_under_mouse
	WinGetPos, X, Y, Width, Height, A
	Switch
	{
		Case WinActive("ahk_exe Discord.exe"):
		;IfNotExist, IMG/Discord3.png
			;MsgBox Error: Your file either doesn't exist or isn't in this location.
		;ImageSearch, XScrollbar, YtopScrollbar,Width - 300, 0, Width - 200, Height, IMG/Discord3.png
		PixelSearch, XScrollbar, YtopScrollbar, Width - 275, 65, Width - 265, Height - 50, 0x202225, 5, Fast		
		code_erreur := ErrorLevel
		PixelSearch, XScrollbar, YbotScrollbar, XScrollbar + 3, Height - 50, XScrollbar + 3, YtopScrollbar + 2, 0x202225, 5, Fast
		;XScrollbar := XScrollbar
		;YtopScrollbar := YtopScrollbar
		code_erreur := 2*ErrorLevel + code_erreur
		
		Case WinActive("ahk_exe firefox.exe"):
		;Box(Width - 20, 30, Width - 21, Height - 10, 2, "O")
		PixelSearch, XScrollbar, YtopScrollbar, Width - 20, 30, Width - 21, Height - 10, 0xCDCDCD, 0, RGB Fast
		if(ErrorLevel) 
			PixelSearch, XScrollbar, YtopScrollbar, Width - 20, 30, Width - 21, Height - 10, 0x767576, 5, RGB Fast
		code_erreur := ErrorLevel
		
		PixelSearch, , YbotScrollbar, XScrollbar, Height - 10, XScrollbar, 30, 0xCDCDCD, 0, RGB Fast
		if(ErrorLevel)
			PixelSearch, , YbotScrollbar, XScrollbar, Height - 10, XScrollbar, 30, 0x767576, 5, RGB Fast
		code_erreur2 := ErrorLevel
		code_erreur := 2*code_erreur2 + code_erreur
		
		Case WinActive("ahk_exe Spotify.exe"):
		PixelSearch, XScrollbar, YtopScrollbar, Width - 20, 30, Width - 21, Height - 10, 0x535353, 0, Fast
		code_erreur := ErrorLevel
		PixelSearch, XScrollbar, YbotScrollbar, XScrollbar, Height - 10, XScrollbar, 30, 0x535353, 0, Fast	; cherche la position du haut de la scrollbar
		code_erreur := 2*ErrorLevel + code_erreur
		
		Case WinActive("ahk_class CabinetWClass"): 	; explorer
		if (control_under_mouse == "SysTreeView321"){	; si la souris est au dessus de l'explorateur de fichier, on modifie les valeurs de width et height
			ControlGetPos, , , Width, , SysTreeView321, ahk_class CabinetWClass
			Width := Width + 15
		}
		; ToolTip, %control_under_mouse%. .%Width%, %Width%, %Height%												Debug
		PixelSearch, XScrollbar, YtopScrollbar, Width - 20, 30, Width - 15, Height - 10, 0xCDCDCD, 1, Fast
		code_erreur := ErrorLevel
		PixelSearch, XScrollbar, YbotScrollbar, XScrollbar, Height - 10, XScrollbar, 30, 0xCDCDCD, 1, Fast	
		code_erreur := 2*ErrorLevel + code_erreur
		
		Case (WinActive("ahk_class AutoHotkeyGUI") and control_under_mouse == "Scintilla2"):
		ControlGetPos, , , Width, Height , Scintilla2
		PixelSearch, XScrollbar, YtopScrollbar, Width - 2, 0, Width + 2, Height - 5, 0xCDCDCD, 10, Fast
		code_erreur := ErrorLevel
		PixelSearch, XScrollbar, YbotScrollbar, XScrollbar, Height - 5, XScrollbar, 0, 0xCDCDCD, 10, Fast	; cherche la position du haut de la scrollbar
		code_erreur := 2*ErrorLevel + code_erreur
		
		Case WinActive("ahk_exe WINWORD.exe"):
		PixelSearch, xScrollbar, upButton, width - 10, 63, width - 11, 180, 0xFFFFFF, 0, Fast
		code_erreur := ErrorLevel
		PixelSearch, , YbotScrollbar, xScrollbar, upButton + 13, xScrollbar, Height - 40, 0xFFFFFF, 0, Fast
		code_erreur := ErrorLevel
		PixelSearch, , YbotScrollbar, xScrollbar, Height - 40, xScrollbar, upButton + 13, 0xFFFFFF, 0, Fast		
		code_erreur := 2*ErrorLevel + code_erreur
		
		Case WinActive("ahk_exe EXCEL.exe"):
		PixelSearch, , YtopScrollbar, xScrollbar, Y + 17, xScrollbar, Y + Height - 17, 0xFFFFFF, 0, Fast
		code_erreur := ErrorLevel
		PixelSearch, , YbotScrollbar, xScrollbar, Y + Height - 17, xScrollbar, Y + 17, 0xFFFFFF, 0, Fast		
		code_erreur := 2*ErrorLevel + code_erreur
		
		Default:
		PixelSearch, XScrollbar, YtopScrollbar, Width - 20, 30, Width - 21, Height - 10, 0xCDCDCD, 0, Fast   ; cherche la position du bas de la scrollbar
		if ErrorLevel
			PixelSearch, XScrollbar, YtopScrollbar, Width - 20, 30, Width - 21, Height - 10, 0xA6A6A6, 0, Fast	; si la couleur n'est pas trouvée, on tente la couleur foncée
		code_erreur := ErrorLevel
		
		
		PixelSearch, , YbotScrollbar, XScrollbar, Height - 10, XScrollbar, 30, 0xCDCDCD, 0, Fast	; cherche la position du haut de la scrollbar
		if ErrorLevel
			PixelSearch, , YbotScrollbar, XScrollbar, Height - 10, XScrollbar, 30, 0xA6A6A6, 0, Fast
		code_erreur := ErrorLevel*2 + code_erreur
		
		
	}
	return code_erreur
}





;function to start, then activate any given application
openApp(theClass, theEXE, theTitle := ""){
;Keyshower(theEXE, "openApp") ;leads to a function that shows the keypresses onscreen
	if IsFunc("Keyshower") {
		Func := Func("Keyshower")
		RetVal := Func.Call(theEXE, "openApp") 
	}
	IfWinNotExist, %theClass%
		Run, % theEXE
	if not WinActive(theClass)
	{
		WinActivate %theClass%
	;WinGetTitle, Title, A
		WinRestore %theTitle%
	}
}



