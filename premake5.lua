workspace "Hazel_Clone"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Hazel_Clone"
	location "Hazel_Clone"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/"..outputdir.."/%{prj.name}")
	objdir ("bin-int/"..outputdir.."/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Hazel_Clone/vendor/spdlog/include"
	}

	filter {"system:windows"}
		cppdialect "C++14"
		staticruntime "On"
		systemversion "latest"
		buildoptions {"/utf-8"}


		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/SandBox")
		}
	
	filter {"configurations:Debug"}
		defines "HZ_DEBUG"
		symbols "On"
	
	filter {"configurations:Release"}
		defines "HZ_RELEASE"
		optimize "On"

	filter {"configurations:Dist"}
		defines "HZ_DIST"
		optimize "On"





project "SandBox"
	location "SandBox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/"..outputdir.."/%{prj.name}")
	objdir ("bin-int/"..outputdir.."/%{prj.name}")

	files 
	{ 
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp" 
	}

	includedirs
	{
		"Hazel_Clone/vendor/spdlog/include",
		"Hazel_Clone/src"
	}

	links 
	{ 
		"Hazel_Clone" 
	}

	filter {"system:windows"}
		cppdialect "C++14"
		staticruntime "On"
		systemversion "latest"
		buildoptions { "/utf-8" }


		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}
	
	filter {"configurations:Debug"}
		defines "HZ_DEBUG"
		symbols "On"

	filter { "configurations:Release" }
		defines "HZ_RELEASE"
		symbols "On"
	
	filter { "configurations:Dist" }
		defines "HZ_DIST"
		optimize "On"
