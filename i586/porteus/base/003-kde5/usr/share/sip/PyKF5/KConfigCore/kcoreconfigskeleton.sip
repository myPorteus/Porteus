// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_item_add_py_subclass): {'usage': 1}
%ModuleHeaderCode
#include <kcoreconfigskeleton.h>

class PyItemBool : public KCoreConfigSkeleton::ItemBool
{
public:
    PyItemBool (const QString &group, const QString &key, bool& val, bool defaultValue = 1) :
        KCoreConfigSkeleton::ItemBool (group, key, this->value, defaultValue),
        value(val)
    {
    }

private:
    bool value;
};

class PyItemInt : public KCoreConfigSkeleton::ItemInt
{
public:
    PyItemInt (const QString &group, const QString &key, qint32& val, qint32 defaultValue = 1) :
        KCoreConfigSkeleton::ItemInt (group, key, this->value, defaultValue),
        value(val)
    {
    }

private:
    qint32 value;
};

class PyItemUInt : public KCoreConfigSkeleton::ItemUInt
{
public:
    PyItemUInt (const QString &group, const QString &key, quint32& val, quint32 defaultValue = 1) :
        KCoreConfigSkeleton::ItemUInt (group, key, this->value, defaultValue),
        value(val)
    {
    }

private:
    quint32 value;
};

class PyItemLongLong : public KCoreConfigSkeleton::ItemLongLong
{
public:
    PyItemLongLong (const QString &group, const QString &key, qint64& val, qint64 defaultValue = 1) :
        KCoreConfigSkeleton::ItemLongLong (group, key, this->value, defaultValue),
        value(val)
    {
    }

private:
    qint64 value;
};

class PyItemULongLong : public KCoreConfigSkeleton::ItemULongLong
{
public:
    PyItemULongLong (const QString &group, const QString &key, quint64& val, quint64 defaultValue = 1) :
        KCoreConfigSkeleton::ItemULongLong (group, key, this->value, defaultValue),
        value(val)
    {
    }

private:
    quint64 value;
};

class PyItemDouble : public KCoreConfigSkeleton::ItemDouble
{
public:
    PyItemDouble (const QString &group, const QString &key, double& val, double defaultValue = 1) :
        KCoreConfigSkeleton::ItemDouble (group, key, this->value, defaultValue),
        value(val)
    {
    }

private:
    double value;
};

