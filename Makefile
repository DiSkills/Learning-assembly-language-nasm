compile_input:
	nasm -f elf -g std/input/input_string_repr.asm
	nasm -f elf -g std/input/convert_to_number.asm
	nasm -f elf -g std/input/input.asm
	nasm -f elf -g std/input/input_array.asm

compile_output:
	nasm -f elf -g std/output/convert_to_string.asm
	nasm -f elf -g std/output/print_string_repr.asm
	nasm -f elf -g std/output/output.asm
	nasm -f elf -g std/output/output_array.asm

compile_std: compile_input compile_output

delete_std:
	rm std/*.o std/input/*.o std/output/*.o

compile:
	nasm -f elf -g $(file).asm
	ld -m elf_i386 std/input/*.o std/output/*.o std/*.o $(file).o -o $(file)

delete:
	rm $(file).o $(file)

run_bash:
	./$(file).sh $(file)

run_test: compile run_bash delete

test: compile_std run_test delete_std
