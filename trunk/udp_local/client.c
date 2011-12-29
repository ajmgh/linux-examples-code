#include <stdio.h>
#include <sys/types.h>          /* See NOTES */
#include <sys/socket.h>
#include <string.h>
#include <sys/un.h>
#include <errno.h>
#define UPDATE_PATH "/tmp/.update"

int main()
{
        int fd = -1,leng = -1;
        struct sockaddr_un stLocal;  
        memset(&stLocal,0x00,sizeof(stLocal));
        if ((fd = socket(PF_UNIX, SOCK_DGRAM, 0)) < 0)   
        {   
                printf("create socket error:%s\n",strerror(errno));   
                return -1;   
        }     
		leng = sizeof(stLocal);
        stLocal.sun_family = AF_LOCAL;   
        strncpy(stLocal.sun_path, UPDATE_PATH, sizeof(stLocal.sun_path)-1);
	if(sendto(fd,"1", 1, 0,(struct sockaddr*)&stLocal, sizeof(stLocal))<=0){
		printf("ui Sendto error => %s\n", strerror(errno));
	}
        return 0;  
}
