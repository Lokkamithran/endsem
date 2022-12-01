import socket
import select
import sys
import pickle


server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
BUFFER_SIZE = 4096
host = "127.0.0.1"
port = 5218
server.connect((host, port))
array = []

while True:
	order = input ("<> Please input string or Sort: ")
	if order == 'Sort':
		print("Before Sorting:")
		print(array)
		data_arr = pickle.dumps(array)
		server.send(data_arr)
		message = server.recv(BUFFER_SIZE)
		print("After Sorting:")
		sorted_arr = pickle.loads(message)
		print(sorted_arr)
		array.clear()
	else:
		array.append(order)



	# all_sockets = [sys.stdin, server]

	# read_sockets,write_socket, error_socket = select.select(all_sockets,all_sockets,all_sockets)

	# for socks in read_sockets:
	# 	if socks == server:
	# 		message = socks.recv(BUFFER_SIZE)
	# 		print (message.decode("utf-8"))
	# 	else:
	# 		message = sys.stdin.readline()
	# 		server.send(message.encode("utf-8"))
	# 		sys.stdout.write("<You>")
	# 		sys.stdout.write(message)
	# 		sys.stdout.flush()
server.close()
