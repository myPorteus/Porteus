// Discarded CLASS_DECL on line 21 'KCompletionBox' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'KComboBoxPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 24 'QLineEdit' (by default forward declaration handling)
// Discarded CLASS_DECL on line 25 'QMenu' (by default forward declaration handling)
class KComboBox: QComboBox, KCompletionBase
{
%TypeHeaderCode
#include <kcombobox.h>
%End
    // Discarded VAR_DECL on line 137 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 137 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 137 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 137 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 137 'tr' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 137 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
public:
    // Modified PARM_DECL on line 150 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KComboBox(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 158 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KComboBox(bool rw, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KComboBox();
    void insertURL(const QUrl & url, int index = -1);
    void insertURL(const QPixmap & pixmap, const QUrl & url, int index = -1);
    void changeURL(const QUrl & url, int index);
    void changeURL(const QPixmap & pixmap, const QUrl & url, int index);
    void setEditUrl(const QUrl & url);
    void addUrl(const QUrl & url);
    void addUrl(const QIcon & icon, const QUrl & url);
    void insertUrl(int index, const QUrl & url);
    void insertUrl(int index, const QIcon & icon, const QUrl & url);
    void changeUrl(int index, const QUrl & url);
    void changeUrl(int index, const QIcon & icon, const QUrl & url);
    int cursorPosition() const;
    virtual void setAutoCompletion(bool autocomplete);
    bool autoCompletion() const;
    virtual void setContextMenuEnabled(bool showMenu);
    void setUrlDropsEnabled(bool enable);
    bool urlDropsEnabled() const;
    bool contains(const QString & text) const;
    void setTrapReturnKey(bool trap);
    bool trapReturnKey() const;
    KCompletionBox * completionBox(bool create = true);
    virtual void setLineEdit(QLineEdit*  __0);
    void setEditable(bool editable);
    QMenu * contextMenu() const;
Q_SIGNALS:
    void returnPressed();
    void returnPressed(const QString & text);
    void completion(const QString & __0);
    void substringCompletion(const QString & __0);
    void textRotation(KCompletionBase::KeyBindingType __0);
    void completionModeChanged(KCompletion::CompletionMode __0);
    void aboutToShowContextMenu(QMenu*  contextMenu);
public Q_SLOTS:
    void rotateText(KCompletionBase::KeyBindingType type);
    virtual void setCompletedText(const QString & __0);
    virtual void setCompletedItems(const QStringList & items, bool autosubject = true);
    void setCurrentItem(const QString & item, bool insert = false, int index = -1);
protected Q_SLOTS:
    virtual void makeCompletion(const QString & __0);
protected:
    virtual void setCompletedText(const QString & text, bool marked);
    virtual QSize minimumSizeHint() const;
protected:
    // Discarded CONSTRUCTOR on line 536 'KComboBox' (by rules_PyKF5.py:FunctionRuleDb[17],function_discard)
private:
    private:
        KComboBox(const KComboBox &); // Generated
};
