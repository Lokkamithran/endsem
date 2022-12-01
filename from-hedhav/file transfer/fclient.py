import socket
# inport sys

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

host = "127.0.0.1"
port = 5557

server.connect((host,port))

# server.listen(20)
# conn,addr = server.accept()

while True:
    filename = input("Enter filename: ")
    server.send(filename.encode("utf-8"))
    with open(filename, "wb") as f:
        chunk =  server.recv(4096)
        while (chunk):
            f.write(chunk)
            chunk = server.recv(4096)
    server.close()
