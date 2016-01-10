bootfuck: bootfuck.asm print_string.asm  
	./fasm bootfuck.asm bootfuck

run: bootfuck
	xiwi -T qemu-system-x86_64 bootfuck

clean: bootfuck
	rm bootfuck
