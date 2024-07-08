#ifdef _WIN32

#ifdef DYNAMIC_LIB

#ifdef BUILD_DLL
#define EXPORT __declspec(dllexport)
#else
#define EXPORT __declspec(dllimport)
#endif

#else

#define EXPORT

#endif

#else

#define EXPORT

#endif

EXPORT int dummy(void);
