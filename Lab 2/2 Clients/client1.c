#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <unistd.h>

int main()
{
    int socketfd;
    int no_of_bytes;
    struct sockaddr_in addr;
    socklen_t len;
    char msg[2];

    len = sizeof(addr);

    socketfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (socketfd == -1)
    {
        printf("Error creating socket\n");
        exit(1);
    }

    addr.sin_family = AF_INET;
    addr.sin_port = htons(50000);
    addr.sin_addr.s_addr = INADDR_ANY;

    printf("Enter character to send: ");
    fgets(msg, sizeof(msg), stdin);

    no_of_bytes = sendto(socketfd, msg, sizeof(msg), 0, (struct sockaddr *)&addr, len);
    if (no_of_bytes == -1)
    {
        printf("Error sending message\n");
        exit(1);
    }

    printf("Message sent\n");
    close(socketfd);
    return 0;
}
