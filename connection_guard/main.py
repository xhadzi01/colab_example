#!/usr/bin/env python
#-*- coding:utf-8 -*-

from connection_guard_configuration import GlobalConfiguration as cfg
from urllib.request import urlopen
from urllib.request import HTTPError
from bs4 import BeautifulSoup

def	check_server_connection(server_addr):
	print(f'Checking connection to: "{server_addr}".')
	try:
		html = urlopen(server_addr)
		bsObj = BeautifulSoup(html.read(), 'html.parser')
		print('Ok')
	except HTTPError:
		print(f'Connection to "{server_addr}" could not be established.')
		raise

def	try_to_login():
	pass
	
def	keep_server_alive():
	pass

def main():
	check_server_connection(cfg.server_addr)
	try_to_login()
	keep_server_alive()

if __name__=='__main__':
    main()
