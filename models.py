from django.db import models

class Notification(models.Model):
    notification_id = models.AutoField(primary_key=True)
    file = models.ForeignKey('ArrestFile', on_delete=models.CASCADE, related_name='notifications')
    status_change = models.BooleanField()  # يمثل BOOLEAN في قاعدة البيانات

    class Meta:
        db_table = 'Notification'

class center(models.Model):
   
    centerid = models.IntegerField(primary_key=True, default=1) 
    centername = models.CharField(max_length=30, null=True, blank=True)
    location = models.CharField(max_length=30, null=True, blank=True)

    class Meta:
        db_table = 'center'  # التأكد من أن اسم الجدول هو 'center' بالأحرف الصغيرة


class ArrestFile(models.Model):
    fileid = models.AutoField(primary_key=True)  # يطابق العمود "fileid"
    fullname = models.CharField(max_length=255)  # يطابق "fullname"
    idtype = models.CharField(max_length=50, null=True, blank=True)  # يطابق "idtype"
    nationality = models.CharField(max_length=50, null=True, blank=True)  # يطابق "nationality"
    birthdate = models.DateField(null=True, blank=True)  # يطابق "birthdate"
    idnumber = models.CharField(max_length=50)  # يطابق "idnumber"
    charge = models.CharField(max_length=255, null=True, blank=True)  # يطابق "charge"
    arrestauthority = models.CharField(max_length=255, null=True, blank=True)  # يطابق "arrestauthority"
    arrestlocation = models.CharField(max_length=255, null=True, blank=True)  # يطابق "arrestlocation"
    arrestdate = models.DateField(null=True, blank=True)  # يطابق "arrestdate"
    address = models.TextField(null=True, blank=True)  # يطابق "address"
    phonenumber = models.CharField(max_length=20, null=True, blank=True)  # يطابق "phonenumber"
    casenumber = models.IntegerField(null=True, blank=True)  # يطابق "casenumber"
    detentionauthority = models.CharField(max_length=255, null=True, blank=True)  # يطابق "detentionauthority"
    uploaddate = models.DateTimeField(auto_now_add=True)  # يطابق "uploaddate"
    detaineeid = models.IntegerField()  # يطابق "detaineeid"
    centerid = models.IntegerField()  # يطابق "centerid"

    class Meta:
        db_table = 'arrestfiles'  # يطابق اسم الجدول في قاعدة البيانات


class Detainee(models.Model):
    detaineeid = models.AutoField(primary_key=True)  # يطابق "detaineeid"
    idtype = models.CharField(max_length=20)  # يطابق "idtype"
    casenumber = models.IntegerField()  # يطابق "casenumber"
    fullname = models.CharField(max_length=150, null=True, blank=True)  # يطابق "fullname"
    arrestdate = models.DateField(null=True, blank=True)  # يطابق "arrestdate"
    dateofbirth = models.DateField(null=True, blank=True)  # يطابق "dateofbirth"
    arrestingauthority = models.CharField(max_length=60, null=True, blank=True)  # يطابق "arrestingauthority"
    detentionauthority = models.CharField(max_length=60, null=True, blank=True)  # يطابق "detentionauthority"
    address = models.CharField(max_length=255, null=True, blank=True)  # يطابق "address"
    status = models.CharField(max_length=10, null=True, blank=True)  # يطابق "status"
    placeofarrest = models.CharField(max_length=60, null=True, blank=True)  # يطابق "placeofarrest"
    nationality = models.CharField(max_length=30, null=True, blank=True)  # يطابق "nationality"
    mobilenumber = models.CharField(max_length=15, null=True, blank=True)  # يطابق "mobilenumber"
    charge = models.CharField(max_length=100, null=True, blank=True)  # يطابق "charge"
    centerid = models.IntegerField()  # يطابق "centerid"
    fileid = models.IntegerField()  # يطابق "fileid"
    caseid = models.IntegerField()  # يطابق "caseid"

    class Meta:
        db_table = 'detainee'  # يطابق اسم الجدول في قاعدة البيانات


class Case(models.Model):
    case_id = models.AutoField(primary_key=True)
    case_number = models.IntegerField(unique=True)
    defendant_name = models.CharField(max_length=100)
    case_status = models.CharField(max_length=50)
    court_date = models.DateField(null=True, blank=True)
    judgment_date = models.DateField(null=True, blank=True)
    arrest_file = models.ForeignKey(ArrestFile, on_delete=models.CASCADE, related_name='cases')

    class Meta:
        db_table = 'Cases'

class Observer(models.Model):
    observer_id = models.AutoField(primary_key=True)
    observer_name = models.CharField(max_length=60)
    password = models.CharField(max_length=255)

    class Meta:
        db_table = 'Observer'

class PrisonDirector(models.Model):
    director_id = models.AutoField(primary_key=True)
    director_name = models.CharField(max_length=40)
    password = models.CharField(max_length=255)
    branch = models.CharField(max_length=60)

    class Meta:
        db_table = 'PrisonDirector'

