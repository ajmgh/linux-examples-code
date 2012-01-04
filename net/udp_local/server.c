#include <stdio.h>
#include <sys/types.h>          /* See NOTES */
#include <sys/socket.h>
#include <string.h>
#include <sys/un.h>
#include <errno.h>
#define UPDATE_PATH "/tmp/.update"

int main()
{
        int fd = -1;
		char buf[10] = {0};
        struct sockaddr_un stLocal;  
        memset(&stLocal,0x00,sizeof(stLocal));
		
        unlink(UPDATE_PATH);  
        if ((fd = socket(PF_UNIX, SOCK_DGRAM, 0)) < 0)   
        {   
                printf("create socket error:%s\n",strerror(errno));   
                return -1;   
        }     
        stLocal.sun_family = AF_LOCAL;   
        strncpy(stLocal.sun_path, UPDATE_PATH, sizeof(stLocal.sun_path)-1);      
        if (-1 == bind(fd,(struct sockaddr*)&stLocal,sizeof(stLocal)))   
        {          
                printf("bind socket error:%s\n",strerror(errno));   
                close(fd);   
                unlink(UPDATE_PATH);   
                return -1;   
        } 
	if(recvfrom(fd,buf,1, 0,NULL, NULL)<=0){
		printf("ui Sendto error => %s\n", strerror(errno));
	}
	printf("buf is %s\n",buf);
        unlink(UPDATE_PATH); 
	close(fd); 
        return 0;  
}
