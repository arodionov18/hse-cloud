from flask.cli import FlaskGroup

from project import app, db, ServiceStatus, StatusType
from flask import request
import click

cli = FlaskGroup(app)


@cli.command("create_db")
@click.option('--ip')
def create_db(ip):
    db.create_all()
    db.session.commit()
    db.session.add(ServiceStatus(ip=ip, status=StatusType.AVAILABLE))
    db.session.commit()

@cli.command("drop_db")
def create_db():
    db.drop_all()
    db.session.commit()


@cli.command("seed_db")
@click.option('--ip')
def seed_db(ip):
    db.session.add(ServiceStatus(ip=ip, status=StatusType.AVAILABLE))
    db.session.commit()


if __name__ == "__main__":
    cli()
