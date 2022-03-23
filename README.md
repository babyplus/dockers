# Build image

```
docker build -t subscriber .
```

# Subscribe messaging

```
docker run -v /root/.ssh:/root/.ssh --net host -it --rm subscriber subscribe CHANNEL_TEST 127.0.0.1
```

# Publish messaging

```
docker run -it --network host --rm redis redis-cli publish CHANNEL_TEST "20220323 127.0.0.1 echo"
```
