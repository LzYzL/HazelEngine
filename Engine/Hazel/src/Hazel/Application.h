#pragma once
#include "Core.h"
#include "Events/Event.h"
#include "Window.h"

namespace Hazel
{
	class HZ_API Application
	{
	public:
		Application();
		virtual ~Application(); 

		void run();
	private:
		std::unique_ptr<Window> m_Window;
		bool m_Running = true;
	};

	// to be define in CLIENT
	Application* CreateApplication();
}