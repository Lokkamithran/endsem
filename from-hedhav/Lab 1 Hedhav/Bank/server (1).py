import socket
import sys

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

SERVER_HOST = "0.0.0.0"
SERVER_PORT = 5318
BUFFER_SIZE = 4096
server.bind((SERVER_HOST, SERVER_PORT))
server.listen(21)
conn, addr = server.accept()

balance = 10000

while True:
	try:
		message = conn.recv(BUFFER_SIZE)

		if message:
			# print(message)
			change = int(message.decode("UTF-8"))
			# print(change)
			balance = int(balance) + change
			# print(balance)
			conn.send((str(balance)).encode("UTF-8"))
			# print(balance)

	except:
		continue
 	

conn.close()
server.close()