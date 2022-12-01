import socket
import select
import sys
from _thread import *
import pickle


server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

SERVER_HOST = "0.0.0.0"
SERVER_PORT = 5218
BUFFER_SIZE = 4096
server.bind((SERVER_HOST, SERVER_PORT))

server.listen(20)
active_clients = []

def clientthread(conn, addr):

	# sends a message to the client whose user object is conn
	# conn.send("Welcome to the sorter :)".encode("utf-8"))

	while True:
		try:
			message = conn.recv(BUFFER_SIZE)

			if message:
				array = pickle.loads(message)
				print("Sorting an array")
				array.sort()
				data_arr = pickle.dumps(array)
				conn.send(data_arr)

		
			else:
				delete_client(conn) # broken conn
		except:
			continue
 


def delete_client(connection):
	if connection in active_clients:
		active_clients.delete_client(connection)

while True:
	conn, addr = server.accept()
	active_clients.append(conn)
	print (addr[0] + " connected")

	start_new_thread(clientthread,(conn,addr))	

conn.close()
server.close()
