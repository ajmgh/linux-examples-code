/* server.c
 * Copyright Mark Watson 1999. Open Source Software License.
 */

#include <stdio.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>      

#define BUFSIZE 16384
#define INOTIFY_INTERACTIVE_DOMAIN "/tmp/inotify_interactive_domain"   

void main() {
	struct sockaddr_un sin;
	struct sockaddr_un pin;
	int sock_descriptor;
	int temp_sock_descriptor;
	int address_size;
	char buf[BUFSIZE];
	int i, len;

	sock_descriptor = socket(AF_UNIX, SOCK_STREAM, 0);
	if (sock_descriptor == -1) {
		perror("call to socket");
		return -1;
	}

	bzero(&sin, sizeof(sin));
	sin.sun_family = AF_UNIX;
	strncpy(sin.sun_path, INOTIFY_INTERACTIVE_DOMAIN, sizeof(sin.sun_path)-1);   
	unlink(INOTIFY_INTERACTIVE_DOMAIN);   

	if (bind(sock_descriptor, (struct sockaddr *)&sin, sizeof(sin)) == -1) {
		perror("call to bind");
		close(sock_descriptor);   
		unlink(INOTIFY_INTERACTIVE_DOMAIN);   
		return -1;
	}

	if (listen(sock_descriptor, 20) == -1) {
		perror("call to listen");
		close(sock_descriptor);   
		unlink(INOTIFY_INTERACTIVE_DOMAIN);   
		return -1;
	}

	printf("Accepting connections ...\n"); 

	while(1) {
		memset(buf, 0, BUFSIZE);
		temp_sock_descriptor =
			accept(sock_descriptor, (struct sockaddr *)&pin,
					&address_size);
		if (temp_sock_descriptor == -1) {
			perror("call to accept");
			return -1;
		}

		if (recv(temp_sock_descriptor, buf, BUFSIZE, 0) == -1) {
			perror("call to recv");
			return -1;
		}

		printf("received from client:%s\n", buf);

		// for this server example, we just convert the
		// characters to upper case:

		len = strlen(buf);
		printf("received from client buf len = %d\n", len);
		for (i=0; i<len; i++) buf[i] = toupper(buf[i]);

		if (send(temp_sock_descriptor, buf, len, 0) == -1) {
			perror("call to send");
			return -1;
		}

		close(temp_sock_descriptor);
	 	usleep(10000);
	}
}
