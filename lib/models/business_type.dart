enum BusinessType {
  hairSalon,
  clinic,
  garage,
  nails,
}
 
String businessTypeLabel(BusinessType type) {
  switch (type) {
    case BusinessType.hairSalon:
      return 'מספרה';
    case BusinessType.clinic:
      return 'קליניקה אסתטית';
    case BusinessType.garage:
      return 'מוסך';
    case BusinessType.nails:
      return 'עיצוב ציפורניים';
  }
}
 