class PyItemEnum : public KCoreConfigSkeleton::ItemEnum
{
public:
    PyItemEnum (const QString& group, const QString& key, int& val, const QList<KCoreConfigSkeleton::ItemEnum::Choice>& choices, int defaultValue = 0) :
        KCoreConfigSkeleton::ItemEnum(group, key, this->value, choices, defaultValue),
        value(val)
    {
    };

private:
    int value;
};
%End
// Discarded CLASS_DECL on line 25 'KCoreConfigSkeletonPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 27 'KConfigSkeletonItemPrivate' (by default forward declaration handling)
class KConfigSkeletonItem
{
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
public:
    typedef QList<KConfigSkeletonItem *> List;
    typedef QHash<QString, KConfigSkeletonItem *> Dict;
    // Discarded TYPEDEF_DECL on line 47 'DictIterator'
    KConfigSkeletonItem(const QString & _group, const QString & _key);
    virtual ~KConfigSkeletonItem();
    void setGroup(const QString & _group);
    QString group() const;
    void setGroup(const KConfigGroup & cg);
    KConfigGroup configGroup(KConfig*  config) const;
    void setKey(const QString & _key);
    QString key() const;
    void setName(const QString & _name);
    QString name() const;
    void setLabel(const QString & l);
    QString label() const;
    void setToolTip(const QString & t);
    QString toolTip() const;
    void setWhatsThis(const QString & w);
    QString whatsThis() const;
    void setWriteFlags(QFlags<KConfigBase::WriteConfigFlag> flags);
    KConfigBase::WriteConfigFlags writeFlags() const;
    virtual void readConfig(KConfig*  __0) = 0;
    virtual void writeConfig(KConfig*  __0) = 0;
    virtual void readDefault(KConfig*  __0) = 0;
    virtual void setProperty(const QVariant & p) = 0;
    virtual bool isEqual(const QVariant & p) const = 0;
    virtual QVariant property() const = 0;
    virtual QVariant minValue() const;
    virtual QVariant maxValue() const;
    virtual void setDefault() = 0;
    virtual void swapDefault() = 0;
    bool isImmutable() const;
    bool isDefault() const;
    bool isSaveNeeded() const;
    QVariant getDefault() const;
protected:
    // Discarded CONSTRUCTOR on line 240 'KConfigSkeletonItem' (by rules_PyKF5.py:FunctionRuleDb[31],function_discard)
    void readImmutability(const KConfigGroup & group);
    // Discarded FIELD_DECL on line 248 'mGroup'
    // Discarded FIELD_DECL on line 249 'mKey'
    // Discarded FIELD_DECL on line 250 'mName'
    // Discarded CXX_METHOD on line 254 'setIsDefaultImpl' (by rules_PyKF5.py:FunctionRuleDb[23],function_discard)
    // Discarded CXX_METHOD on line 255 'setIsSaveNeededImpl' (by rules_PyKF5.py:FunctionRuleDb[23],function_discard)
    // Discarded CXX_METHOD on line 256 'setGetDefaultImpl' (by rules_PyKF5.py:FunctionRuleDb[23],function_discard)
    // Discarded FIELD_DECL on line 258 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
    private:
        KConfigSkeletonItem(const KConfigSkeletonItem &); // Generated
};
// Discarded CLASS_DECL on line 261 'KPropertySkeletonItemPrivate' (by default forward declaration handling)
class KPropertySkeletonItem: KConfigSkeletonItem
{
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
public:
    KPropertySkeletonItem(QObject*  object, const QByteArray & propertyName, const QVariant & defaultValue);
    virtual QVariant property() const;
    virtual void setProperty(const QVariant & p);
    virtual bool isEqual(const QVariant & p) const;
    virtual void readConfig(KConfig*  __0);
    virtual void writeConfig(KConfig*  __0);
    virtual void readDefault(KConfig*  __0);
    virtual void setDefault();
    virtual void swapDefault();
    // Discarded CXX_METHOD on line 313 'setNotifyFunction' (by rules_PyKF5.py:FunctionRuleDb[23],function_discard)
};
// Discarded CLASS_TEMPLATE on line 319 'KConfigSkeletonGenericItem' (by rules_PyKF5.py:ContainerRuleDb[23],container_discard)
// Discarded CLASS_DECL on line 434 'KConfigCompilerSignallingItem' (by rules_PyKF5.py:ContainerRuleDb[20],container_discard)
class KCoreConfigSkeleton: QObject
{
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    // Discarded VAR_DECL on line 543 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 543 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 543 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 543 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 543 'tr' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 543 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
public:
// Modified CLASS_DECL on line 548 'ItemString' (by rules_PyKF5.py:ContainerRuleDb[1],set_skeleton_item_base):
    class ItemString: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        enum Type {
            Normal,
            Password,
            Path
        };
        ItemString(const QString & _group, const QString & _key, QString & reference, const QString & defaultValue = QLatin1String(""), KCoreConfigSkeleton::ItemString::Type type = KCoreConfigSkeleton::ItemString::Normal);
        virtual void writeConfig(KConfig*  config);
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    private:
    };
    class ItemPassword: KCoreConfigSkeleton::ItemString
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemPassword(const QString & _group, const QString & _key, QString & reference, const QString & defaultValue = QLatin1String(""));
    };
    class ItemPath: KCoreConfigSkeleton::ItemString
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemPath(const QString & _group, const QString & _key, QString & reference, const QString & defaultValue = QString());
    };
