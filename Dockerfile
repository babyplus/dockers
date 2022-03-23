FROM gcc:4.9
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN cd sshpass-master && ./configure && make && make install  
RUN cd hiredis && make && make install  
RUN gcc -l hiredis -I /usr/local/include/hiredis/ subscribe.c -o subscribe ; chmod +x subscribe; mv subscribe /usr/local/bin/
ENV LD_LIBRARY_PATH=/usr/local/lib/
RUN chmod +x plugins/CHANNEL_* && mv plugins/CHANNEL_* /usr/local/bin/
CMD ["bash"]
