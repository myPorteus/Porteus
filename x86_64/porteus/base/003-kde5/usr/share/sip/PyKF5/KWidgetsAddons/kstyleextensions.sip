namespace KStyleExtensions
{
%TypeHeaderCode
#include <kstyleextensions.h>
%End
    QStyle::ControlElement customControlElement(const QString & element, const QWidget*  widget);
    QStyle::StyleHint customStyleHint(const QString & element, const QWidget*  widget);
    QStyle::SubElement customSubElement(const QString & element, const QWidget*  widget);
};
