#pragma once
#include "Core.h"
#include "Events/Event.h"
#include "Hazel/LayerStack.h"
#include "Hazel/Events/ApplicationEvent.h"
#include "Window.h"

namespace Hazel
{
	class HZ_API Application
	{
	public:
		Application();
		virtual ~Application(); 

		void run();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);

		inline static Application& Get() { return *s_Instance; }
		inline Window& GetWindow() { return *m_Window; }
	private:
		bool OnWindowClose(WindowCloseEvent& e);

		std::unique_ptr<Window> m_Window;
		bool m_Running = true;
		LayerStack m_LayerStack;
	private:
		static Application* s_Instance;
	};

	// to be define in CLIENT
	Application* CreateApplication();
}