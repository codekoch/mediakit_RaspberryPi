/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

#include "config.h"

#include "rdpdr_messages.h"
#include "rdpdr_service.h"
#include "rdp_fs.h"
#include "rdp_status.h"

#include <freerdp/utils/svc_plugin.h>

#ifdef ENABLE_WINPR
#include <winpr/stream.h>
#include <winpr/wtypes.h>
#else
#include "compat/winpr-stream.h"
#include "compat/winpr-wtypes.h"
#endif

void guac_rdpdr_fs_process_query_volume_info(guac_rdpdr_device* device,
        wStream* input_stream, int file_id, int completion_id) {

    wStream* output_stream = guac_rdpdr_new_io_completion(device,
            completion_id, STATUS_SUCCESS, 21 + GUAC_FILESYSTEM_LABEL_LENGTH);

    guac_client_log(device->rdpdr->client, GUAC_LOG_DEBUG,
            "%s: [file_id=%i]",
            __func__, file_id);

    Stream_Write_UINT32(output_stream, 17 + GUAC_FILESYSTEM_LABEL_LENGTH);
    Stream_Write_UINT64(output_stream, 0); /* VolumeCreationTime */
    Stream_Write_UINT32(output_stream, 0); /* VolumeSerialNumber */
    Stream_Write_UINT32(output_stream, GUAC_FILESYSTEM_LABEL_LENGTH);
    Stream_Write_UINT8(output_stream, FALSE); /* SupportsObjects */
    /* Reserved field must not be sent */
    Stream_Write(output_stream, GUAC_FILESYSTEM_LABEL, GUAC_FILESYSTEM_LABEL_LENGTH);

    svc_plugin_send((rdpSvcPlugin*) device->rdpdr, output_stream);

}

void guac_rdpdr_fs_process_query_size_info(guac_rdpdr_device* device, wStream* input_stream,
        int file_id, int completion_id) {

    guac_rdp_fs_info info = {0};
    guac_rdp_fs_get_info((guac_rdp_fs*) device->data, &info);

    wStream* output_stream = guac_rdpdr_new_io_completion(device,
            completion_id, STATUS_SUCCESS, 28);

    guac_client_log(device->rdpdr->client, GUAC_LOG_DEBUG,
            "%s: [file_id=%i]",
            __func__, file_id);

    Stream_Write_UINT32(output_stream, 24);
    Stream_Write_UINT64(output_stream, info.blocks_total);     /* TotalAllocationUnits */
    Stream_Write_UINT64(output_stream, info.blocks_available); /* AvailableAllocationUnits */
    Stream_Write_UINT32(output_stream, 1);                     /* SectorsPerAllocationUnit */
    Stream_Write_UINT32(output_stream, info.block_size);       /* BytesPerSector */

    svc_plugin_send((rdpSvcPlugin*) device->rdpdr, output_stream);

}

void guac_rdpdr_fs_process_query_device_info(guac_rdpdr_device* device, wStream* input_stream,
        int file_id, int completion_id) {

    wStream* output_stream = guac_rdpdr_new_io_completion(device,
            completion_id, STATUS_SUCCESS, 12);

    guac_client_log(device->rdpdr->client, GUAC_LOG_DEBUG,
            "%s: [file_id=%i]",
            __func__, file_id);

    Stream_Write_UINT32(output_stream, 8);
    Stream_Write_UINT32(output_stream, FILE_DEVICE_DISK); /* DeviceType */
    Stream_Write_UINT32(output_stream, 0); /* Characteristics */

    svc_plugin_send((rdpSvcPlugin*) device->rdpdr, output_stream);

}

void guac_rdpdr_fs_process_query_attribute_info(guac_rdpdr_device* device, wStream* input_stream,
        int file_id, int completion_id) {

    wStream* output_stream = guac_rdpdr_new_io_completion(device,
            completion_id, STATUS_SUCCESS, 16 + GUAC_FILESYSTEM_NAME_LENGTH);

    guac_client_log(device->rdpdr->client, GUAC_LOG_DEBUG,
            "%s: [file_id=%i]",
            __func__, file_id);

    Stream_Write_UINT32(output_stream, 12 + GUAC_FILESYSTEM_NAME_LENGTH);
    Stream_Write_UINT32(output_stream,
              FILE_UNICODE_ON_DISK
            | FILE_CASE_SENSITIVE_SEARCH
            | FILE_CASE_PRESERVED_NAMES); /* FileSystemAttributes */
    Stream_Write_UINT32(output_stream, GUAC_RDP_FS_MAX_PATH ); /* MaximumComponentNameLength */
    Stream_Write_UINT32(output_stream, GUAC_FILESYSTEM_NAME_LENGTH);
    Stream_Write(output_stream, GUAC_FILESYSTEM_NAME,
            GUAC_FILESYSTEM_NAME_LENGTH);

    svc_plugin_send((rdpSvcPlugin*) device->rdpdr, output_stream);

}

void guac_rdpdr_fs_process_query_full_size_info(guac_rdpdr_device* device, wStream* input_stream,
        int file_id, int completion_id) {

    guac_rdp_fs_info info = {0};
    guac_rdp_fs_get_info((guac_rdp_fs*) device->data, &info);

    wStream* output_stream = guac_rdpdr_new_io_completion(device,
            completion_id, STATUS_SUCCESS, 36);

    guac_client_log(device->rdpdr->client, GUAC_LOG_DEBUG,
            "%s: [file_id=%i]",
            __func__, file_id);

    Stream_Write_UINT32(output_stream, 32);
    Stream_Write_UINT64(output_stream, info.blocks_total);     /* TotalAllocationUnits */
    Stream_Write_UINT64(output_stream, info.blocks_available); /* CallerAvailableAllocationUnits */
    Stream_Write_UINT64(output_stream, info.blocks_available); /* ActualAvailableAllocationUnits */
    Stream_Write_UINT32(output_stream, 1);                     /* SectorsPerAllocationUnit */
    Stream_Write_UINT32(output_stream, info.block_size);       /* BytesPerSector */

    svc_plugin_send((rdpSvcPlugin*) device->rdpdr, output_stream);

}

