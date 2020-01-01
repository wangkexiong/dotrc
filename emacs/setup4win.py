#!/usr/bin/python
# -*- encoding: utf-8 -*-
#
# https://www.gnu.org/software/emacs/manual/html_node/efaq-w32/Location-of-init-file.html
#
import os
try:
    import _winreg as winreg
except ImportError:
    import winreg


def which(pgm):
    path = os.getenv('PATH')
    for p in path.split(os.path.pathsep):
        p = os.path.join(p, pgm)
        if os.path.exists(p) and os.access(p, os.X_OK):
            return p


def find_emacs(startdir, automated=False):
    if not automated:
        try:
            input = raw_input
        except NameError:
            pass
        parameter = input('Please input path of runemacs.exe: ')
        if os.path.isfile(parameter):
            return parameter
        elif os.path.isfile(parameter + os.sep + 'runemacs.exe'):
            return parameter + os.sep + 'runemacs.exe'
        else:
            return find_emacs(startdir, True)
    else:
        workingdir = startdir
        emacs = 'bin' + os.sep + 'runemacs.exe'
        while True:
            workingfile = workingdir + os.sep + emacs
            if os.path.isfile(workingfile):
                return os.path.realpath(workingfile)
            else:
                os.chdir(workingdir + os.sep + os.path.pardir)
                nextdir = os.getcwd()
                if workingdir == nextdir:
                    break
                else:
                    workingdir = nextdir

        return which('runemacs.exe')


def register(root, key, subkey, value, regtype=winreg.REG_SZ):
    reg = winreg.CreateKeyEx(root, key, 0,
                             winreg.KEY_ALL_ACCESS | winreg.KEY_WOW64_32KEY)
    if subkey == '@':
        winreg.SetValue(reg, None, regtype, value)
    else:
        winreg.SetValueEx(reg, subkey, 0, regtype, value)
    winreg.CloseKey(reg)

    reg = winreg.CreateKeyEx(root, key, 0,
                             winreg.KEY_ALL_ACCESS | winreg.KEY_WOW64_64KEY)
    if subkey == '@':
        winreg.SetValue(reg, None, regtype, value)
    else:
        winreg.SetValueEx(reg, subkey, 0, regtype, value)
    winreg.CloseKey(reg)


if __name__ == "__main__":
    homepath = 'SOFTWARE\\GNU\\Emacs\\'
    homekey = 'HOME'
    installpath = os.path.dirname(os.path.realpath(__file__))

    register(winreg.HKEY_LOCAL_MACHINE, homepath, homekey, installpath)

    editpath = '*\\shell\\openwemacs\\'
    editkey = '@'
    editname = '&Edit with Emacs'
    editcmd = find_emacs(installpath, True)

    if editcmd:
        editvalue = os.path.dirname(editcmd)
        editicon = '"%s%semacsclientw.exe"' % (editvalue, os.sep)
        editvalue = '"%s%semacsclientw.exe" -n -a "%s%srunemacs.exe" "%%1"' % \
            (editvalue, os.sep, editvalue, os.sep)

        register(winreg.HKEY_CLASSES_ROOT, editpath,
                 editkey, editname)
        register(winreg.HKEY_CLASSES_ROOT, editpath,
                 'icon', editicon)
        register(winreg.HKEY_CLASSES_ROOT, editpath + 'command\\',
                 editkey, editvalue)
        print('Emacs HOME set and right click menu created...')
    else:
        print('NO emacs bin found under PATH...')
