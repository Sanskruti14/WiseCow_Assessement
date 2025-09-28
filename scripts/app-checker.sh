
#!/bin/bash

# URL of your Wisecow app (change if needed)
APP_URL="https://wisecow.local/"


 # Check application HTTP status code to see if it's up
 HTTP_STATUS=$(curl --insecure -s -o /dev/null -w "%{http_code}" ${APP_URL})


if [[ -z "${HTTP_STATUS}" ]]; then
    echo "Application is DOWN (Could not get status code)"
elif [ ${HTTP_STATUS} -eq 200 ]; then
    echo "Application is UP (Status code: ${HTTP_STATUS})"
elif [ ${HTTP_STATUS} -eq 502 ]; then
    echo "Nginx isue (Status code: ${HTTP_STATUS})"
else
    echo "Application is DOWN (Status code: ${HTTP_STATUS})"

fi
