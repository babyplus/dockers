#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <hiredis.h>

#ifdef _MSC_VER
#include <winsock2.h> /* For struct timeval */
#endif

int main(int argc, char **argv) {
    unsigned int j, isunix = 0;
    redisContext *c;
    redisReply *reply;
    if (1 == argc) {
        printf("missing parameters\n");
        exit(1);
    }
    const char *channel = (argc > 1) ? argv[1] : "CHANNEL_TEST";
    const char *hostname = (argc > 2) ? argv[2] : "127.0.0.1";

    if (argc > 3) {
        if (*argv[3] == 'u' || *argv[3] == 'U') {
            isunix = 1;
            /* in this case, host is the path to the unix socket */
            printf("Will connect to unix socket @%s\n", hostname);
        }
    }

    int port = (argc > 3) ? atoi(argv[3]) : 6379;

    struct timeval timeout = { 1, 500000 }; // 1.5 seconds
    if (isunix) {
        c = redisConnectUnixWithTimeout(hostname, timeout);
    } else {
        c = redisConnectWithTimeout(hostname, port, timeout);
    }
    if (c == NULL || c->err) {
        if (c) {
            printf("Connection error: %s\n", c->errstr);
            redisFree(c);
        } else {
            printf("Connection error: can't allocate redis context\n");
        }
        exit(1);
    }

    /* subscribe the channel */
    reply = redisCommand(c, "SUBSCRIBE %s", channel);
    freeReplyObject(reply);
    while(redisGetReply(c,(void *)&reply) == REDIS_OK) {
        // consume message
        if (reply->type == REDIS_REPLY_ARRAY) {
            char buff[128] = {0};
            char cmd[1024] = "";
            sprintf(cmd, "%s %s", channel, reply->element[2]->str);
            FILE * fp = popen(cmd , "r");
            fread(buff, 1, 127, fp);
            printf("%s", buff);
            pclose(fp);
        }
        freeReplyObject(reply);
    }

    /* Disconnects and frees the context */
    redisFree(c);

    return 0;
}

