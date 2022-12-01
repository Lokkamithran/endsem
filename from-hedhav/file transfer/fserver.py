import socket
from _thread import *

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

host = "0.0.0.0"
port = 5557

server.bind((host,port))

server.listen(20)
active_clients = []

def client_thread(conn, addr):
    while True:
        filename = conn.recv(1024)
        if filename:
            # bytes_read = 0
            with open(filename, "rb") as f:
                while True:
                    chunk = f.read(1024)
                    conn.send(chunk)
                    # bytes_read += 1024
        else:
            active_clients.remove(conn)
            break

while True:
    conn,addr = server.accept()
    active_clients.append(conn)
    start_new_thread(client_thread,(conn,addr))
    # message = conn.recv(1024)
    # print(message.decode("utf-8"))
    