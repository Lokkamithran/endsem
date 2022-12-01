#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

int main()
{
    int socketfd;
    int no_of_bytes;
    char msg[256];
    char ping[10];
    struct sockaddr_in addr;
    socklen_t client_len;

    client_len = sizeof(addr);

    socketfd = socket(AF_INET, SOCK_DGRAM, 0);

    struct sockaddr_in server_addr;
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(50000);
    server_addr.sin_addr.s_addr = INADDR_ANY;

    no_of_bytes = bind(socketfd, (struct sockaddr *)&server_addr, sizeof(server_addr));
    if (no_of_bytes == -1)
    {
        printf("Error while binding\n");
        exit(1);
    }

    no_of_bytes = recvfrom(socketfd, msg, sizeof(msg), 0, (struct sockaddr *)&addr, &client_len);
    if (no_of_bytes == -1)
    {
        printf("error receiving message from client.\n");
        exit(1);
    }

    printf("Client sent character: %s\n", msg);

    if (msg[0] == 'a')
    {
        msg[0] = 'z';
    }
    else if (msg[0] == 'A')
    {
        msg[0] = 'Z';
    }
    else
    {
        msg[0] = msg[0] - 1;
    }

    // Ping from client2 for the server to know IP address and port
    no_of_bytes = recvfrom(socketfd, ping, sizeof(ping), 0, (struct sockaddr *)&addr, &client_len);
    if (no_of_bytes == -1)
    {
        printf("error receiving message from client.\n");
        exit(1);
    }

    no_of_bytes = sendto(socketfd, msg, sizeof(msg), 0, (struct sockaddr *)&addr, client_len);
    if (no_of_bytes == -1)
    {
        printf("Error while sending message.\n");
        exit(1);
    }

    printf("Done.\n");

    close(socketfd);
    return 0;
}
