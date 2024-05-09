compile: compile_input compile_output
	nasm -f elf -g $(file).asm
	ld -m elf_i386 input/*.o output/*.o $(file).o -o $(file)

compile_input:
	nasm -f elf -g input/input_string_repr.asm
	nasm -f elf -g input/convert_to_number.asm
	nasm -f elf -g input/input.asm

compile_output:
	nasm -f elf -g output/convert_to_string.asm
	nasm -f elf -g output/print_string_repr.asm
	nasm -f elf -g output/output.asm

delete:
	rm input/*.o output/*.o *.o $(file)
