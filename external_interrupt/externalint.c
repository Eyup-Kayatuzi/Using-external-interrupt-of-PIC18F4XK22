#include "stdint.h"

uint8_t flag;
uint8_t x;

void interrupt(){
     if(INT0IF_bit == 1){
                   flag = 1;
                   INT0IF_bit = 0; // clearing of interrupt flag
     }
}

void Blink_int(){
     for(x =1; x <= 5; x++){ // loop 5 times
           LATB.B5 = 1;
           Delay_ms(200);
           LATB.B5 = 0;
           Delay_ms(200);
     }
}

void main() {
      OSCCON = 0x62;
      ANSELB = 0; // portb as digital
      TRISB = 0x01; // portb pin 0 input and rest is output
      LATB = 0x00;
      flag = 0;
      INTEDG0_bit = 0; // Set interrupt on falling edge
      INT0IF_bit = 0; // clears int0 flag
      INT0IE_bit = 1; // enable int0 interrupt
      GIE_bit = 1; // enable GLOBAL Interrupts

      while(1){ // endless loop
               LATB.B4 = ~LATB.B4;
               Delay_ms(1000);

               if(flag){ // check if there is an interrupt call
                         Blink_int();
                         flag = 0;
               }
      }
}