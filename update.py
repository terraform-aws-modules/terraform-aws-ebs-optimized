import boto3
from typing import Dict

EC2_CLIENT = boto3.client("ec2", region_name="us-east-1")


def get_instances(ebs_support: str) -> Dict[str, str]:
    """Get instance types by their `ebs_support` type"""
    results = {}
    paginator = EC2_CLIENT.get_paginator("describe_instance_types")
    resp_itr = paginator.paginate(
        Filters=[{"Name": "ebs-info.ebs-optimized-support", "Values": [ebs_support]}],
    )

    _type = "false" if ebs_support == "unsupported" else "true"
    for instances in resp_itr:
        for inst in instances.get("InstanceTypes"):
            results[inst["InstanceType"]] = _type
    return results


def update_instances():
    """Update `main.tf` with instance types and their EBS support designation"""
    results = {}
    for ebs_support in {"supported", "default", "unsupported"}:
        results.update(get_instances(ebs_support=ebs_support))

    with open("main.tf", "w") as wfile:
        wfile.writelines("locals {\n  ebs_optimized = {\n")
        for k, v in sorted(results.items()):
            wfile.writelines(f'    "{k}" = {v}\n')
        wfile.writelines("  }\n}")


if __name__ == "__main__":
    update_instances()
