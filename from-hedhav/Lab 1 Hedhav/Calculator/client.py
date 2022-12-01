import socket
import sys



server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
BUFFER_SIZE = 4096
host = "127.0.0.1"
port = 5418
server.connect((host, port))



while True:
	order = input ("Enter expression: ")
    server.send(order.encode("UTF-8"))
    message = server.recv(BUFFER_SIZE)
    print ("Result " + message.decode("UTF-8"))
	# else:
	# 	print ("invalid order")

server.close()