// Modified CLASS_DECL on line 622 'ItemUrl' (by rules_PyKF5.py:ContainerRuleDb[2],set_skeleton_item_base):
    class ItemUrl: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemUrl(const QString & _group, const QString & _key, QUrl & reference, const QUrl & defaultValue = QUrl());
        virtual void writeConfig(KConfig*  config);
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
// Modified CLASS_DECL on line 648 'ItemProperty' (by rules_PyKF5.py:ContainerRuleDb[3],set_skeleton_item_base):
    class ItemProperty: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemProperty(const QString & _group, const QString & _key, QVariant & reference, const QVariant & defaultValue = QVariant());
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
// Modified CLASS_DECL on line 667 'ItemBool' (by rules_PyKF5.py:ContainerRuleDb[4],set_skeleton_item_base):
    class ItemBool: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemBool(const QString & _group, const QString & _key, bool  reference, bool defaultValue = true);
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_item_xxx): {'usage': 1, 'ctx': 'Bool'}
%MethodCode
    sipCpp = new sipKCoreConfigSkeleton_ItemBool (*a0, *a1, a2, a3);
%End
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
// Modified CLASS_DECL on line 689 'ItemInt' (by rules_PyKF5.py:ContainerRuleDb[5],set_skeleton_item_base):
    class ItemInt: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemInt(const QString & _group, const QString & _key, int  reference, int defaultValue = 0);
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_item_xxx): {'usage': 1, 'ctx': 'Int'}
%MethodCode
    sipCpp = new sipKCoreConfigSkeleton_ItemInt (*a0, *a1, a2, a3);
%End
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
        virtual QVariant minValue() const;
        virtual QVariant maxValue() const;
        void setMinValue(int __0);
        void setMaxValue(int __0);
    private:
    };
// Modified CLASS_DECL on line 733 'ItemLongLong' (by rules_PyKF5.py:ContainerRuleDb[6],set_skeleton_item_base):
    class ItemLongLong: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemLongLong(const QString & _group, const QString & _key, long long  reference, long long defaultValue = 0);
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_item_xxx): {'usage': 1, 'ctx': 'LongLong'}
%MethodCode
    sipCpp = new sipKCoreConfigSkeleton_ItemLongLong (*a0, *a1, a2, a3);
%End
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
        virtual QVariant minValue() const;
        virtual QVariant maxValue() const;
        void setMinValue(long long __0);
        void setMaxValue(long long __0);
    private:
    };
    typedef KCoreConfigSkeleton::ItemLongLong ItemInt64;
    class ItemEnum: KCoreConfigSkeleton::ItemInt
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        struct Choice
        {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
            QString name;
            QString label;
            QString toolTip;
            QString whatsThis;
        };
        ItemEnum(const QString & _group, const QString & _key, int  reference, const QList<KCoreConfigSkeleton::ItemEnum::Choice> & choices, int defaultValue = 0);
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_item_enum): {'usage': 1, 'ctx': 'Enum'}
%MethodCode
    sipCpp = new sipKCoreConfigSkeleton_ItemEnum (*a0, *a1, a2, *a3, a4);
%End
        QList<KCoreConfigSkeleton::ItemEnum::Choice> choices() const;
        virtual void readConfig(KConfig*  config);
        virtual void writeConfig(KConfig*  config);
        typedef KCoreConfigSkeleton::ItemEnum::Choice Choice2;
        QList<KCoreConfigSkeleton::ItemEnum::Choice> choices2() const;
        QString valueForChoice(const QString & name) const;
        void setValueForChoice(const QString & name, const QString & valueForChoice);
    private:
    };
// Modified CLASS_DECL on line 821 'ItemUInt' (by rules_PyKF5.py:ContainerRuleDb[7],set_skeleton_item_base):
    class ItemUInt: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemUInt(const QString & _group, const QString & _key, unsigned int  reference, unsigned int defaultValue = 0);
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_item_xxx): {'usage': 1, 'ctx': 'UInt'}
%MethodCode
    sipCpp = new sipKCoreConfigSkeleton_ItemUInt (*a0, *a1, a2, a3);
