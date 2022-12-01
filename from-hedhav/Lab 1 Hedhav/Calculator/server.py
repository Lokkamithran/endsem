import operator
import socket
import sys

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

SERVER_HOST = "0.0.0.0"
SERVER_PORT = 5418
BUFFER_SIZE = 4096
server.bind((SERVER_HOST, SERVER_PORT))


conn, addr = server.accept()

DIGITS = set('0123456789')
OPERATIONS = {
	'+' : operator.add,
	'-' : operator.sub,
	'*' : operator.mul,
	'/' : operator.floordiv,
	'^' : operator.pow,
}


def is_digit(var):
	return var in DIGITS

def get_number(varstr):
	s = ""
	if varstr[0] == '-':
		s += "-"
		varstr = varstr[1:]
	for c in varstr:
		if not is_digit(c):
			break
		s += c
	return (int(s), len(s))

def perform_operation(string, num1, num2):
	op = OPERATIONS.get(string, None)
	if op is not None:
		return op(num1, num2)
	else:
		return None  # How to handle this?

def eval_math_expr(expr):
	while True:
		try: 
			number1, end_number1 = get_number(expr)
			expr = expr[end_number1:]
			if expr == '':
				return number1
			op = expr[0]
			expr = expr[1:]
			number2, end_number2 = get_number(expr)
			number1 = perform_operation(op, number1, number2)
			expr = str(number1) + expr[end_number2:]
		except Exception as e:
			print(e)
			break
	return number1






while True:
	try:
		message = conn.recv(BUFFER_SIZE)

		if message:
			result = eval_math_expr(message.decode("UTF-8"))
			print(result)
			conn.send(result.encode("UTF-8"))


		else:
			delete_client(conn) # broken conn
	except:
		continue
 



conn.close()
server.close()
