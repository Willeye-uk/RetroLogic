# **6502 SBC - KiCad 8 Files ([Ben Eater](https://eater.net/6502) Inspired)**


---

Welcome to the repository for the **KiCad 8 design files** of a single board computer (SBC) based on the classic **W65C02S microprocessor**. This project draws heavy inspiration from [Ben Eater's excellent 6502 computer series](https://eater.net/6502), expanding upon it with a range of features for greater versatility and modern connectivity.


## **Features**

This SBC design aims to provide a robust platform for learning and experimenting with the 6502. Key features include:



* **W65C02S Processor:** Capable of running up to **14 MHz**.
* **Memory:**
    * **62256 SRAM:** For fast read/write memory operations.
    * **28C256 EEPROM:** For storing your programs and firmware.
* **Input/Output:**
    * **65C22 Versatile Interface Adapter (VIA):** Provides programmable parallel I/O, timers, and shift registers.
    * **65C51 Asynchronous Communications Interface Adapter (ACIA):** For serial communication capabilities.
* **Connectivity:**
    * **DB9 Serial Port:** Standard serial connector for PC communication (via MAX232 level shifter).
    * **FTDI Breakout Serial Socket:** Convenient header for connecting an FTDI serial-to-USB adapter.
    * **SD Card Socket:** For mass storage, enabling easier program loading and data logging.
    * **LCD Screen Connector:** Directly interface with character LCDs.
* **Power & Expansion:**
    * **USB-B Power Socket:** Modern and widely available power input.
    * **Power Switch:** For easy power control.
    * **Crystal Socket:** Flexible clocking options, allowing for different crystal frequencies.
    * **Switchable Voltage for Add-ons:** Provides configurable power for external modules and expansion boards.

![3D Image]([https://raw.githubusercontent.com/Willeye-uk/6502SBC/refs/heads/main/png/3d.png))

## **Getting Started**

To explore or modify this design, you'll need **KiCad 8**.

**Clone this repository: \
** Bash \
git clone https://github.com/your-username/your-repo-name.git



1. 
2. **Open the project in KiCad 8:** Navigate to the cloned directory and open the `.kicad_pro` file.

From there, you can view the schematics, examine the PCB layout, and generate manufacturing files if you wish to build your own board.


## **Contributing**

Contributions are welcome! If you find issues, have suggestions for improvements, or want to add features, feel free to open an issue or submit a pull request.


## **License**

This project is open-source. Please refer to the `LICENSE` file (if present) for details.