%End
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
        virtual QVariant minValue() const;
        virtual QVariant maxValue() const;
        void setMinValue(unsigned int __0);
        void setMaxValue(unsigned int __0);
    private:
    };
// Modified CLASS_DECL on line 861 'ItemULongLong' (by rules_PyKF5.py:ContainerRuleDb[8],set_skeleton_item_base):
    class ItemULongLong: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemULongLong(const QString & _group, const QString & _key, unsigned long long  reference, unsigned long long defaultValue = 0);
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_item_xxx): {'usage': 1, 'ctx': 'ULongLong'}
%MethodCode
    sipCpp = new sipKCoreConfigSkeleton_ItemULongLong (*a0, *a1, a2, a3);
%End
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
        virtual QVariant minValue() const;
        virtual QVariant maxValue() const;
        void setMinValue(unsigned long long __0);
        void setMaxValue(unsigned long long __0);
    private:
    };
    typedef KCoreConfigSkeleton::ItemULongLong ItemUInt64;
// Modified CLASS_DECL on line 904 'ItemDouble' (by rules_PyKF5.py:ContainerRuleDb[9],set_skeleton_item_base):
    class ItemDouble: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemDouble(const QString & _group, const QString & _key, double  reference, double defaultValue = 0);
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_item_xxx): {'usage': 1, 'ctx': 'Double'}
%MethodCode
    sipCpp = new sipKCoreConfigSkeleton_ItemDouble (*a0, *a1, a2, a3);
%End
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
        virtual QVariant minValue() const;
        virtual QVariant maxValue() const;
        void setMinValue(double __0);
        void setMaxValue(double __0);
    private:
    };
// Modified CLASS_DECL on line 944 'ItemRect' (by rules_PyKF5.py:ContainerRuleDb[10],set_skeleton_item_base):
    class ItemRect: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemRect(const QString & _group, const QString & _key, QRect & reference, const QRect & defaultValue = QRect());
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
// Modified CLASS_DECL on line 966 'ItemPoint' (by rules_PyKF5.py:ContainerRuleDb[11],set_skeleton_item_base):
    class ItemPoint: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemPoint(const QString & _group, const QString & _key, QPoint & reference, const QPoint & defaultValue = QPoint());
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
// Modified CLASS_DECL on line 988 'ItemSize' (by rules_PyKF5.py:ContainerRuleDb[12],set_skeleton_item_base):
    class ItemSize: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemSize(const QString & _group, const QString & _key, QSize & reference, const QSize & defaultValue = QSize());
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
// Modified CLASS_DECL on line 1010 'ItemDateTime' (by rules_PyKF5.py:ContainerRuleDb[13],set_skeleton_item_base):
    class ItemDateTime: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemDateTime(const QString & _group, const QString & _key, QDateTime & reference, const QDateTime & defaultValue = QDateTime());
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
// Modified CLASS_DECL on line 1032 'ItemStringList' (by rules_PyKF5.py:ContainerRuleDb[14],set_skeleton_item_base):
    class ItemStringList: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemStringList(const QString & _group, const QString & _key, QStringList & reference, const QStringList & defaultValue = QStringList());
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
    class ItemPathList: KCoreConfigSkeleton::ItemStringList
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemPathList(const QString & _group, const QString & _key, QStringList & reference, const QStringList & defaultValue = QStringList());
        virtual void readConfig(KConfig*  config);
        virtual void writeConfig(KConfig*  config);
    };
// Modified CLASS_DECL on line 1069 'ItemUrlList' (by rules_PyKF5.py:ContainerRuleDb[15],set_skeleton_item_base):
    class ItemUrlList: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemUrlList(const QString & _group, const QString & _key, QList<QUrl> & reference, const QList<QUrl> & defaultValue = QList<QUrl>());
        virtual void readConfig(KConfig*  config);
        virtual void writeConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
