<table>
<tbody>
<tr class="odd">
<td><img src="warning.png" alt="Tip" /></td>
<td align="right">This package is under development. It has not yet been exhaustively tested for all calls neither. Usage may also still change. If you have suggestions please use the issue tracker.</td>
</tr>
</tbody>
</table>

Connection
==========

Within RStudio an Addin is available: HIDAP database which builds a
form.

Alternatively, you can use the command line as below.

    # R >= 3.2.4

    # installation
    install.packages("devtools")
    devtools::install_github("c5sire/brapi")

    # connect
    # dburl without leading 'http://' but add any firewall (for example: 'usr:pwd@some-db.org')
    # the function now creates a new object in the environment 'brapi'
    crop = ""
    dburl = "usr:pwd@some-db.org"
    user = ""
    password = ""
    brapi::brapi_con(crop, dburl, 80, user, password) 

    # you can reconnect/refresh a session with login credentials using:
    #brapi::brapi_auth(user, password)

    # consultation: 'working' calls;
    programs = brapi::program_list()
    programs

    studies = brapi::studies()
    studies

    locations = brapi::location_list()
    locations

    # Number is a studyId from the database; see 'studies'
    id = studies$studyDbId[6] 
    study_info = brapi::study_details(id)
    study_info


    fieldbook = brapi::study_table(id)
    fieldbook[1:10, 1:6]
