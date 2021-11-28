#include <signal.h>
#incude <stdio.h>
#include <unistd.h>

unsigned int alarmCount = 0;

void mySignalHandler(int theSignal){
printf("reception d'un signal"% d\n, theSignal);
}
void myAlarmHandler(int thesignal){
printf("pid %d est actif. \n" getpid());
alarmCount  = alarmCount +1;
alarm(5);
}


int main () {
    int errorCode;

    struct sigaction theSigaction;
    theSigaction.sa_handler = mySignalHandler;

    for (unsigned int i= 1; i< NSIG; i++){
             errorCode = sigaction(i, &theSigaction, NULL);
             if(errorCode ==-1){
                 printf("%d...\n);
                 perror("sigaction");
          }}}
    theSigaction.sa_handler = myAlarmHandler;
    sigaction(SIGALARM, &theSigaction, NULL);
    alarm(5);
    fork();
    while(alarmCount < 12){

         pause();
    }
    return 0;


