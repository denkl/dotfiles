c = get_config()

c.InteractiveShellApp.extensions = [
    'autoreload'
]
c.InteractiveShellApp.exec_lines = [
    'import collections',
    'import datetime',
    'import itertools',
    'import os',
    'import pathlib',
    'import random',
    'import sys',
]
c.InteractiveShell.confirm_exit = False
c.InteractiveShell.editor = 'nvim'
c.TerminalIPythonApp.display_banner = False
