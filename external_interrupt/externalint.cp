#line 1 "C:/Users/ARGE/Desktop/MicroC_Folder2/external_interrupt/externalint.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 3 "C:/Users/ARGE/Desktop/MicroC_Folder2/external_interrupt/externalint.c"
uint8_t flag;
uint8_t x;

void interrupt(){
 if(INT0IF_bit == 1){
 flag = 1;
 INT0IF_bit = 0;
 }
}

void Blink_int(){
 for(x =1; x <= 5; x++){
 LATB.B5 = 1;
 Delay_ms(200);
 LATB.B5 = 0;
 Delay_ms(200);
 }
}

void main() {
 OSCCON = 0x62;
 ANSELB = 0;
 TRISB = 0x01;
 LATB = 0x00;
 flag = 0;
 INTEDG0_bit = 0;
 INT0IF_bit = 0;
 INT0IE_bit = 1;
 GIE_bit = 1;

 while(1){
 LATB.B4 = ~LATB.B4;
 Delay_ms(1000);

 if(flag){
 Blink_int();
 flag = 0;
 }
 }
}
