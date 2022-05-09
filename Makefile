CROSS_COMPLE ?= arm-linux-gnueabihf-
NAME         ?= ledc

CC           :=$(CROSS_COMPLE)gcc
LD           :=$(CROSS_COMPLE)ld 
OBJCOPY      :=$(CROSS_COMPLE)objcopy
OBJDUMP      :=$(CROSS_COMPLE)objdump 

OBJS := start.o main.o 

$(NAME).bin : $(OBJS)
	$(LD) -Timx6ul.lds -o $(NAME).elf $^
	$(OBJCOPY) -O binary -S $(NAME).elf $@
	$(OBJDUMP) -D -m arm $(NAME).elf >$(NAME).dis
 
%.o:%.S
	$(CC) -Wall -nostdlib -c -O2 -o $@ $<
%.o:%.c
	$(CC) -Wall -nostdlib -c -O2 -o $@ $<


clean:
	rm -rf *.o $(NAME).elf $(NAME).bin $(NAME).dis