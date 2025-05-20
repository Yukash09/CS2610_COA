#include <stdio.h>
extern int reverse(char* str) ; 
extern char rstr[100]  ;
int main(){
   char* str = "Hel World" ;
   int len = reverse(str) ;
   printf("Input_string: %s\n" , str) ;
   printf("reverse_string: %s , length = %d\n" , rstr , len) ;
}
