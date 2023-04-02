import os
import json
import urllib.parse
import boto3

print('Loading function')

s3 = boto3.client('s3')
batch = boto3.client('batch')


def lambda_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))

    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    try:
        response = s3.get_object(Bucket=bucket, Key=key)
        print("CONTENT TYPE: " + response['ContentType'])

        # create custom file from response
        config_yaml_str = {
            "param": 0
        }

        # We don't care about the content here since this is just a proof-of-concept.
        fname, _ = os.path.splitext(os.path.basename(key))
        analyzer_job = batch.submit_job(
            jobName=f"job_{fname}",
            jobQueue=os.environ.get("job_queue"),
            jobDefinition=os.environ.get("job_def"),
            parameters={
                'config': json.dumps(config_yaml_str)
            },
        )

        return analyzer_job
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.'.format(key, bucket))
        raise e
