.model small
.stack 100h

.data
    menu_msg      db 13,10,'Disk Calculator Menu:',13,10
                  db '1. Addition',13,10
                  db '2. Subtraction',13,10
                  db '3. Multiplication',13,10
                  db '4. Division',13,10
                  db '5. Exit',13,10
                  db 'Enter your choice (1-5): $'

    num1_msg      db 13,10,'Enter first number (00-99): $'
    num2_msg      db 13,10,'Enter second number (00-99): $'
    result_msg    db 13,10,'Result: $'
    error_msg     db 13,10,'Invalid input! Please try again.$'
    overflow_msg  db 13,10,'Error: Result too large!$'
    div_zero_msg  db 13,10,'Error: Cannot divide by zero!$'
    exit_msg      db 13,10,'Thank you for using Disk Calculator!$'

    num1          db ?
    num2          db ?
    result        dw ?
    choice        db ?
    negative_flag db 0
    quotient      db ?
    remainder     db ?

.code
main proc
    mov ax, @data
    mov ds, ax

menu:
    mov negative_flag, 0
    mov ah, 09h
    lea dx, menu_msg
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov choice, al

    cmp al, 5
    je exit_program
    cmp al, 1
    jb invalid_choice
    cmp al, 4
    ja invalid_choice

    call get_number
    mov num1, al

    call get_number
    mov num2, al

    cmp choice, 1
    je addition
    cmp choice, 2
    je subtraction
    cmp choice, 3
    je multiplication
    cmp choice, 4
    je division

addition:
    mov al, num1
    add al, num2
    jc addition_overflow
    mov ah, 0
    mov result, ax
    jmp show_result

addition_overflow:
    mov ah, 09h
    lea dx, overflow_msg
    int 21h
    jmp menu

subtraction:
    mov al, num1
    sub al, num2
    jc subtraction_negative
    mov ah, 0
    mov result, ax
    jmp show_result

subtraction_negative:
    neg al
    mov negative_flag, 1
    mov ah, 0
    mov result, ax
    jmp show_result

multiplication:
    mov al, num1
    mov bl, num2
    mul bl
    cmp ah, 0
    jne multiplication_overflow
    mov result, ax
    jmp show_result

multiplication_overflow:
    mov ah, 09h
    lea dx, overflow_msg
    int 21h
    jmp menu

division:
    cmp num2, 0
    je division_zero_error
    mov al, num1
    mov ah, 0
    div num2
    mov quotient, al
    mov remainder, ah
    jmp show_division_result

division_zero_error:
    mov ah, 09h
    lea dx, div_zero_msg
    int 21h
    jmp menu

invalid_choice:
    mov ah, 09h
    lea dx, error_msg
    int 21h
    jmp menu

show_result:
    mov ah, 09h
    lea dx, result_msg
    int 21h

    cmp negative_flag, 1
    jne no_negative
    mov ah, 02h
    mov dl, '-'
    int 21h

no_negative:
    mov ax, result
    call display_number
    jmp menu

show_division_result:
    mov ah, 09h
    lea dx, result_msg
    int 21h

    mov al, quotient
    call display_number

    cmp remainder, 0
    je menu

    mov ah, 02h
    mov dl, ' '
    int 21h
    mov dl, 'R'
    int 21h
    mov dl, '='
    int 21h
    mov al, remainder
    call display_number
    jmp menu

exit_program:
    mov ah, 09h
    lea dx, exit_msg
    int 21h

    mov ah, 4ch
    int 21h
main endp

get_number proc
    push bx
    push cx
    push dx

input_loop:
    mov ah, 09h
    lea dx, num1_msg
    int 21h

    mov ah, 01h
    int 21h
    cmp al, '0'
    jb invalid_input
    cmp al, '9'
    ja invalid_input
    sub al, '0'
    mov bl, 10
    mul bl
    mov bh, al

    mov ah, 01h
    int 21h
    cmp al, '0'
    jb invalid_input
    cmp al, '9'
    ja invalid_input
    sub al, '0'
    add al, bh

    pop dx
    pop cx
    pop bx
    ret

invalid_input:
    mov ah, 09h
    lea dx, error_msg
    int 21h
    jmp input_loop
get_number endp

display_number proc
    push ax
    push bx
    push dx

    mov bl, al
    cmp bl, 10
    jb single_digit

    mov al, bl
    mov ah, 0
    mov bl, 10
    div bl

    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h

    mov dl, ah
    add dl, '0'
    int 21h
    jmp done_display

single_digit:
    mov dl, bl
    add dl, '0'
    mov ah, 02h
    int 21h

done_display:
    pop dx
    pop bx
    pop ax
    ret
display_number endp

end main
