// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
(KEY_CHECK)
	@KBD
	D=M

	@FILL
	D;JGT //fill the screen if any key is pressed

	@NOFILL
	D;JEQ //empty the screen if no key is pressed

	@KEY_CHECK
	0;JMP //infinite loop zeroing the program

(FILL)
	@fillwith
	M=-1
	@DRAW
	0;JMP

(NOFILL)
	@fillwith
	M=0
	@DRAW
	0;JMP

(DRAW)
	@SCREEN
	D=A
	@addr
	M=D /// screen's base address

	@i
	M=0

	(LOOP)
		@i
		D=M
		@8191
		D=D-A
		@KEY_CHECK
		D;JGT // if i>8191 go to KEYCHECK

		@fillwith
		D=M
		@addr
		A=M
		M=D // RAM[addr] = @fillwith content

		@i
		M=M+1 // i++
		@addr
		M=M+1 // addr++
		@LOOP
		0;JMP
