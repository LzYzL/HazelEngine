#pragma once


#ifdef HZ_PLATFORM_WINDOWS

extern Hazel::Application* Hazel::CreateApplication();

int main(int argc,char** argv)
{
	//printf("Hazel Engine\n");
	Hazel::Log::init();
	HZ_CORE_WARN("Initialized log");
	int a = 5,b=2;
	HZ_INFO("Hello, var={1}",a,b);

	auto app = Hazel::CreateApplication();
	app->run();
	delete app;
	return 0;
}

#endif