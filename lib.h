#ifdef _WIN32

#ifdef DYNAMIC_LIB

#ifdef BUILD_DLL
#define EXPORT __declspec(dll_export)
#else
#define EXPORT __declspec(dll_import)
#endif

#else

#define EXPORT

#endif

#else

#define EXPORT

#endif

EXPORT int dummy(void);
