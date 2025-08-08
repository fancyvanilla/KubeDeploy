import os
import json
import subprocess

def parse_vars(file_path, destination_file):
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"The file {file_path} does not exist.")
    with open(file_path, 'r') as file:
        content = file.read()
        content = json.loads(content)
        ip_address = content.get('ip_address', None)
        ssh_port = content.get('ssh_port', None)
        worker_count = content.get('worker_count', None)
        if ip_address is None or ssh_port is None or worker_count is None:
            raise ValueError("The required keys 'ip_address', 'ssh_port', or 'worker_count' are missing in the file.")
        with open(destination_file, 'w') as dest_file:
                dest_file.write("[masters]\n")
                dest_file.write(f"master ansible_host={ip_address} ansible_port={ssh_port} ansible_user=ubuntu\n")
                dest_file.write("[workers]\n")
                for i in range(worker_count):
                    dest_file.write(f"worker{i+1} ansible_host={ip_address} ansible_port={ssh_port} ansible_user=ubuntu\n")



if __name__ == "__main__":
     path=os.path.dirname(os.path.abspath(__file__))
     file_path = os.path.join(path, './terraform/modules/network/vars.json')
     destination_file = os.path.join(path, './ansible/inventory.ini')
     playbook_path = os.path.join(path, './ansible/deploy_k8s_v2.yaml')
     terraform_path = os.path.join(path, './terraform')
     subprocess.run(["terraform", "init"], check=True, cwd=terraform_path)
     subprocess.run(["terraform", "apply", "-auto-approve"], check=True, cwd=terraform_path)
     try:
         parse_vars(file_path, destination_file)
         print(f"Inventory file created at {destination_file}")
         subprocess.run(["ansible-playbook", "-i", destination_file, playbook_path, "--ask-vault-pass"], check=True)
     except Exception as e:
         print(f"Error occurred: {e}")
