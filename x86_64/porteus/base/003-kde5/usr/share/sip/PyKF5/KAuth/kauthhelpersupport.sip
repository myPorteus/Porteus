namespace KAuth
{
%TypeHeaderCode
#include <kauthhelpersupport.h>
%End
    namespace HelperSupport
    {
%TypeHeaderCode
#include <kauthhelpersupport.h>
%End
        void progressStep(int step);
        void progressStep(const QMap<QString, QVariant> & data);
        bool isStopped();
        int helperMain(int argc, char **  argv, const char*  id, QObject*  responder);
        int callerUid();
    };
};
