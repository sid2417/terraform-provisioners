resource "aws_instance" "expense_provisioner" {
    ami = "ami-041e2ea9402c46c32"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-0d945c5ec2a256613"]
    tags = {
      Name = "Expense"
      module = "Expense"
      terraform =  "True"
      
    }

   # provisioners will run when you are creating resources
   # They will not run once the resources are created


    provisioner "local-exec" {
      command = "echo ${self.private_ip} > private_ips.txt"  
      # Here self means (aws_instance.web)
      # here we keep only this (>) Not append like (>>)
    }

    # provisioner "local-exec" {
    #     command = "anisible-playbook -i private_ips.txt web.yaml"
      
    # }

    connection {
      type = "ssh"
      user = "ec2-user"
      password = "DevOps321"
      host = self.public_ip
      
    }


    provisioner "remote-exec" {
      inline = [ 
        "sudo dnf install ansible -y",
        "sudo dnf install nginx -y",
        "sudo systemctl start nginx"
       ]
      
    }


}