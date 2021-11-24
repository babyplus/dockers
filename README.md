# repeated ping  

## deployment  

### modify hosts file  

Modify the master group as appropriate to connect to the hosts via SSH.  

* file: etc/ansible/hosts  

### set the peers  

* file:   etc/ansible/yml/repeated_ping.config  
* value:  peers  

### set the path of result  

* file:    etc/ansible/yml/repeated_ping.config  
* value:   result_file_path  
* default: /tmp  

### set the interval  

* file:    etc/ansible/yml/repeated_ping.config  
* value:   ping_interval  
* default: 30  

## scripts  

### ping test   

```
cd scripts  
bash repeated_ping.sh  
```

### ping test daemon    

```
cd scripts  
nohup bash repeated_ping.sh &>/dev/null &  
```
