class KPixmapProvider
{
%TypeHeaderCode
#include <kpixmapprovider.h>
%End
public:
    virtual ~KPixmapProvider();
    virtual QPixmap pixmapFor(const QString & text, int size = 0) = 0;
protected:
    virtual void virtual_hook(int id, void*  data);
};
