from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from octofit_tracker.models import Team, Activity, Leaderboard, Workout

class Command(BaseCommand):
    help = 'Populate the octofit_db database with test data'


    def handle(self, *args, **options):
        # Delete existing data (skip objects with id=None)
        User = get_user_model()
        for obj in User.objects.all():
            if getattr(obj, 'id', None) is not None:
                obj.delete()
        for obj in Team.objects.all():
            if getattr(obj, 'id', None) is not None:
                obj.delete()
        for obj in Activity.objects.all():
            if getattr(obj, 'id', None) is not None:
                obj.delete()
        for obj in Leaderboard.objects.all():
            if getattr(obj, 'id', None) is not None:
                obj.delete()
        for obj in Workout.objects.all():
            if getattr(obj, 'id', None) is not None:
                obj.delete()

        # Create teams
        marvel = Team.objects.create(name='Marvel')
        dc = Team.objects.create(name='DC')

        # Create users (super heroes)
        User = get_user_model()
        ironman = User.objects.create_user(username='ironman', email='ironman@marvel.com', password='password', team=marvel)
        captain = User.objects.create_user(username='captainamerica', email='cap@marvel.com', password='password', team=marvel)
        batman = User.objects.create_user(username='batman', email='batman@dc.com', password='password', team=dc)
        superman = User.objects.create_user(username='superman', email='superman@dc.com', password='password', team=dc)

        # Create activities
        Activity.objects.create(user=ironman, type='run', duration=30, distance=5)
        Activity.objects.create(user=batman, type='cycle', duration=60, distance=20)

        # Create workouts
        Workout.objects.create(user=ironman, name='Chest Day', description='Bench press and pushups')
        Workout.objects.create(user=superman, name='Leg Day', description='Squats and lunges')

        # Create leaderboard
        Leaderboard.objects.create(user=ironman, points=100)
        Leaderboard.objects.create(user=batman, points=90)

        self.stdout.write(self.style.SUCCESS('octofit_db database populated with test data.'))
