import logging
import random
import azure.functions as func


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    suits = [
        'Spades',
        'Clubs',
        'Hearts',
        'Diamonds'
    ]
    faces = [
        'Ace',
        'Two',
        'Three',
        'Four',
        'Five',
        'Six',
        'Seven',
        'Eight',
        'Nine',
        'Ten',
        'Jack',
        'Queen',
        'King'
    ]
    rand_suit = random.randrange(len(suits))
    rand_face = random.randrange(len(faces))
    return func.HttpResponse(
        f'{faces[rand_face]} of {suits[rand_suit]}',
        status_code=200
    )
