-- World's lamest Lua script.

io.write("This is a sample script for the filter engine:\n");
x = 0
for i = 1, #foo do
	print(i, foo[i])
	x += foo[i]
end
io.write("Returning back to C\n");
return x
