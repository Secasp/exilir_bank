
variable "prod_key" {}

variable "prod_secret" {}

variable "key"{

    default = "prod"
    type	= "string"
}

variable "prod_region"{

    default = "us-east-1"
    type	= "string"
}

variable "ami"{
	
	default="ami-e191f99e"
	type="string"

}


variable "subnet"{
	
	default="subnet-524a860e"
	type="string"

}





