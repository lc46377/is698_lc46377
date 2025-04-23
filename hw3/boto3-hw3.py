import boto3
from botocore.exceptions import ClientError
import time


def list_s3_objects(bucket_name):
    s3 = boto3.client('s3')
    resp = s3.list_objects_v2(Bucket=bucket_name)
    contents = resp.get('Contents', [])
    if not contents:
        print(f"No objects found in bucket '{bucket_name}'.")
    else:
        print(f"Objects in bucket '{bucket_name}':")
        for obj in contents:
            print(f"  • {obj['Key']} (Size: {obj['Size']} bytes)")


def create_dynamodb_table(table_name):
    dynamodb = boto3.resource('dynamodb')
    try:
        table = dynamodb.create_table(
            TableName=table_name,
            KeySchema=[
                {'AttributeName': 'pk', 'KeyType': 'HASH'},   
                {'AttributeName': 'sk', 'KeyType': 'RANGE'}   
            ],
            AttributeDefinitions=[
                {'AttributeName': 'pk', 'AttributeType': 'S'},
                {'AttributeName': 'sk', 'AttributeType': 'S'}
            ],
            ProvisionedThroughput={
                'ReadCapacityUnits': 5,
                'WriteCapacityUnits': 5
            }
        )
        print(f"Creating table '{table_name}'...")
        table.wait_until_exists()
        print(f"Table '{table_name}' created.")
    except ClientError as e:
        code = e.response['Error']['Code']
        if code == 'ResourceInUseException':
            table = dynamodb.Table(table_name)
            print(f"Table '{table_name}' already exists; reusing it.")
        else:
            raise
    return table


def insert_item(table, pk_value, sk_value, extra_attrs):
    try:
        item = {'pk': pk_value, 'sk': sk_value}
        item.update(extra_attrs)
        table.put_item(Item=item)
        print(f"Inserted item (pk='{pk_value}', sk='{sk_value}').")
    except ClientError as e:
        print("Error inserting item:", e.response['Error']['Message'])


if __name__ == "__main__":
    S3_BUCKET = "lc46377-hw3"
    DDB_TABLE = "lc46377-hw3-table"

    list_s3_objects(S3_BUCKET)

    table = create_dynamodb_table(DDB_TABLE)

    sample_data = {
        "attribute1": "hello",
        "attribute2": 123
    }
    insert_item(table, pk_value="user#1",
                sk_value="metadata", extra_attrs=sample_data)
