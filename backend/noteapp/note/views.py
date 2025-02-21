from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import NoteSerializer
from .models import Note

# Create your views here.
@api_view (['GET'])
def getRoute(request):
    routes = [
        {
            'endpoint' : '/note/',
            'method' : 'GET',
            'body' : None,
            'des' : 'Returns an array of notes'
        },
        {
            'Endpoint' : '/note/id',
            'method' :'GET',
            'body' : None,
            'des' : 'Returns a single note object'
        },
        {
            'Endpoint' : '/note/create/',
            'method'  :'POST',
            'body' : {'body' : " "},
            'des' : 'creates new notes'
        },
        {
            'ENdpoint' : '/note/id/update',
            'method' : 'PUT',
            'body' : {'body' : ""},
            'des' : 'Updates existing note'
        },
        {
            'Endpoint' : '/note/id/delete/',
            'method' : 'DELETE',
            'body' : None,
            'des' : 'Delete existing note'
        }
    ]
    return Response(routes)

@api_view(['GET'])
def getNotes(request):
    notes = Note.objects.all()
    serializer = NoteSerializer(notes, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getNote(request , pk):
    note = Note.objects.get(id =pk)
    serializer = NoteSerializer(note , many=False)
    return Response(serializer.data)

@api_view(['POST'])
def createNote(request):
    data = request.data

    note  = Note.objects.create(
        body = data['body']
    )

    serializer = NoteSerializer(note , many=False)

    return Response(serializer.data)

@api_view(['PUT'])
def updateNote(request , pk):
    data = request.data
    note  = Note.objects.get(id = pk)

    serializer = NoteSerializer(note , data=request.data)
    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)

@api_view(['DELETE'])
def deleteNote(request , pk):
    note = Note.objects.get(id =pk)
    note.delete()
    return Response('Note was deleted')