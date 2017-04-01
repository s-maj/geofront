AWS ECS is somehow neglected these days but it's still a good solution for webapps or other stateless applications:
  
Cool features of AWS ECS:
* Per container IAM role/policies (safe integration with AWS ecosystem)
* ECS can automatically register/deregister containers in designated ALB (no need for service discovery)
* Auto scaling both EC2 instances and ECS containers using metrics from Cloudwatch
* Automatically drain containers on cluster shrink  
* Availability zones aware scheduler 