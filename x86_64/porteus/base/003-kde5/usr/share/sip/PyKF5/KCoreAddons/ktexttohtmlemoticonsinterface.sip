class KTextToHTMLEmoticonsInterface
{
%TypeHeaderCode
#include <ktexttohtmlemoticonsinterface.h>
%End
public:
    KTextToHTMLEmoticonsInterface();
    virtual ~KTextToHTMLEmoticonsInterface();
    virtual QString parseEmoticons(const QString & text, bool strictParse = false, const QStringList & exclude = QStringList()) = 0;
};
// Discarded STRUCT_DECL on line 30 'QMetaTypeId' (by rules_PyKF5.py:ContainerRuleDb[2],container_discard)
