CC= $(CROSS_COMPILE)gcc
CFLAGS= -Wextra -Wall


TARGET_IP = 192.168.0.131
TARGET_USER = yana
TARGET_DIR = /home/yana/

.PHONY: all deploy clean

all: mycom 

mycom: mycom.c
	$(CC) $(CFLAGS) -o mycom mycom.c
	
deploy: mycom
	scp mycom $(TARGET_USER)@$(TARGET_IP):$(TARGET_DIR)
	
clean: 
	rm -f mycom
	
