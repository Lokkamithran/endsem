import socket

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

host = "127.0.0.1"
port = 5555

server.connect((host,port))

# server.listen(20)
# conn,addr = server.accept()

while True:
    reply = server.recv(1024)
    print("Client: ", reply.decode("utf-8"))
    message = input("Enter message: ")
    print("YOU: ", message)
    server.send(message.encode("utf-8"))
    
    