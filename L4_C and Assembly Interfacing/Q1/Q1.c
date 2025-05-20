#include <stdio.h>
char* cname ;
char* getCourse(){
    cname = "Course" ;
    return cname ;
}

void displayStudentProfile(char* fname , char* lname , char* cname){
    printf("First Name:%s , Last Name: %s , Course: %s\n" , fname , lname , cname) ;
}
