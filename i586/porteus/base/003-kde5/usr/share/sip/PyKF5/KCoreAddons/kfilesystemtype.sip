namespace KFileSystemType
{
%TypeHeaderCode
#include <kfilesystemtype.h>
%End
    enum Type {
        Unknown,
        Nfs,
        Smb,
        Fat,
        Ramfs,
        Other
    };
    KFileSystemType::Type fileSystemType(const QString & path);
};
