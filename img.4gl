IMPORT os
MAIN
  OPEN FORM f FROM "img"
  DISPLAY FORM f
  CALL copyToTmp("bart.png")
  CALL copyToTmp("homer.png")
  CALL copyToTmp("marge.png")
  DISPLAY getUrl("bart.png") TO img
  MENU
    ON ACTION homer
      DISPLAY getUrl("homer.png") TO img
    ON ACTION marge
      DISPLAY getUrl("marge.png") TO img
    ON ACTION showenv ATTRIBUTE(TEXT = "Show FGL env")
      ERROR "FGL_PUBLIC_DIR:",
        fgl_getenv("FGL_PUBLIC_DIR"),
        ",\nFGL_PUBLIC_URL_PREFIX:",
        fgl_getenv("FGL_PUBLIC_URL_PREFIX"),
        ",\nFGL_PUBLIC_IMAGE_PATH:",
        fgl_getenv("FGL_PUBLIC_IMAGEPATH"),
        ",\npwd:",
        os.Path.pwd(),
        ",\nFGL_PRIVATE_DIR:",
        fgl_getenv("FGL_PRIVATE_DIR")
    COMMAND "Exit"
      EXIT MENU
  END MENU
END MAIN

FUNCTION getTmpDir()
  DEFINE tmp STRING
  IF fgl_getenv("WINDIR") IS NOT NULL THEN
    LET tmp=fgl_getenv("TEMP")
  ELSE
    LET tmp="/tmp"
  END IF
  RETURN tmp
END FUNCTION

FUNCTION copyToTmp(fname STRING)
  DEFINE tmp STRING
  LET tmp=getTmpDir()
  IF NOT os.Path.copy(fname, os.Path.join(tmp,fname))  THEN
    CALL myerr(sfmt("Can't copy '%1' to '%2'",fname,os.Path.join(tmp,fname)))
  END IF
END FUNCTION

FUNCTION getUrl(fname STRING)
  DEFINE tmp,tmpname,url STRING
  LET tmp=getTmpDir()
  LET tmpname = os.Path.join(tmp,fname)
  LET url=ui.Interface.filenameToURI(tmpname)
  DISPLAY url TO url
  RETURN url
END FUNCTION

FUNCTION myerr(errstr STRING)
  DEFINE ch base.Channel
  LET ch = base.Channel.create()
  CALL ch.openFile("<stderr>", "w")
  CALL ch.writeLine(SFMT("ERROR:%1", errstr))
  CALL ch.close()
  EXIT PROGRAM 1
END FUNCTION

