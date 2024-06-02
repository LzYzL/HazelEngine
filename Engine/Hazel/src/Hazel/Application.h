#pragma once
#include "Core.h"

namespace Hazel
{
	class HZ_API Application
	{
	public:
		Application();
		virtual ~Application(); 

		void run();
	};

	// to be define in CLIENT
	Application* CreateApplication();
}