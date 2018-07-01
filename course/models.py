from django.db import models
from django.contrib.auth.models import User

def user_directory_path(filename):
    return 'uploads/%Y/%m/%d'

class Course(models.Model):
	name = models.CharField(max_length=100, null=False)
	code = models.CharField(max_length=7, null=False, unique=True)

	def __str__(self):
		return "{}-{}".format(self.code, self.name)

class Tag(models.Model):
	name = models.CharField(max_length=50)

	def __str__(self):
		return "{}".format(self.name)

class List(models.Model):
	name = models.CharField(max_length=100, null=False)
	teacher = models.CharField(max_length=100, null=True, blank=True)
	file = models.FileField(upload_to='uploads/%Y/%m/%d', null=True, blank=True)
	tags = models.ManyToManyField(Tag, blank=True)
	course = models.ForeignKey('Course', on_delete=models.CASCADE, null=False, related_name='list')
	user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, related_name='list')

	def __str__(self):
		return "{} --> {}".format(self.name, self.file)

class Summary(models.Model):
	name = models.CharField(max_length=100, null=False)
	teacher = models.CharField(max_length=100, null=True, blank=True)
	file = models.FileField(upload_to='uploads/%Y/%m/%d', null=True, blank=True)
	tags = models.ManyToManyField(Tag, blank=True)
	course = models.ForeignKey('Course', on_delete=models.CASCADE, related_name='summary')
	user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, related_name='summary')

	
	def __str__(self):
		return "{} --> {}".format(self.name, self.file)

class Link(models.Model):
	name = models.CharField(max_length=100, null=False)
	description = models.TextField(null=True, blank=True)
	link = models.URLField(null=False)
	teacher = models.CharField(max_length=100, null=True, blank=True)
	tags = models.ManyToManyField(Tag, blank=True)
	course = models.ForeignKey('Course', on_delete=models.CASCADE, related_name='link')
	user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, related_name='link')

	def __str__(self):
		return "{} --> {}".format(self.name, self.link)
