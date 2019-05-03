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

#ifndef GUAC_TELNET_SETTINGS_H
#define GUAC_TELNET_SETTINGS_H

#include "config.h"

#include <guacamole/user.h>

#include <sys/types.h>
#include <regex.h>
#include <stdbool.h>

/**
 * The name of the font to use for the terminal if no name is specified.
 */
#define GUAC_TELNET_DEFAULT_FONT_NAME "monospace" 

/**
 * The size of the font to use for the terminal if no font size is specified,
 * in points.
 */
#define GUAC_TELNET_DEFAULT_FONT_SIZE 12

/**
 * The port to connect to when initiating any telnet connection, if no other
 * port is specified.
 */
#define GUAC_TELNET_DEFAULT_PORT "23"

/**
 * The filename to use for the typescript, if not specified.
 */
#define GUAC_TELNET_DEFAULT_TYPESCRIPT_NAME "typescript" 

/**
 * The filename to use for the screen recording, if not specified.
 */
#define GUAC_TELNET_DEFAULT_RECORDING_NAME "recording"

/**
 * The regular expression to use when searching for the username/login prompt
 * if no other regular expression is specified.
 */
#define GUAC_TELNET_DEFAULT_USERNAME_REGEX "[Ll]ogin:"

/**
 * The regular expression to use when searching for the password prompt if no
 * other regular expression is specified.
 */
#define GUAC_TELNET_DEFAULT_PASSWORD_REGEX "[Pp]assword:"

/**
 * Settings for the telnet connection. The values for this structure are parsed
 * from the arguments given during the Guacamole protocol handshake using the
 * guac_telnet_parse_args() function.
 */
typedef struct guac_telnet_settings {

    /**
     * The hostname of the telnet server to connect to.
     */
    char* hostname;

    /**
     * The port of the telnet server to connect to.
     */
    char* port;

    /**
     * The name of the user to login as, if any. If no username is specified,
     * this will be NULL.
     */
    char* username;

    /**
     * The regular expression to use when searching for the username/login
     * prompt. If no username is specified, this will be NULL. If a username
     * is specified, this will either be the specified username regex, or the
     * default username regex.
     */
    regex_t* username_regex;

    /**
     * The password to give when authenticating, if any. If no password is
     * specified, this will be NULL.
     */
    char* password;

    /**
     * The regular expression to use when searching for the password prompt. If
     * no password is specified, this will be NULL. If a password is specified,
     * this will either be the specified password regex, or the default
     * password regex.
     */
    regex_t* password_regex;

    /**
     * Whether this connection is read-only, and user input should be dropped.
     */
    bool read_only;

    /**
     * The name of the font to use for display rendering.
     */
    char* font_name;

    /**
     * The size of the font to use, in points.
     */
    int font_size;

    /**
     * The name of the color scheme to use.
     */
    char* color_scheme; 

    /**
     * The desired width of the terminal display, in pixels.
     */
    int width;

    /**
     * The desired height of the terminal display, in pixels.
     */
    int height;

    /**
     * The desired screen resolution, in DPI.
     */
    int resolution;

    /**
     * The path in which the typescript should be saved, if enabled. If no
     * typescript should be saved, this will be NULL.
     */
    char* typescript_path;

    /**
     * The filename to use for the typescript, if enabled.
     */
    char* typescript_name;

    /**
     * Whether the typescript path should be automatically created if it does
     * not already exist.
     */
    bool create_typescript_path;

    /**
     * The path in which the screen recording should be saved, if enabled. If
     * no screen recording should be saved, this will be NULL.
     */
    char* recording_path;

    /**
     * The filename to use for the screen recording, if enabled.
     */
    char* recording_name;

    /**
     * Whether the screen recording path should be automatically created if it
     * does not already exist.
     */
    bool create_recording_path;

} guac_telnet_settings;

/**
 * Parses all given args, storing them in a newly-allocated settings object. If
 * the args fail to parse, NULL is returned.
 *
 * @param user
 *     The user who submitted the given arguments while joining the
 *     connection.
 *
 * @param argc
 *     The number of arguments within the argv array.
 *
 * @param argv
 *     The values of all arguments provided by the user.
 *
 * @return
 *     A newly-allocated settings object which must be freed with
 *     guac_telnet_settings_free() when no longer needed. If the arguments fail
 *     to parse, NULL is returned.
 */
guac_telnet_settings* guac_telnet_parse_args(guac_user* user,
        int argc, const char** argv);

/**
 * Frees the given guac_telnet_settings object, having been previously
 * allocated via guac_telnet_parse_args().
 *
 * @param settings
 *     The settings object to free.
 */
void guac_telnet_settings_free(guac_telnet_settings* settings);

/**
 * NULL-terminated array of accepted client args.
 */
extern const char* GUAC_TELNET_CLIENT_ARGS[];

#endif

