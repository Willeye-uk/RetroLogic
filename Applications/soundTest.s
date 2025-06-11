; ******************************************************************************
; SN76489 Test Tune for 6502 Processor
;
; This program generates a simple test tune using the SN76489 Programmable
; Sound Generator (PSG) chip.
;
; Sound Chip I/O Address: $A003
;
; Assumptions:
; - SN76489 is connected to the 6502 data bus and responds to writes at $A003.
; - The SN76489 is clocked at approximately 3.579545 MHz (NTSC standard).
;   This clock frequency is used for frequency calculations.
; - A standard 6502 system capable of running machine code.
;
; How the SN76489 works (Simplified):
; The SN76489 has 3 tone channels and 1 noise channel, each with independent
; frequency/type and volume controls.
;
; Data is written to a single I/O address. The meaning of the byte written
; depends on its most significant bits:
; - Latch/Register Select:
;   - %1000xxxx: Tone Channel 0 Frequency Latch (xxxx are low 4 bits of freq)
;   - %1001xxxx: Tone Channel 1 Frequency Latch (xxxx are low 4 bits of freq)
;   - %1010xxxx: Tone Channel 2 Frequency Latch (xxxx are low 4 bits of freq)
;   - %1001xxxx: Tone Channel 0 Volume Latch (xxxx is 4-bit volume, 0=loud, 15=silent)
;   - %1011xxxx: Tone Channel 1 Volume Latch
;   - %1100xxxx: Tone Channel 2 Volume Latch
;   - %1110xxx0: Noise Channel Latch (xxx0 is type/shift rate, 000=periodic, 001=white, etc.)
;   - %1111xxxx: Noise Channel Volume Latch
;
; - Data Byte:
;   - %00xxxxxx: High 6 bits of Tone Frequency (written after a Tone Freq Latch)
;
; Frequency Calculation:
; N = Clock_Frequency / (32 * Desired_Note_Frequency)
; For a 3.579545 MHz clock: N = 3579545 / (32 * Frequency_Hz)
; N is a 10-bit value.
;
; Volume: 0 (loudest) to 15 (silent).
;
; ******************************************************************************

.ORG $C000  ; Program start address. Adjust as needed for your system's memory map.

; --- Constants ---
SOUND_CHIP_IO = $A003 ; Address of the SN76489 sound chip

; --- Subroutines ---

; DELAY
; Provides a simple delay loop.
; Uses X and Y registers, so preserve them if needed.
DELAY:
    LDX #$04        ; Outer loop counter (adjust for longer/shorter delays)
DELAY_LOOP_OUTER:
    LDY #$FF        ; Inner loop counter
DELAY_LOOP_INNER:
    DEY             ; Decrement Y
    BNE DELAY_LOOP_INNER ; Loop until Y is zero
    DEX             ; Decrement X
    BNE DELAY_LOOP_OUTER ; Loop until X is zero
    RTS             ; Return from subroutine

; WRITE_SN76489
; Writes the byte in the A register to the SN76489 I/O address.
WRITE_SN76489:
    STA SOUND_CHIP_IO ; Store A register content to the sound chip's I/O address
    RTS               ; Return from subroutine

; --- Main Program ---

START:
    ; --- Initialization: Silence all channels ---
    ; This ensures no previous sounds are playing and sets a known state.

    ; Set Channel 0 Volume to 15 (silent)
    LDA #%10011111  ; Latch Tone Channel 0 Volume, value 15 (silent)
    JSR WRITE_SN76489

    ; Set Channel 1 Volume to 15 (silent)
    LDA #%10111111  ; Latch Tone Channel 1 Volume, value 15 (silent)
    JSR WRITE_SN76489

    ; Set Channel 2 Volume to 15 (silent)
    LDA #%11001111  ; Latch Tone Channel 2 Volume, value 15 (silent)
    JSR WRITE_SN76489

    ; Set Noise Channel Volume to 15 (silent)
    LDA #%11111111  ; Latch Noise Channel Volume, value 15 (silent)
    JSR WRITE_SN76489

    JSR DELAY       ; Short pause for initialization

    ; --- Play Ascending Notes on Channel 0 ---
    ; Each note consists of setting its frequency (low 4 bits, then high 6 bits)
    ; and then setting its volume (or leaving it from previous).
    ; We'll set volume to 0 (loudest) for the notes.

    ; Note 1: C4 (Frequency N = 428)
    ; N = $01AC (Binary: 0001 1010 1100)
    ; Low 4 bits: %1100 (C)
    ; High 6 bits: %011010 (2A)
    LDA #%10001100   ; Latch Ch 0 Freq, low 4 bits of N (1100 = 12)
    JSR WRITE_SN76489
    LDA #%00011010   ; Data Ch 0 Freq, high 6 bits of N (011010 = 26)
    JSR WRITE_SN76489
    LDA #%10010000   ; Latch Ch 0 Volume, value 0 (loudest)
    JSR WRITE_SN76489
    JSR DELAY        ; Play note for a duration

    ; Note 2: E4 (Frequency N = 339)
    ; N = $0153 (Binary: 0001 0101 0011)
    ; Low 4 bits: %0011 (3)
    ; High 6 bits: %010101 (21)
    LDA #%10000011   ; Latch Ch 0 Freq, low 4 bits of N (0011 = 3)
    JSR WRITE_SN76489
    LDA #%00010101   ; Data Ch 0 Freq, high 6 bits of N (010101 = 21)
    JSR WRITE_SN76489
    JSR DELAY        ; Play note for a duration

    ; Note 3: G4 (Frequency N = 285)
    ; N = $011D (Binary: 0001 0001 1101)
    ; Low 4 bits: %1101 (D)
    ; High 6 bits: %010001 (19)
    LDA #%10001101   ; Latch Ch 0 Freq, low 4 bits of N (1101 = 13)
    JSR WRITE_SN76489
    LDA #%00010001   ; Data Ch 0 Freq, high 6 bits of N (010001 = 17)
    JSR WRITE_SN76489
    JSR DELAY        ; Play note for a duration

    ; Note 4: C5 (Frequency N = 214)
    ; N = $00D6 (Binary: 0000 1101 0110)
    ; Low 4 bits: %0110 (6)
    ; High 6 bits: %001101 (13)
    LDA #%10000110   ; Latch Ch 0 Freq, low 4 bits of N (0110 = 6)
    JSR WRITE_SN76489
    LDA #%00001101   ; Data Ch 0 Freq, high 6 bits of N (001101 = 13)
    JSR WRITE_SN76489
    JSR DELAY        ; Play note for a duration

    ; --- Silence Tone Channel ---
    LDA #%10011111   ; Latch Ch 0 Volume, value 15 (silent)
    JSR WRITE_SN76489
    JSR DELAY        ; Short pause

    ; --- Play Noise Burst ---
    ; Type 00 (Periodic Noise), Shift Rate 0 (Fastest)
    LDA #%11100000   ; Latch Noise Register, Type 00 (Periodic), Shift Rate 0
    JSR WRITE_SN76489
    LDA #%11110101   ; Latch Noise Volume, value 5 (moderately loud)
    JSR WRITE_SN76489
    JSR DELAY        ; Play noise for a duration
    JSR DELAY        ; Extend noise duration slightly

    ; --- Silence Noise Channel ---
    LDA #%11111111   ; Latch Noise Volume, value 15 (silent)
    JSR WRITE_SN76489
    JSR DELAY        ; Short pause

    ; --- End of Program ---
    BRK              ; Break instruction (halts the CPU in emulators/debuggers)
                     ; For a real system, you might jump to a monitor,
                     ; or JMP START to loop the tune indefinitely.
