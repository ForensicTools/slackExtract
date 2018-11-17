#!/usr/bin/python3
"""
slackExtract - A forensics tool to extract data from slack space
Contributors: Brett Fitzpatrick, Michael Leardi
Filename: slackExtract.py
Purpose: Extracts data from slack space
"""

# libs


######## START FUNCTIONS ########

def readSlackSpace(file, inode):
	# TODO

def is_valid_file(file):
	# Checking if file exitst
	try:
		os.stat(file)
	except FileNotFoundError as e:
		print("Error 0: File appears to not exist.")
		exit()

def main(args):
	# TODO
	is_valid_file(args.file)


if __name__=="__main__":
	__parser__ = argparse.ArgumentParser(
		description='Extracts slack from files'
	)
	__parser__.add_argument(
	'-f', '--file', default=None, required=True, help='Input file name'
	)
	__args__ = __parser__.parse_args()
	main(__args__)
