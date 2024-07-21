.data
STRING: .string "Hello World!"

.text
la a0, STRING
li a7, 4
ecall
li a7, 10
ecall