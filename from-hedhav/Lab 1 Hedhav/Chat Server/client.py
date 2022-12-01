import socket
import select
import sys

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
BUFFER_SIZE = 4096
host = "127.0.0.1"
port = 5119
server.connect((host, port))

while True:
	all_sockets = [sys.stdin, server]

	read_sockets,write_socket, error_socket = select.select(all_sockets,all_sockets,all_sockets)

	for socks in read_sockets:
		if socks == server:
			message = socks.recv(BUFFER_SIZE)
			print (message.decode("utf-8"))
		else:
			message = sys.stdin.readline()
			server.send(message.encode("utf-8"))
			sys.stdout.write("<You>")
			sys.stdout.write(message)
			sys.stdout.flush()
server.close()
