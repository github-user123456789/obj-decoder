-- it is bad and i also handle formatting or whatever badly,,
-- i do not recommend that you use it
local OBJ = {}
function OBJ:Decode(file)
	local Data = {}
	Data.v = {}
	Data.f = {}
	Data.o = {}
	Data.g = {}
	Data.mtl = {}
	Data.mtli = {}
	
	Data.vn = {}
	
	local Split = string.split(file, [[

]])
	for i,v in pairs (Split) do
		local Spaced = string.split(v, " ")
		if Spaced[1] == "v" then
			if string.byte(Spaced[2]) == nil then
				Spaced[2] = Spaced[3]; Spaced[3] = Spaced[4]; Spaced[4] = Spaced[5]
			end
			table.insert(Data.v, Vector3.new(Spaced[2], Spaced[3], Spaced[4]))
		end
		if Spaced[1] == "vn" then
			if string.byte(Spaced[2]) == nil then
				Spaced[2] = Spaced[3]; Spaced[3] = Spaced[4]; Spaced[4] = Spaced[5]
			end
			table.insert(Data.vn, Vector3.new(Spaced[2], Spaced[3], Spaced[4]))
		end
		if Spaced[1] == "f" then
			local NewSpaced = {}
			for i = 2,#Spaced do
				table.insert(NewSpaced, Spaced[i])
			end
			local FData = {}
			for i,f in pairs (NewSpaced) do
				local split = string.split(f, "/")
				local n = tonumber(split[1])
				if n then
					n = n % (#Data.v + 1)
					FData[i] = n
				end
			end
			table.insert(Data.f, FData)
		end
		if Spaced[1] == "o" then
			Data.o[#Data.f+1] = Spaced[2]
		end
		if Spaced[1] == "g" then
			Data.g[#Data.g+1] = Spaced[2]
		end
		if Spaced[1] == "usemtl" then -- can be paired with decodemtl for colors.
			Data.mtl[Spaced[2]] = Color3.new(1, 1, 1)
			Data.mtli[#Data.f+1] = Spaced[2]
		end
	end
	
	return Data
end
return OBJ
