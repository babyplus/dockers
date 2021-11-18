# repeated ping  

## deployment  

### modify hosts file  

* file: etc/ansible/hosts  

### modify peers  

* file:   etc/ansible/yml/repeated_ping.config  
* value:  peers  

### modify the path of result  

* file:    etc/ansible/yml/repeated_ping.config  
* value:   result_file_path  
* default: /tmp  

### modify the interval  

* file:    etc/ansible/yml/repeated_ping.config  
* value:   ping_interval  
* default: 30  

## scripts  

### ping test     

```
cd scripts  
nohup bash repeated_ping.sh &>/dev/null &  
```
