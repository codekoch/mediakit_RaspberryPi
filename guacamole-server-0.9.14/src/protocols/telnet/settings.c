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

#include "settings.h"

#include <guacamole/user.h>

#include <sys/types.h>
#include <regex.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* Client plugin arguments */
const char* GUAC_TELNET_CLIENT_ARGS[] = {
    "hostname",
    "port",
    "username",
    "username-regex",
    "password",
    "password-regex",
    "font-name",
    "font-size",
    "color-scheme",
    "typescript-path",
    "typescript-name",
    "create-typescript-path",
    "recording-path",
    "recording-name",
    "create-recording-path",
    "read-only",
    NULL
};

enum TELNET_ARGS_IDX {

    /**
     * The hostname to connect to. Required.
     */
    IDX_HOSTNAME,

    /**
     * The port to connect to. Optional.
     */
    IDX_PORT,

    /**
     * The name of the user to login as. Optional.
     */
    IDX_USERNAME,

    /**
     * The regular expression to use when searching for the username/login
     * prompt. Optional.
     */
    IDX_USERNAME_REGEX,

    /**
     * The password to use when logging in. Optional.
     */
    IDX_PASSWORD,

    /**
     * The regular expression to use when searching for the password prompt.
     * Optional.
     */
    IDX_PASSWORD_REGEX,

    /**
     * The name of the font to use within the terminal.
     */
    IDX_FONT_NAME,

    /**
     * The size of the font to use within the terminal, in points.
     */
    IDX_FONT_SIZE,

    /**
     * The name of the color scheme to use. Currently valid color schemes are:
     * "black-white", "white-black", "gray-black", and "green-black", each
     * following the "foreground-background" pattern. By default, this will be
     * "gray-black".
     */
    IDX_COLOR_SCHEME,

    /**
     * The full absolute path to the directory in which typescripts should be
     * written.
     */
    IDX_TYPESCRIPT_PATH,

    /**
     * The name that should be given to typescripts which are written in the
     * given path. Each typescript will consist of two files: "NAME" and
     * "NAME.timing".
     */
    IDX_TYPESCRIPT_NAME,

    /**
     * Whether the specified typescript path should automatically be created
     * if it does not yet exist.
     */
    IDX_CREATE_TYPESCRIPT_PATH,

    /**
     * The full absolute path to the directory in which screen recordings
     * should be written.
     */
    IDX_RECORDING_PATH,

    /**
     * The name that should be given to screen recordings which are written in
     * the given path.
     */
    IDX_RECORDING_NAME,

    /**
     * Whether the specified screen recording path should automatically be
     * created if it does not yet exist.
     */
    IDX_CREATE_RECORDING_PATH,

    /**
     * "true" if this connection should be read-only (user input should be
     * dropped), "false" or blank otherwise.
     */
    IDX_READ_ONLY,

    TELNET_ARGS_COUNT
};

/**
 * Compiles the given regular expression, returning NULL if compilation fails.
 * The returned regex_t must be freed with regfree() AND free().
 *
 * @param user
 *     The user who provided the setting associated with the given regex
 *     pattern. Error messages will be logged on behalf of this user.
 *
 * @param pattern
 *     The regular expression pattern to compile.
 *
 * @return
 *     The compiled regular expression, or NULL if compilation fails.
 */
static regex_t* guac_telnet_compile_regex(guac_user* user, char* pattern) {

    int compile_result;
    regex_t* regex = malloc(sizeof(regex_t));

    /* Compile regular expression */
    compile_result = regcomp(regex, pattern,
            REG_EXTENDED | REG_NOSUB | REG_ICASE | REG_NEWLINE);

    /* Notify of failure to parse/compile */
    if (compile_result != 0) {
        guac_user_log(user, GUAC_LOG_ERROR, "Regular expression '%s' "
                "could not be compiled.", pattern);
        free(regex);
        return NULL;
    }

    return regex;
}

