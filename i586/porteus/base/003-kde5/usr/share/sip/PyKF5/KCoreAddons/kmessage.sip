// Discarded CLASS_DECL on line 15 'KMessageHandler' (by default forward declaration handling)
namespace KMessage
{
%TypeHeaderCode
#include <kmessage.h>
%End
    enum MessageType {
        Error,
        Information,
        Warning,
        Sorry,
        Fatal
    };
    void message(KMessage::MessageType messageType, const QString & text, const QString & caption = QString());
    void setMessageHandler(KMessageHandler*  handler);
};
class KMessageHandler
{
%TypeHeaderCode
#include <kmessage.h>
%End
public:
    virtual ~KMessageHandler();
    virtual void message(KMessage::MessageType type, const QString & text, const QString & caption) = 0;
};
