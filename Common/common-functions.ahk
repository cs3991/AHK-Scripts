#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

is_not_in_game(){
	return, (!winActive("Overwatch")&!WinActive("Minecraft")&!WinActive("ahk_exe r5apex.exe")&!WinActive("The Cycle")&!WinActive("ahk_exe VALORANT-Win64-Shipping.exe")&!WinActive("ahk_exe Hyperscape.exe")&!winActive("Among Us")&!winActive("Counter-Strike: Global Offensive")&!winActive("FCT"))
}

RemoveToolTip:
ToolTip
return

tt(message, time){
	ToolTip, % message
	SetTimer, RemoveToolTip, % time*1000
}


;Draw a box


/*
	Box_Init - Creates the necessary GUIs.
	
	C - The color of the box.
*/

Box_Init(C="FF0000") {
	Gui, 96: +ToolWindow -Caption +AlwaysOnTop +LastFound
	Gui, 96: Color, % C
	Gui, 97: +ToolWindow -Caption +AlwaysOnTop +LastFound
	Gui, 97: Color, % C
	Gui, 98: +ToolWindow -Caption +AlwaysOnTop +LastFound
	Gui, 98: Color, % C
	Gui, 99: +ToolWindow -Caption +AlwaysOnTop +LastFound
	Gui, 99: Color, % C
}

/*
	Box_Draw - Draws a box on the screen using 4 GUIs.
	
	X - The X coord.
	
	Y - The Y coord.
	
	W - The width of the box.
	
	H - The height of the box.
	
	T - The thickness of the borders.
	
	O - The offset. O - Outside. C - Centered. I - Inside.
*/

Box(X, Y, X2, Y2, T="1", O="I") {
	WinGetPos X, Y, Width, Height, "A"
	Box_Destroy()
	Box_Init()
	;if (X > X2) {
		;X3 := X2
		;X := X2
		;X2 := X3
	;}
	;if (Y > Y2) {
		;Y3 := Y2
		;Y := Y2
		;Y2 := Y3
	;}
	W := X2 - X
	H := Y2 - Y
	If(W < 0)
		X += W, W *= -1
	If(H < 0)
		Y += H, H *= -1
	If(T >= 2)
	{
		If(O == "O")
			X -= T, Y -= T, W += T, H += T
		If(O == "C")
			X -= T / 2, Y -= T / 2
		If(O == "I")
			W -= T, H -= T
	}
	Gui, 96: Show, % "x" X " y" Y " w" W " h" T " NA", Horizontal 1
	Gui, 98: Show, % "x" X " y" Y + H " w" W " h" T " NA", Horizontal 2
	Gui, 97: Show, % "x" X " y" Y " w" T " h" H " NA", Vertical 1
	Gui, 99: Show, % "x" X + W " y" Y " w" T " h" H " NA", Vertical 2
}

/*
	Box_Destroy - Destoyes the 4 GUIs.
*/

Box_Destroy() {
	Loop, 4
		Gui, % A_Index + 95 ":  Destroy"
}

/*
	Box_Hide - Hides the 4 GUIs.
*/

Box_Hide() {
	Loop, 4
		Gui, % A_Index + 95 ":  Hide"
}