local handle = io.popen("uname")
local result = handle:read("*a")
handle:close()
os_name = string.lower(result)

if os_name:match("linux") then
	vim.g.python3_host_prog = "/home/soc/anaconda3/bin/python3"
elseif os_name:match("darwin") then -- Mac OS X uses Darwin
	vim.g.python3_host_prog = "/usr/local/bin/python3"
end
