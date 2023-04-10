; Assemble with Microsoft Macro Assembler (MASM)
; Link with Wininet library (e.g. with /DEFAULTLIB:wininet.lib)

.386
.model flat, stdcall
option casemap :none

include windows.inc
include wininet.inc
include kernel32.inc
include user32.inc

includelib kernel32.lib
includelib user32.lib

.data
  userAgent db "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101 Firefox/90.0", 0
  apiEndpoint db "https://endpoint.spamtec.cc/v1/tool?key=key&", 0
  bufferSize equ 4096
  input db bufferSize dup(?)
  response db bufferSize dup(?)

.code
start:
  ; Get user input
  invoke StdOut, addr prompt
  invoke StdIn, addr input, bufferSize
  ; Remove newline character at end of input
  mov ebx, offset input
  add ebx, eax ; eax contains number of characters read
  dec ebx ; move back one byte
  mov byte ptr [ebx], 0 ; overwrite newline with null terminator

  ; Initialize Wininet API
  invoke InternetOpenA, addr userAgent, INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0
  mov esi, eax ; store handle to Internet session
  cmp esi, NULL
  je error

  ; Build API URL
  invoke lstrlenA, addr apiEndpoint
  mov edx, eax ; store length of endpoint
  mov ebx, offset input
  add ebx, eax ; move pointer to end of input
  mov byte ptr [ebx], '?' ; add question mark
  inc ebx ; move pointer to after question mark
  mov ecx, edx ; store length of endpoint
  mov esi, offset apiEndpoint ; point to start of endpoint
buildUrlLoop:
  lodsb ; load byte from endpoint
  cmp al, 0
  je sendRequest ; end of endpoint
  cmp al, '&'
  je addInputParam ; add input parameter
  mov byte ptr [ebx], al ; copy byte to URL buffer
  inc ebx ; increment pointer
  dec ecx ; decrement length
  jmp buildUrlLoop
addInputParam:
  mov byte ptr [ebx], '=' ; add equals sign
  inc ebx ; increment pointer
  mov ecx, bufferSize ; set maximum length of input parameter
  mov esi, offset input ; point to start of input buffer
copyInputParam:
  lodsb ; load byte from input
  cmp al, 0
  je buildUrlLoop ; end of input parameter
  mov byte ptr [ebx], al ; copy byte to URL buffer
  inc ebx ; increment pointer
  dec ecx ; decrement length
  jmp copyInputParam
sendRequest:
  mov byte ptr [ebx], 0 ; add null terminator to URL
  invoke InternetOpenUrlA, esi, offset input, NULL, 0, INTERNET_FLAG_RELOAD, NULL
  mov edi, eax ; store handle to Internet request
  cmp edi, NULL
  je error

  ; Receive response
  mov ebx, offset response
  mov ecx, bufferSize
receiveLoop:
  invoke InternetReadFile, edi, ebx, ecx, addr edx
  cmp eax, 0
  je receiveError
  add ebx, eax ; increment pointer
  sub ecx, eax ; decrement length
  cmp ecx, 0
  je responseTooLarge
  jmp receiveLoop
receiveError:
  invoke StdOut, addr receiveErrorPrompt
  jmp cleanup
responseTooLarge:
  invoke StdOut, addr responseTooLargePrompt
  jmp cleanup

cleanup:
  ; Clean up Wininet resources
  cmp edi, NULL
  je skipCloseRequest
  invoke InternetCloseHandle, edi
skipCloseRequest:
  cmp esi, NULL
  je skipCloseSession
  invoke InternetCloseHandle, esi
skipCloseSession:
  invoke ExitProcess, 0

error:
  invoke StdOut, addr requestFailedPrompt
  jmp cleanup

prompt db "Enter your input: ", 0
requestFailedPrompt db "Request failed.", 0
receiveErrorPrompt db "Error receiving response.", 0
responseTooLargePrompt db "Response too large for buffer.", 0

end start
