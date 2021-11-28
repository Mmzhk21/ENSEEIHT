#include <signal.h>
#include <stdio.h>
#include <unistd.h>



void mySignalHandler(
int theSignal
){
printf("reception d'un signal.%d\n", theSignal);
}
int main () {
struct sigaction theSigaction;
theSigaction.sa_handler = mySignalHandler;

for (unsigned int i= 1; i< NSIG; i++){
sigaction(i, &theSigaction, NULL);
}
while(1){
fork();
}
 return 0;

