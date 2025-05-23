#pragma once
#include "Core.h"
#include <iostream>

namespace Hazel 
{
	class HAZEL_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();
	};

	// To be defined in Client
	Application* CreateApplication();

}

