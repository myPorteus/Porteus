// Discarded CLASS_DECL on line 18 'KPixmapProvider' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'KHistoryComboBoxPrivate' (by default forward declaration handling)
class KHistoryComboBox: KComboBox
{
%TypeHeaderCode
#include <khistorycombobox.h>
%End
    // Discarded VAR_DECL on line 44 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 44 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 44 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 44 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 44 'tr' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 44 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
public:
    // Modified PARM_DECL on line 67 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KHistoryComboBox(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 75 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KHistoryComboBox(bool useCompletion, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KHistoryComboBox();
    void setHistoryItems(const QStringList & items);
    void setHistoryItems(const QStringList & items, bool setCompletionList);
    QStringList historyItems() const;
    bool removeFromHistory(const QString & item);
    void setPixmapProvider(KPixmapProvider*  provider);
    KPixmapProvider * pixmapProvider() const;
    // Discarded CXX_METHOD on line 186 'setIconProvider' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public Q_SLOTS:
    void addToHistory(const QString & item);
    void clearHistory();
    void reset();
Q_SIGNALS:
    void cleared();
protected:
    virtual void keyPressEvent(QKeyEvent*  __0);
    virtual void wheelEvent(QWheelEvent*  ev);
    void insertItems(const QStringList & items);
    bool useCompletion() const;
private:
    KHistoryComboBox(const KHistoryComboBox & __0);
};
