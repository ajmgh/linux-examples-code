#include <stdio.h>
#include <sys/types.h>         
#include <sys/socket.h>
#include <sys/un.h>   

#define BUFSIZE 8192
#define INOTIFY_INTERACTIVE_DOMAIN "/tmp/inotify_interactive_domain"   
#define SENDSTR "ybz21_test_client"

int main(int argc,char *argv[])
{
	int connect_fd;
	int ret;
	char buf[BUFSIZE];
	int i, len;
	static struct sockaddr_un pin;

	//creat unix socket
	connect_fd=socket(PF_UNIX,SOCK_STREAM,0);
	if(connect_fd<0)
	{
		perror("cannot create communication socket");
		return -1;
	}   
	pin.sun_family=AF_UNIX;
	strcpy(pin.sun_path, INOTIFY_INTERACTIVE_DOMAIN);
	//connect server
	ret=connect(connect_fd,(struct sockaddr*)&pin,sizeof(pin));
	if(ret==-1)
	{
		perror("cannot connect to the server");
		close(connect_fd);
		return -1;
	}

	memset(buf,0,BUFSIZE);
	strcpy(buf, SENDSTR);
	printf("Sending message %s to server ...\n", buf);

	if(send(connect_fd, buf, sizeof(buf), 0) == -1)
	{
		perror("Error in send\n");
		return -1;
	}

	printf("..sent message.. wait for response...\n");

	while(1)
	{
		memset(buf, 0x00, BUFSIZE);
		if(recv(connect_fd, buf, BUFSIZE, 0) == -1)
		{
			perror("Error in receiving response from server\n");
			return -1;
		}
		
		len = strlen(buf);
		printf("\nResponse form server buf len = %d\n", len);
		printf("\nResponse form server: \n%s\n", buf);
		//usleep(10000);
		sleep(1);
	}
	close(connect_fd);
	return 0;	
}
