// Discarded CLASS_DECL on line 18 'QLineEdit' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QComboBox' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QListView' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'QPushButton' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'QItemSelection' (by default forward declaration handling)
class KEditListWidget: QWidget
{
%TypeHeaderCode
#include <keditlistwidget.h>
%End
    // Discarded VAR_DECL on line 40 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 40 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 40 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    class CustomEditor
    {
%TypeHeaderCode
#include <keditlistwidget.h>
%End
    public:
        CustomEditor();
        CustomEditor(QWidget*  repWidget, QLineEdit*  edit);
        CustomEditor(QComboBox*  combo);
        virtual ~CustomEditor();
        void setRepresentationWidget(QWidget*  repWidget);
        void setLineEdit(QLineEdit*  edit);
        virtual QWidget * representationWidget() const;
        virtual QLineEdit * lineEdit() const;
    private:
        // Discarded CLASS_DECL on line 66 'KEditListWidgetCustomEditorPrivate' (by default forward declaration handling)
        CustomEditor(const KEditListWidget::CustomEditor & __0);
    };
public:
    enum Button {
        Add,
        Remove,
        UpDown,
        All
    };
    typedef QFlags<KEditListWidget::Button> Buttons;
    // Modified PARM_DECL on line 93 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KEditListWidget(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 106 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KEditListWidget(const KEditListWidget::CustomEditor & customEditor, QWidget*  parent /TransferThis/ = nullptr, bool checkAtEntering = false, QFlags<KEditListWidget::Button> buttons = KEditListWidget::All);
    virtual ~KEditListWidget();
    QListView * listView() const;
    QLineEdit * lineEdit() const;
    QPushButton * addButton() const;
    QPushButton * removeButton() const;
    QPushButton * upButton() const;
    QPushButton * downButton() const;
    int count() const;
    void insertStringList(const QStringList & list, int index = -1);
    void insertItem(const QString & text, int index = -1);
    void clear();
    QString text(int index) const;
    int currentItem() const;
    QString currentText() const;
    QStringList items() const;
    void setItems(const QStringList & items);
    KEditListWidget::Buttons buttons() const;
    void setButtons(QFlags<KEditListWidget::Button> buttons);
    void setCheckAtEntering(bool check);
    bool checkAtEntering();
    void setCustomEditor(const KEditListWidget::CustomEditor & editor);
    virtual bool eventFilter(QObject*  o, QEvent*  e);
Q_SIGNALS:
    void changed();
    void added(const QString & text);
    void removed(const QString & text);
private:
private:
    // Discarded CLASS_DECL on line 252 'KEditListWidgetPrivate' (by default forward declaration handling)
    KEditListWidget(const KEditListWidget & __0);
};
// Discarded FUNCTION_DECL on line 257 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 257 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 257 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