// Modified CLASS_DECL on line 1094 'ItemIntList' (by rules_PyKF5.py:ContainerRuleDb[16],set_skeleton_item_base):
    class ItemIntList: KConfigSkeletonItem
    {
%TypeHeaderCode
#include <kcoreconfigskeleton.h>
%End
    public:
        ItemIntList(const QString & _group, const QString & _key, QList<int> & reference, const QList<int> & defaultValue = QList<int>());
        virtual void readConfig(KConfig*  config);
        virtual void setProperty(const QVariant & p);
        virtual bool isEqual(const QVariant & p) const;
        virtual QVariant property() const;
    };
public:
    // Modified PARM_DECL on line 1121 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCoreConfigSkeleton(const QString & configname = QString(), QObject*  parent /TransferThis/ = nullptr);
    // Discarded CONSTRUCTOR on line 1129 'KCoreConfigSkeleton' (by rules_PyKF5.py:FunctionRuleDb[29],function_discard)
    virtual ~KCoreConfigSkeleton();
    virtual void setDefaults();
    void load();
    void readConfig();
    void read();
    bool isDefaults() const;
    bool isSaveNeeded() const;
    void setCurrentGroup(const QString & group);
    QString currentGroup() const;
    void addItem(KConfigSkeletonItem*  __0, const QString & name = QString());
    KCoreConfigSkeleton::ItemString * addItemString(const QString & name, QString & reference, const QString & defaultValue = QLatin1String(""), const QString & key = QString());
    KCoreConfigSkeleton::ItemPassword * addItemPassword(const QString & name, QString & reference, const QString & defaultValue = QLatin1String(""), const QString & key = QString());
    KCoreConfigSkeleton::ItemPath * addItemPath(const QString & name, QString & reference, const QString & defaultValue = QLatin1String(""), const QString & key = QString());
    KCoreConfigSkeleton::ItemProperty * addItemProperty(const QString & name, QVariant & reference, const QVariant & defaultValue = QVariant(), const QString & key = QString());
    KCoreConfigSkeleton::ItemBool * addItemBool(const QString & name, bool & reference, bool defaultValue = false, const QString & key = QString());
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_add_item_xxx): {'usage': 1, 'ctx': 'Bool'}
%MethodCode
    sipRes = new PyItemBool (sipCpp->currentGroup(), a3->isNull() ? *a0 : *a3, a1, a2);
    sipCpp->addItem(sipRes, *a0);
%End
    KCoreConfigSkeleton::ItemInt * addItemInt(const QString & name, int & reference, int defaultValue = 0, const QString & key = QString());
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_add_item_xxx): {'usage': 1, 'ctx': 'Int'}
%MethodCode
    sipRes = new PyItemInt (sipCpp->currentGroup(), a3->isNull() ? *a0 : *a3, a1, a2);
    sipCpp->addItem(sipRes, *a0);
%End
    KCoreConfigSkeleton::ItemUInt * addItemUInt(const QString & name, unsigned int & reference, unsigned int defaultValue = 0, const QString & key = QString());
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_add_item_xxx): {'usage': 1, 'ctx': 'UInt'}
%MethodCode
    sipRes = new PyItemUInt (sipCpp->currentGroup(), a3->isNull() ? *a0 : *a3, a1, a2);
    sipCpp->addItem(sipRes, *a0);
%End
    KCoreConfigSkeleton::ItemLongLong * addItemLongLong(const QString & name, long long & reference, long long defaultValue = 0, const QString & key = QString());
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_add_item_xxx): {'usage': 1, 'ctx': 'LongLong'}
%MethodCode
    sipRes = new PyItemLongLong (sipCpp->currentGroup(), a3->isNull() ? *a0 : *a3, a1, a2);
    sipCpp->addItem(sipRes, *a0);
