// Discarded CLASS_DECL on line 21 'QPushButton' (by default forward declaration handling)
class KGuiItem
{
%TypeHeaderCode
#include <kguiitem.h>
%End
public:
    KGuiItem();
    KGuiItem(const QString & text, const QString & iconName = QString(), const QString & toolTip = QString(), const QString & whatsThis = QString());
    KGuiItem(const QString & text, const QIcon & icon, const QString & toolTip = QString(), const QString & whatsThis = QString());
    KGuiItem(const KGuiItem & other);
    // Discarded CXX_METHOD on line 76 'operator=' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    ~KGuiItem();
    void setText(const QString & text);
    QString text() const;
    QString plainText() const;
    void setIcon(const QIcon & iconset);
    QIcon icon() const;
    void setIconName(const QString & iconName);
    QString iconName() const;
    bool hasIcon() const;
    void setToolTip(const QString & tooltip);
    QString toolTip() const;
    void setWhatsThis(const QString & whatsThis);
    QString whatsThis() const;
    void setEnabled(bool enable);
    bool isEnabled() const;
    static void assign(QPushButton*  button, const KGuiItem & item);
private:
    // Discarded CLASS_DECL on line 193 'KGuiItemPrivate' (by default forward declaration handling)
};
