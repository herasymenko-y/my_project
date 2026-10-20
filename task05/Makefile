CC= $(CROSS_COMPILE)gcc
CFLAGS= -Wextra -Wall -static


TARGET_IP = 192.168.1.106
TARGET_USER = yana
TARGET_DIR = /home/yana/


.PHONY: all deploy clean format 

all: mycom 

mycom: mycom.c
	$(CC) $(CFLAGS) -o mycom mycom.c
	
format: 
	clang-format -i mycom.c

install: mycom
	scp mycom mycom.service $(TARGET_USER)@$(TARGET_IP):$(TARGET_DIR)
	ssh $(TARGET_USER)@$(TARGET_IP) "sudo mv $(TARGET_DIR)mycom /usr/local/bin/mycom"
	ssh $(TARGET_USER)@$(TARGET_IP) "sudo mv $(TARGET_DIR)mycom.service /etc/systemd/system/"
	ssh $(TARGET_USER)@$(TARGET_IP) "sudo systemctl daemon-reload"
	ssh $(TARGET_USER)@$(TARGET_IP) "sudo systemctl enable mycom.service"          
	
deploy: mycom
	scp mycom $(TARGET_USER)@$(TARGET_IP):$(TARGET_DIR)
	
clean: 
	rm -f mycom
	
