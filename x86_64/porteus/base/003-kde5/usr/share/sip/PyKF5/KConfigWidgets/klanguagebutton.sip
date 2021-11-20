// Discarded CLASS_DECL on line 19 'QAction' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'KLanguageButtonPrivate' (by default forward declaration handling)
class KLanguageButton: QWidget
{
%TypeHeaderCode
#include <klanguagebutton.h>
%End
    // Discarded VAR_DECL on line 37 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 37 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 46 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KLanguageButton(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 54 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KLanguageButton(const QString & text, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KLanguageButton();
    void setLocale(const QString & locale);
    void setText(const QString & text);
    void showLanguageCodes(bool show);
    void loadAllLanguages();
    void insertLanguage(const QString & languageCode, const QString & name = QString(), int index = -1);
    void insertSeparator(int index = -1);
    int count() const;
    void clear();
    QString current() const;
    bool contains(const QString & languageCode) const;
    void setCurrentItem(const QString & languageCode);
Q_SIGNALS:
    void activated(const QString & languageCode);
    void highlighted(const QString & languageCode);
private:
private:
    private:
        KLanguageButton(const KLanguageButton &); // Generated
};
