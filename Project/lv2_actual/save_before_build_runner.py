#! python2.7
# -*- coding: utf-8 -*-
import pyperclip
import os



def main() :
    pyperclip.hotkey('option', 'command', 's')
    os.system('flutter build_runner build ')


if __name__ == '__main__':
    main()


