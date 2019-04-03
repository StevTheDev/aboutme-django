# Generated by Django 2.1.7 on 2019-04-03 22:01

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    replaces = [('articles', '0001_squashed_0001_initial'), ('articles', '0002_auto_20190316_0229'), ('articles', '0003_auto_20190318_1526'), ('articles', '0004_article_public'), ('articles', '0005_auto_20190318_1647'), ('articles', '0006_article_code'), ('articles', '0007_article_language')]

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Article',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('modified_at', models.DateTimeField(auto_now=True)),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='authored_articles', to=settings.AUTH_USER_MODEL)),
                ('body', models.FileField(default='', upload_to='articles\\body')),
                ('public', models.BooleanField(default=False)),
                ('code', models.FileField(blank=True, null=True, upload_to='articles\\body')),
                ('language', models.CharField(default='Python 3', max_length=20)),
            ],
        ),
    ]
