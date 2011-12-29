#include <stdio.h>  
#include <unistd.h>
#include <sys/types.h>  
#include <sys/socket.h>  
#include <sys/un.h>   

#define POWER_STANDBY_CONTRL_DOMAIN "/tmp/power_standby_control"   


int main(void)   
{   
    	socklen_t clt_addr_len;   
    	int listen_fd;   
    	int com_fd;   
    	int ret;   
    	int i;   
    	char recv_buf[256] = {0};    
    	int len, num;   
	int firstboot = 1;
    	struct sockaddr_un clt_addr;   
    	struct sockaddr_un srv_addr;   
    	listen_fd=socket(PF_UNIX, SOCK_STREAM, 0);   
    	if(listen_fd<0)   
    	{   
        	perror("cannot create communication socket");   
        	return 1;   
    	}     
       
    	//set server addr_param   
    	srv_addr.sun_family = AF_UNIX;   
    	strncpy(srv_addr.sun_path, POWER_STANDBY_CONTRL_DOMAIN, sizeof(srv_addr.sun_path)-1);   
    	unlink(POWER_STANDBY_CONTRL_DOMAIN);   
    	//bind sockfd & addr   
    	ret=bind(listen_fd,(struct sockaddr*)&srv_addr,sizeof(srv_addr));   
    	if(ret==-1)   
    	{	   
        	perror("cannot bind server socket");   
        	close(listen_fd);   
        	unlink(POWER_STANDBY_CONTRL_DOMAIN);   
        	return 1;   
    	}   
    	//listen sockfd    
    	ret=listen(listen_fd,1);   
    	if(ret==-1)   
    	{   
        	perror("cannot listen the client connect request");   
        	close(listen_fd);   
        	unlink(POWER_STANDBY_CONTRL_DOMAIN);   
        	return 1;   
    	}   
    	//have connect request use accept   
    	len=sizeof(clt_addr);   

	while(1) 
	{	
        	memset(recv_buf, 0, sizeof(recv_buf));   
		com_fd = accept(listen_fd, (struct sockaddr*)&clt_addr, &len);
		if(com_fd < 0) {
			perror("cannot accept client connect request");  
		}
		num = read(com_fd, recv_buf, sizeof(recv_buf));
        	printf("Message from client (%d)) :%s\n",num, recv_buf);     
        	//stb_cmd_parse(recv_buf);
		close(com_fd);
		usleep(10000);
	}

	close(listen_fd);
	unlink(POWER_STANDBY_CONTRL_DOMAIN);

    	return 0;   
}
