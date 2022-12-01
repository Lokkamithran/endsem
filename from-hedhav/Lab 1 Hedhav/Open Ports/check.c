#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

int main()
{
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    int socketfd;
    int count = 0;

    for (int i = 0; i < 65535; i++)
    {
        int socketfd = socket(AF_INET, SOCK_STREAM, 0);

        if (socketfd == -1)
        {
            printf("Error creating socket.\n");
            exit(1);
        }

        addr.sin_port = htons(i);
        int fail = connect(socketfd, (struct sockaddr *)&addr, sizeof(addr));

        if (!fail)
            printf("Port %d is open\n", i);

        close(socketfd);
    }

    return 0;
}