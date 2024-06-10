# STM32F0-Discovery Application Template

This is a template for quick-starting a project for
    [STM32F072B Discovery](https://www.st.com/en/evaluation-tools/32f072bdiscovery.html)
    board with no reliance on any type of IDE or particular toolchain, thus
    allowing you to work the old way, in the command line and your favorite
    editor of choice, which is all particularly usefull when working in linux.
Moreover, by the conduct of not invoking the board-specific libraries, one can
    develop a code for any MCU of the STM32F0 series, irrelevant of the
    hardware context.

The template is equipped with full stack of libraries: the core, the
    peripherals and the board-specific.
Two important sub-libraries of the peripheral library are still missing:
    the USB device library and the USB HID library.
Adding them is a work in progress.

The supplied Makefile is capable if building all of the packaged libraries.
If some of the libraries are not needed, disabling them is a matter of
    commenting out two lines of the Makefile.
The core library is the only library that has to be built in any case.
The Makefile exposes the target 'program' which is a conveninece feature to
    flash the connected board with the currenly build binary.

This template is a fork of a repository by
    [Mike Szczyc](https://github.com/szczys/stm32f0-discovery-basic-template).
It its present state it is a result of many contributions by my students and
    myself.

## Dependencies

The template presumes existence of

* a toolchain for the Cortex M0 target, visible from the environment.
  Names of the individual tools are stored in makefile variables CC, OBJCOPY,
    OBJDUMP and SIZE.
* a functioning installation of openocd
* active udev rules so that your linux can recognize the ST-LINK interface

Strictly speaking, the last two requirements are optional.
If you dont want to flash the board by invoking 'make program', you can skip
    them.

## Subfolders:

1. device/
   * Folder contains device specific files:
   * **startup_stm32f0xx.s** is the startup file taken from the
         STM32F0-Discovery firmware package.
     It is found in the following directory:
      * Libraries/CMSIS/ST/STM32F0xx/Source/Templates/TrueSTUDIO/
   * Linker Scripts (Device/ldscripts)
     These linker scripts are used instead of the stm32_flash.ld script
         which is included in the STM demo code.
     This is because the original file contains an unreasonably restrictive
         copyright assertion.

2. extra/
   * This contains a procedure file used to write the image to the board via
         OpenOCD
   * **Abstracting the extra folder:** the .cfg file in the extra folder may
         be placed anywhere so that multiple projects can use one file.
     Just change the OPENOCD_PROC_FILE variable in the Make file to match the
         new location.

3. inc/
   * All include files for this particular project.

4. libraries/
   * This is the Library/ folder from the STM32F0xx_StdPeriph_Lib_V1.0.0
        standard peripheral driver library produced by STM.
     This preserves the original structure which should make it easy to roll in
        library upgrades as they are published
   * **Makefile** is not part of the STM release, and must be copied over if
        the library is upgraded.
   * **stm32f0xx_conf.h** is used to configure the peripheral library.
        It must be copied here if the library is upgraded.
        The file was file taken from the STM32F0-Discovery firmware package.
        It is found in the following directory:
        * Project/Demonstration/
   * **Abstracting the libraries:** You may place this folder anywhere you
        like in order to use it for multiple projects.
        Just change the path of the STD_PERIPH_LIB variable in the Makefile

5. src/
   * All source files for this particular project (including main.c).
   * **system_stm32f0xx.c** can be generated using an XLS file developed by
        STM.
    This sets up the system clock values for the project.
    The file included in this repository is taken from the STM32F0-Discovery
        firmware package. It is found in the following directory:
      * Libraries/CMSIS/ST/STM32F0xx/Source/Templates/


