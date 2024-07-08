#ifndef FG_EXPORT_H
#define FG_EXPORT_H

#ifdef FG_DLL

#ifdef FG_BUILD_DLL
#define FG_EXPORT __declspec(dllexport)
#else
#define FG_EXPORT __declspec(dllimport)
#endif

#else

#define FG_EXPORT

#endif

#endif // FG_EXPORT_H
