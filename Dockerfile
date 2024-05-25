FROM python:3.10

# Set the working directory inside the container to /code
WORKDIR /code

# Copy the requirements.txt file from the host to /code/ in the container
COPY ./requirements.txt /code/requirements.txt

# Install the required Python packages using the requirements.txt file
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Copy the entire app directory from the host to /code/app/ in the container
COPY ./app /code/app

# Set the working directory inside the container to /code/app
WORKDIR /code/app

# Command to run the FastAPI app using Uvicorn, specifying the app location and host/port configuration
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
