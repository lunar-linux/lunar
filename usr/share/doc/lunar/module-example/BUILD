(

  if  module_installed  Linux-PAM;  then
    WITH_PAM="--with-pam"
  fi

set -x

  ./configure  --sysconfdir=/etc        \
               --prefix=/usr            \
               --mandir=/usr/share/man  \
               --localstatedir=/var     \
               --with-everything        \
               $WITH_PAM                \
               $OPTS                    &&

set +x

  make                              &&
  prepare_install                   &&
  make    install

) > $C_FIFO 2>&1  &&  (


  if    [  !  -f  /etc/ftplockout  ]
  then  cp  pam/ftplockout  /etc
  fi

  if  !  [  -e  /etc/init.d/pure-ftpd  ]; then
    cp  $SCRIPT_DIRECTORY/pure-ftpd  /etc/init.d
  fi

  case  $FTPD_BOOT  in
    y|Y)  chkconfig --add pure-ftpd
          ;;
          
      *)  true
          ;;
  esac

)
