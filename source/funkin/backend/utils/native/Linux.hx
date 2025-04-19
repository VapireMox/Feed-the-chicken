package funkin.backend.utils.native;

#if linux
@:cppFileCode("#include <stdio.h>")
@:cppFileCode("
	#include <string>
	#include <fstream>
	#include <cstdio>
")
class Linux {
	@:functionCode('
		FILE *meminfo = fopen("/proc/meminfo", "r");

		if(meminfo == NULL)
			return -1;

		char line[256];
		while(fgets(line, sizeof(line), meminfo))
		{
			int ram;
			if(sscanf(line, "MemTotal: %d kB", &ram) == 1)
			{
				fclose(meminfo);
				return (ram / 1024);
			}
		}

		fclose(meminfo);
		return -1;
	')
	public static function getTotalRam():Float
	{
		return 0;
	}
	
	@:functionCode('
		FILE *meminfo = fopen("/proc/meminfo", "r");
		std::string line;
		
		long freeMem = 0, buffers = 0, cached = 0;
		
		while (std::getline(meminfo, line)) {
			if (line.find("MemFree:") != std::string::npos) {
				sscanf(line.c_str(), "MemFree: %ld kB", &freeMem);
			} else if (line.find("Buffers:") != std::string::npos) {
				sscanf(line.c_str(), "Buffers: %ld kB", &buffers);
			} else if (line.find("Cached:") != std::string::npos) {
				sscanf(line.c_str(), "Cached: %ld kB", &cached);
			}
		}
	
		return (freeMem + buffers + cached) / 1024;
	')
	public static function getAvailableRam():Float {
		return 0;
	}
}
#end