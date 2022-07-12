#!/usr/bin/env python3
import os
import sys

imgcat = os.path.expanduser('~/.bash.rc.d/imgcat')
deflogo = os.path.expanduser('~/.bash.rc.d/logo.png')

if os.getenv('COLUMNS'):
	WIDTH=int(os.getenv('COLUMNS'))-2
else:
	WIDTH=65
sysinf = {
	'user': os.popen('whoami').read()[:-1].strip(),
	'host': os.popen('hostname').read()[:-1].strip(),
	'ipaddr': os.getenv('HOST_ADDRESS')
}
if os.getenv('MACOS_PRODUCT'):
	sysinf["product"] = os.getenv('MACOS_PRODUCT')[:20]
	sysinf["version"] = os.getenv('MACOS_VERSION')[:20]
	logo = os.path.expanduser('~/.bash.rc.d/apple.png')
elif os.path.exists('/etc/lsb-release'):
	with open('/etc/lsb-release') as f:
		lsb = dict(line.strip().split('=') for line in f)
	sysinf["product"] = lsb["DISTRIB_DESCRIPTION"]
	sysinf["version"] = lsb["DISTRIB_RELEASE"]
	logo = os.path.expanduser('~/.bash.rc.d/tux.png')
else:
	sysinf["product"] = os.uname().sysname
	sysinf["version"] = os.uname().release
	logo = ""
line=1

def out(s):
	sys.stdout.write(s[:WIDTH])

def aprint(s):
	global line
	print(f'\033[{line};10H{s}')
	line = line + 1

def ansicolor(fore,back="black",attr=None):
	colors = {
		"black": 	'0',
		"red": 		'1',
		"green": 	'2',
		"yellow":	'3',
		"blue":		'4',
		"purple": 	'5',
		"cyan": 	'6',
		"white": 	'7'
	}
	attrs = {
		"norm": 	'0;',
		"bold": 	'1;',
		"faint": 	'2;',
		"under": 	'4;',
		"blnk": 	'5;'
	}
	if fore == "reset":
		out("\033[0m")
		return
	if attr:
		attr=attrs[attr]
	else:
		attr=''

	out(f'\033[{attr}3{colors[fore]};4{colors[back]}m')

#out(f'\033[2J\033[1;1H')
if os.path.exists(imgcat):
	if os.path.exists(deflogo):
		os.system(f'{imgcat} {deflogo}')
	elif os.path.exists(logo):
		os.system(f'{imgcat} {logo}')
ansicolor("yellow", "blue", "bold")
aprint("—"*WIDTH)
ansicolor("white", "blue", "bold")
aprint(f'Welcome, {sysinf["user"]}, to {sysinf["product"]} ({sysinf["version"]})'.center(WIDTH))
if(sysinf["ipaddr"]):
	aprint(f'{sysinf["host"]}@{sysinf["ipaddr"]}'.center(WIDTH))
else:
	aprint(f'{sysinf["host"]}'.center(WIDTH))
ansicolor("yellow", "blue", "bold")
aprint("—"*WIDTH)
aprint('\n')
ansicolor("green","black","bold")
aprint(os.popen('uptime').read()[:-1])
ansicolor("reset")
print('')
