#!/bin/sh

# default storage class to standard if not provided
S3_STORAGE_CLASS=${S3_STORAGE_CLASS:-STANDARD}

# # generate file name for tar
# FILE_NAME=/tmp/$BACKUP_NAME-`date "+%Y-%m-%d_%H-%M-%S"`.tar.gz

# Check if TARGET variable is set
if [ -z ${TARGET} ];
then
    echo "TARGET env var is not set so we use the default value (/data)"
    TARGET=/data
else
    echo "TARGET env var is set"
fi

# echo "creating archive"
# tar -zchvf $FILE_NAME $TARGET
# echo "uploading archive to S3 [$FILE_NAME, storage class - $S3_STORAGE_CLASS]"
# aws s3 cp --storage-class $S3_STORAGE_CLASS $FILE_NAME $S3_BUCKET_URL
# echo "removing local archive"
# rm $FILE_NAME
# echo "done"

get_recent_file () {
    FILE=$(ls -Art1 ${TARGET} | tail -n 1)
    # if [ ! -f ${FILE} ]; then
    #     CURRENT_DIR="${TARGET}/${FILE}"
    #     get_recent_file
    # fi
    echo "${TARGET}/${FILE}"
    exit
}

FILE_NAME="$(get_recent_file)"

echo "creating archive"
echo "uploading archive to S3 [$FILE_NAME, storage class - $S3_STORAGE_CLASS]"
aws s3 cp --storage-class $S3_STORAGE_CLASS $FILE_NAME $S3_BUCKET_URL