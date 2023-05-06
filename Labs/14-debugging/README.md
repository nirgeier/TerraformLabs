# Debugging

### 01. Adding validation to variables

- Under **`validation`**, you can specify two parameters within the curly braces:
  - A **`condition`** that accepts a `bool` it will calculate, which will signify if the validation passes.
  - An **`error_message`** that specifies the error message in case the validation does not pass.

  #### Validation sample:

  ```hcl
  # We wish to use only small vms of series t
  variable "instance_type" {
    description = "Instance type t2.micro"
    type        = string

    # Assign invalid value to this variable
    default     = "e2.medium"
  
    validation {
      # Set the desired condition
      condition     = can(regex("^[Tt][2-3].(nano|micro|small)", var.instance_type))

      # Set the displayed error message if the value is not valid
      error_message = "Invalid Instance Type name. You can only choose - t2.nano,t2.micro,t2.small"
    }
  }

  resource "aws_instance" "ec2_example" {
  
    ami           = "ami-0767046d1677be5a0"
    instance_type =  var.instance_type
    
  }
  ``` 
### 02. Setting up env variables for debugging

#### `TF_LOG`
  - Set log level with `TF_LOG`
  - The environment variable `TF_LOG` defines the log level. 

    ```sh
    # Set the desired debug level
    export TF_LOG="DEBUG"

    # Disable the debugger when done
    unset TF_LOG
    ```

  - Valid log levels are (in order of decreasing verbosity): 
    - `TRACE`
        - One of the most descriptive log levels, if you set the log level to `TRACE`, Terraform will write **every action** and step into the log file
    - `DEBUG`
      - Print out what happens internally in a more concise way compared to `TRACE`.
    - `INFO`
      - Print out general, high-level messages about the execution process.
    - `WARN`
      - Print out warnings, which may indicate misconfiguration or mistakes, **but are not critical to execution**.
    - `ERROR`
      - Print out errors that prevent Terraform from continuing.



#### `TF_LOG_PATH`
- Append the log with the Terraform output every time you run a Terraform command
  ```sh
  export TF_LOG_PATH="tmp/chegg_terraform.log"
  ```