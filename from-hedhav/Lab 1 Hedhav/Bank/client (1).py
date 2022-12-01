import socket
import sys

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
BUFFER_SIZE = 4096
host = "127.0.0.1"
port = 5318
client.connect((host, port))
balance = 10000

print("Initial balance = " + str(balance))
while True:
	order = input ("Please input wd (withdraw) or dp (deposit): ")
	if order == 'wd':
		amount = input ("Please input amount of withdrawal:   ")
		client.send(("-" + amount).encode("UTF-8"))
		message = client.recv(BUFFER_SIZE)
		print ("New Account Balance: " + message.decode("UTF-8"))
	elif order == 'dp':
		amount = input ("<><> Please input amount of deposit:   ")
		client.send(("+" + amount).encode("UTF-8"))
		message = client.recv(BUFFER_SIZE)
		print ("New Account Balance: " + message.decode("UTF-8"))
	else:
		print ("invalid order")

client.close()