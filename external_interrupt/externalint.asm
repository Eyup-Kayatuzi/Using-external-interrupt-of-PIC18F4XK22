
_interrupt:

;externalint.c,6 :: 		void interrupt(){
;externalint.c,7 :: 		if(INT0IF_bit == 1){
	BTFSS       INT0IF_bit+0, BitPos(INT0IF_bit+0) 
	GOTO        L_interrupt0
;externalint.c,8 :: 		flag = 1;
	MOVLW       1
	MOVWF       _flag+0 
;externalint.c,9 :: 		INT0IF_bit = 0; // clearing of interrupt flag
	BCF         INT0IF_bit+0, BitPos(INT0IF_bit+0) 
;externalint.c,10 :: 		}
L_interrupt0:
;externalint.c,11 :: 		}
L_end_interrupt:
L__interrupt11:
	RETFIE      1
; end of _interrupt

_Blink_int:

;externalint.c,13 :: 		void Blink_int(){
;externalint.c,14 :: 		for(x =1; x <= 5; x++){ // loop 5 times
	MOVLW       1
	MOVWF       _x+0 
L_Blink_int1:
	MOVF        _x+0, 0 
	SUBLW       5
	BTFSS       STATUS+0, 0 
	GOTO        L_Blink_int2
;externalint.c,15 :: 		LATB.B5 = 1;
	BSF         LATB+0, 5 
;externalint.c,16 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_Blink_int4:
	DECFSZ      R13, 1, 1
	BRA         L_Blink_int4
	DECFSZ      R12, 1, 1
	BRA         L_Blink_int4
	DECFSZ      R11, 1, 1
	BRA         L_Blink_int4
;externalint.c,17 :: 		LATB.B5 = 0;
	BCF         LATB+0, 5 
;externalint.c,18 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_Blink_int5:
	DECFSZ      R13, 1, 1
	BRA         L_Blink_int5
	DECFSZ      R12, 1, 1
	BRA         L_Blink_int5
	DECFSZ      R11, 1, 1
	BRA         L_Blink_int5
;externalint.c,14 :: 		for(x =1; x <= 5; x++){ // loop 5 times
	INCF        _x+0, 1 
;externalint.c,19 :: 		}
	GOTO        L_Blink_int1
L_Blink_int2:
;externalint.c,20 :: 		}
L_end_Blink_int:
	RETURN      0
; end of _Blink_int

_main:

;externalint.c,22 :: 		void main() {
;externalint.c,23 :: 		OSCCON = 0x62;
	MOVLW       98
	MOVWF       OSCCON+0 
;externalint.c,24 :: 		ANSELB = 0; // portb as digital
	CLRF        ANSELB+0 
;externalint.c,25 :: 		TRISB = 0x01; // portb pin 0 input and rest is output
	MOVLW       1
	MOVWF       TRISB+0 
;externalint.c,26 :: 		LATB = 0x00;
	CLRF        LATB+0 
;externalint.c,27 :: 		flag = 0;
	CLRF        _flag+0 
;externalint.c,28 :: 		INTEDG0_bit = 0; // Set interrupt on falling edge
	BCF         INTEDG0_bit+0, BitPos(INTEDG0_bit+0) 
;externalint.c,29 :: 		INT0IF_bit = 0; // clears int0 flag
	BCF         INT0IF_bit+0, BitPos(INT0IF_bit+0) 
;externalint.c,30 :: 		INT0IE_bit = 1; // enable int0 interrupt
	BSF         INT0IE_bit+0, BitPos(INT0IE_bit+0) 
;externalint.c,31 :: 		GIE_bit = 1; // enable GLOBAL Interrupts
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;externalint.c,33 :: 		while(1){ // endless loop
L_main6:
;externalint.c,34 :: 		LATB.B4 = ~LATB.B4;
	BTG         LATB+0, 4 
;externalint.c,35 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
	NOP
;externalint.c,37 :: 		if(flag){ // check if there is an interrupt call
	MOVF        _flag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
;externalint.c,38 :: 		Blink_int();
	CALL        _Blink_int+0, 0
;externalint.c,39 :: 		flag = 0;
	CLRF        _flag+0 
;externalint.c,40 :: 		}
L_main9:
;externalint.c,41 :: 		}
	GOTO        L_main6
;externalint.c,42 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
