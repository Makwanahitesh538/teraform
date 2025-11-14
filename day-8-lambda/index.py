def handler(event, context):
    print(" Hello from Lambda — deployed using Terraform!")
    return {"message": "Lambda executed successfully!"}
