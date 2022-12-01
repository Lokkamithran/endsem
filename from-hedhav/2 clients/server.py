import socket
from _thread import *

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

host = "0.0.0.0"
port = 5555

server.bind((host,port))

server.listen(20)
active_clients = []

def client_thread(conn, addr):
    while True:
        message = conn.recv(1024)
        if message:
            for client in active_clients:
                if client != conn:
                    client.send(message)
        else:
            active_clients.remove(conn)
            break

while True:
    conn,addr = server.accept()
    active_clients.append(conn)
    start_new_thread(client_thread,(conn,addr))
    # message = conn.recv(1024)
    # print(message.decode("utf-8"))