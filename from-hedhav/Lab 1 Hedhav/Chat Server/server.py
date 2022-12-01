import socket
import select
import sys
from _thread import *

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

SERVER_HOST = "0.0.0.0"
SERVER_PORT = 5119
BUFFER_SIZE = 4096
server.bind((SERVER_HOST, SERVER_PORT))

server.listen(20)
active_clients = []

def clientthread(conn, addr):

	# sends a message to the client whose user object is conn
	conn.send("Welcome weary traveller :)".encode("utf-8"))

	while True:
		try:
			message = conn.recv(BUFFER_SIZE)
			if message:
				# print("msg received")
				print ("<Client>" + message.decode("utf-8"))
				message_to_send = "<Client> " + message.decode("utf-8")
				send_message(message_to_send.encode("utf-8"), conn)

			else:
				delete_client(conn) # broken conn
		except:
			continue


def send_message(message, connection):
	for client in active_clients:
		if client!=connection:
			try:
				client.send(message)
			except:
				client.close()
				delete_client(client)   


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
