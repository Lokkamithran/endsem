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
    char msg[1024];

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

    no_of_bytes = sendto(socketfd, msg, sizeof(msg), 0, (struct sockaddr *)&addr, len);
    if (no_of_bytes == -1)
    {
        printf("Error sending message\n");
        exit(1);
    }

    no_of_bytes = recvfrom(socketfd, msg, sizeof(msg), 0, (struct sockaddr *)&addr, &len);
    if (no_of_bytes == -1)
    {
        printf("Error receiving message\n");
        exit(1);
    }
    printf("Server sent: ");
    printf("%s\n", msg);

    close(socketfd);

    return 0;
}