%End
    KCoreConfigSkeleton::ItemLongLong * addItemInt64(const QString & name, long long & reference, long long defaultValue = 0, const QString & key = QString());
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_add_item_xxx): {'usage': 1, 'ctx': 'LongLong'}
%MethodCode
    sipRes = new PyItemLongLong (sipCpp->currentGroup(), a3->isNull() ? *a0 : *a3, a1, a2);
    sipCpp->addItem(sipRes, *a0);
%End
    KCoreConfigSkeleton::ItemULongLong * addItemULongLong(const QString & name, unsigned long long & reference, unsigned long long defaultValue = 0, const QString & key = QString());
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_add_item_xxx): {'usage': 1, 'ctx': 'ULongLong'}
%MethodCode
    sipRes = new PyItemULongLong (sipCpp->currentGroup(), a3->isNull() ? *a0 : *a3, a1, a2);
    sipCpp->addItem(sipRes, *a0);
%End
    KCoreConfigSkeleton::ItemULongLong * addItemUInt64(const QString & name, unsigned long long & reference, unsigned long long defaultValue = 0, const QString & key = QString());
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_add_item_xxx): {'usage': 1, 'ctx': 'ULongLong'}
%MethodCode
    sipRes = new PyItemULongLong (sipCpp->currentGroup(), a3->isNull() ? *a0 : *a3, a1, a2);
    sipCpp->addItem(sipRes, *a0);
%End
    KCoreConfigSkeleton::ItemDouble * addItemDouble(const QString & name, double & reference, double defaultValue = 0.0, const QString & key = QString());
// Generated (by rules_PyKF5.py:_kcoreconfigskeleton_add_item_xxx): {'usage': 1, 'ctx': 'Double'}
%MethodCode
    sipRes = new PyItemDouble (sipCpp->currentGroup(), a3->isNull() ? *a0 : *a3, a1, a2);
    sipCpp->addItem(sipRes, *a0);
%End
    KCoreConfigSkeleton::ItemRect * addItemRect(const QString & name, QRect & reference, const QRect & defaultValue = QRect(), const QString & key = QString());
    KCoreConfigSkeleton::ItemPoint * addItemPoint(const QString & name, QPoint & reference, const QPoint & defaultValue = QPoint(), const QString & key = QString());
    KCoreConfigSkeleton::ItemSize * addItemSize(const QString & name, QSize & reference, const QSize & defaultValue = QSize(), const QString & key = QString());
    KCoreConfigSkeleton::ItemDateTime * addItemDateTime(const QString & name, QDateTime & reference, const QDateTime & defaultValue = QDateTime(), const QString & key = QString());
    KCoreConfigSkeleton::ItemStringList * addItemStringList(const QString & name, QStringList & reference, const QStringList & defaultValue = QStringList(), const QString & key = QString());
    KCoreConfigSkeleton::ItemIntList * addItemIntList(const QString & name, QList<int> & reference, const QList<int> & defaultValue = QList<int>(), const QString & key = QString());
    KConfig * config();
    // Discarded CXX_METHOD on line 1458 'config' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    // Discarded CXX_METHOD on line 1464 'sharedConfig' (by rules_PyKF5.py:FunctionRuleDb[13],function_discard)
    // Discarded CXX_METHOD on line 1469 'setSharedConfig' (by rules_PyKF5.py:FunctionRuleDb[29],function_discard)
    KConfigSkeletonItem::List items() const;
    void removeItem(const QString & name);
    void clearItems();
    bool isImmutable(const QString & name) const;
    KConfigSkeletonItem * findItem(const QString & name) const;
    virtual bool useDefaults(bool b);
public Q_SLOTS:
    bool save();
    void writeConfig();
Q_SIGNALS:
    void configChanged();
protected:
    virtual bool usrUseDefaults(bool b);
    virtual void usrSetDefaults();
    virtual void usrRead();
    virtual bool usrSave();
    virtual void usrReadConfig();
    virtual bool usrWriteConfig();
private:
    private:
        KCoreConfigSkeleton(const KCoreConfigSkeleton &); // Generated
};
