from urllib.parse import urlencode

import firebase_admin
from firebase_admin import auth
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build

firebase_admin.initialize_app()

def create_service(member, oauth_access_token,
                   token_uri, client_id, client_secret, scopes):
    '''
    Create a service object
    '''
    creds = None
    service = None
    creds = Credentials(token=oauth_access_token,
                        token_uri=token_uri,
                        client_id=client_id,
                        client_secret=client_secret,
                        scopes=scopes)

    if creds and not creds.valid and creds.expired and creds.refresh_token:
        creds.refresh(Request())

    if creds and creds.valid:
        service = build('cloudidentity', 'v1', credentials=creds)
    else:
        print(f'No Creds available for user {member}.')

    return service


def check_transitive_membership(service, parent, member):
    '''
    Checks if member is authorized member of the group
    '''
    response = None
    try:
        query_params = urlencode({"query": "member_key_id == '{}'".format(member)})
        if service:
            request = service.groups().memberships().checkTransitiveMembership(parent=parent)
            request.uri += "&" + query_params
            response = request.execute()

    except Exception as error:
        print(f"{member} is not authorized member of the group: {error}")

    return response


def lambda_handler(event, context):
    '''
    This function check whether member is authrized to use APIs or not

    Parameters:
        event: contains data for a Lambda function to process
        context: methods and properties that provide information about the
        invocation, function, and execution environment
    Environment Variables:
        Token_uri, client_id, client_secret, scopes, group
    '''

    aws_request_id = context.aws_request_id
    effect = 'deny'

    auth_info = event["headers"]
    auth_token = auth_info['Authorization']
    oauth_access_token = auth_info['oauthaccesstoken']

    user = None

    try:
        token_id = auth_token
        decoded_token = auth.verify_id_token(token_id)
        user = decoded_token['name']
        email = decoded_token['email']

        response = check_transitive_membership(create_service(email, oauth_access_token, token_uri, client_id, client_secret, [scopes]), ('groups/'+group), email)

        if response:
            if 'hasMembership' in response and response['hasMembership']:
                effect = 'allow'
        else:
            effect = 'deny'

        # Validate user and Construct the response
        response = {
            "principalId": email,
            "policyDocument":
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Action": "execute-api:Invoke",
                            "Resource": event['methodArn'],
                            "Effect": effect
                        }
                    ]
                },
            "context":{
                "user": user
            }
        }

    except Exception as error:
        print(json.dumps({
            'RequestId': aws_request_id,
            'error': str(error)
        }))

        response = {
            "principalId": "Unauthorized_user",
            "policyDocument":
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Action": "execute-api:Invoke",
                            "Resource": event['methodArn'],
                            "Effect": 'deny'
                        }
                    ]
                }
        }

    return response