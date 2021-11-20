// Discarded CLASS_DECL on line 14 'QWidget' (by default forward declaration handling)
class KPageWidgetItem: QObject
{
%TypeHeaderCode
#include <kpagewidgetmodel.h>
%End
    // Discarded VAR_DECL on line 39 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 39 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 39 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 39 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 39 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 39 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    KPageWidgetItem(QWidget*  widget);
    KPageWidgetItem(QWidget*  widget, const QString & name);
    virtual ~KPageWidgetItem();
    QWidget * widget() const;
    void setName(const QString & name);
    QString name() const;
    void setHeader(const QString & header);
    QString header() const;
    void setIcon(const QIcon & icon);
    QIcon icon() const;
    void setCheckable(bool checkable);
    bool isCheckable() const;
    bool isChecked() const;
    bool isEnabled() const;
    bool isHeaderVisible() const;
    void setHeaderVisible(bool visible);
public Q_SLOTS:
    void setEnabled(bool __0);
    void setChecked(bool checked);
Q_SIGNALS:
    void changed();
    void toggled(bool checked);
private:
    // Discarded CLASS_DECL on line 183 'KPageWidgetItemPrivate' (by default forward declaration handling)
    private:
        KPageWidgetItem(const KPageWidgetItem &); // Generated
};
// Discarded CLASS_DECL on line 186 'KPageWidgetModelPrivate' (by default forward declaration handling)
class KPageWidgetModel: KPageModel
{
%TypeHeaderCode
#include <kpagewidgetmodel.h>
%End
    // Discarded VAR_DECL on line 196 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 196 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 196 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 196 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 196 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 196 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 205 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPageWidgetModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KPageWidgetModel();
    KPageWidgetItem * addPage(QWidget*  widget, const QString & name);
    void addPage(KPageWidgetItem*  item);
    KPageWidgetItem * insertPage(KPageWidgetItem*  before, QWidget*  widget, const QString & name);
    void insertPage(KPageWidgetItem*  before, KPageWidgetItem*  item);
    KPageWidgetItem * // Modified PARM_DECL on line 260 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    addSubPage(KPageWidgetItem*  parent /TransferThis/, QWidget*  widget, const QString & name);
    void // Modified PARM_DECL on line 269 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    addSubPage(KPageWidgetItem*  parent /TransferThis/, KPageWidgetItem*  item);
    void removePage(KPageWidgetItem*  item);
    virtual int columnCount(const QModelIndex & parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    virtual bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);
    virtual Qt::ItemFlags flags(const QModelIndex & index) const;
    virtual QModelIndex index(int row, int column, const QModelIndex & parent = QModelIndex()) const;
    virtual QModelIndex parent(const QModelIndex & index) const;
    virtual int rowCount(const QModelIndex & parent = QModelIndex()) const;
    KPageWidgetItem * item(const QModelIndex & index) const;
    QModelIndex index(const KPageWidgetItem*  item) const;
Q_SIGNALS:
    void toggled(KPageWidgetItem*  page, bool checked);
private:
    private:
        KPageWidgetModel(const KPageWidgetModel &); // Generated
};
