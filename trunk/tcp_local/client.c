#include <stdio.h>
#include <sys/types.h>         
#include <sys/socket.h>
#include <sys/un.h>   

#define POWER_STANDBY_CONTRL_DOMAIN "/tmp/power_standby_control"   

int main(int argc,char *argv[])
{
   	int connect_fd;
    	int ret;
    	char snd_buf[1024];
    	int i;
    	static struct sockaddr_un srv_addr;

	//creat unix socket
    	connect_fd=socket(PF_UNIX,SOCK_STREAM,0);
    	if(connect_fd<0)
    	{
        	perror("cannot create communication socket");
        	return 1;
    	}   
    	srv_addr.sun_family=AF_UNIX;
    	strcpy(srv_addr.sun_path, POWER_STANDBY_CONTRL_DOMAIN);
	//connect server
    	ret=connect(connect_fd,(struct sockaddr*)&srv_addr,sizeof(srv_addr));
    	if(ret==-1)
    	{
        	perror("cannot connect to the server");
        	close(connect_fd);
        	return 1;
    	}
    	memset(snd_buf,0,1024);
		
    	strcpy(snd_buf,"CMD_GOTO_STANDBY");

	//send info server
      	write(connect_fd,snd_buf, sizeof(snd_buf));

	close(connect_fd);
    	return 0;	
}