guac_telnet_settings* guac_telnet_parse_args(guac_user* user,
        int argc, const char** argv) {

    /* Validate arg count */
    if (argc != TELNET_ARGS_COUNT) {
        guac_user_log(user, GUAC_LOG_WARNING, "Incorrect number of connection "
                "parameters provided: expected %i, got %i.",
                TELNET_ARGS_COUNT, argc);
        return NULL;
    }

    guac_telnet_settings* settings = calloc(1, sizeof(guac_telnet_settings));

    /* Read parameters */
    settings->hostname =
        guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_HOSTNAME, "");

    /* Read username */
    settings->username =
        guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_USERNAME, NULL);

    /* Read username regex only if password is specified */
    if (settings->username != NULL) {
        settings->username_regex = guac_telnet_compile_regex(user,
            guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                    IDX_USERNAME_REGEX, GUAC_TELNET_DEFAULT_USERNAME_REGEX));
    }

    /* Read password */
    settings->password =
        guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_PASSWORD, NULL);

    /* Read password regex only if password is specified */
    if (settings->password != NULL) {
        settings->password_regex = guac_telnet_compile_regex(user,
            guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                    IDX_PASSWORD_REGEX, GUAC_TELNET_DEFAULT_PASSWORD_REGEX));
    }

    /* Read-only mode */
    settings->read_only =
        guac_user_parse_args_boolean(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_READ_ONLY, false);

    /* Read font name */
    settings->font_name =
        guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_FONT_NAME, GUAC_TELNET_DEFAULT_FONT_NAME);

    /* Read font size */
    settings->font_size =
        guac_user_parse_args_int(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_FONT_SIZE, GUAC_TELNET_DEFAULT_FONT_SIZE);

    /* Copy requested color scheme */
    settings->color_scheme =
        guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_COLOR_SCHEME, "");

    /* Pull width/height/resolution directly from user */
    settings->width      = user->info.optimal_width;
    settings->height     = user->info.optimal_height;
    settings->resolution = user->info.optimal_resolution;

    /* Read port */
    settings->port =
        guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_PORT, GUAC_TELNET_DEFAULT_PORT);

    /* Read typescript path */
    settings->typescript_path =
        guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_TYPESCRIPT_PATH, NULL);

    /* Read typescript name */
    settings->typescript_name =
        guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_TYPESCRIPT_NAME, GUAC_TELNET_DEFAULT_TYPESCRIPT_NAME);

    /* Parse path creation flag */
    settings->create_typescript_path =
        guac_user_parse_args_boolean(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_CREATE_TYPESCRIPT_PATH, false);

    /* Read recording path */
    settings->recording_path =
        guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_RECORDING_PATH, NULL);

    /* Read recording name */
    settings->recording_name =
        guac_user_parse_args_string(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_RECORDING_NAME, GUAC_TELNET_DEFAULT_RECORDING_NAME);

    /* Parse path creation flag */
    settings->create_recording_path =
        guac_user_parse_args_boolean(user, GUAC_TELNET_CLIENT_ARGS, argv,
                IDX_CREATE_RECORDING_PATH, false);

    /* Parsing was successful */
    return settings;

}

void guac_telnet_settings_free(guac_telnet_settings* settings) {

    /* Free network connection information */
    free(settings->hostname);
    free(settings->port);

    /* Free credentials */
    free(settings->username);
    free(settings->password);

    /* Free username regex (if allocated) */
    if (settings->username_regex != NULL) {
        regfree(settings->username_regex);
        free(settings->username_regex);
    }

    /* Free password regex (if allocated) */
    if (settings->password_regex != NULL) {
        regfree(settings->password_regex);
        free(settings->password_regex);
    }

    /* Free display preferences */
    free(settings->font_name);
    free(settings->color_scheme);

    /* Free typescript settings */
    free(settings->typescript_name);
    free(settings->typescript_path);

    /* Free screen recording settings */
    free(settings->recording_name);
    free(settings->recording_path);

    /* Free overall structure */
    free(settings);

}

