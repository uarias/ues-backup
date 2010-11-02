#!/usr/bin/env perl
# fecha
$fecha = `date +%Y%m%d`;

# declaraciones
use File::Basename;
use Config::Simple;

# Archivo de configuración
my $config_file = $opt_c || "./backup.conf";
Config::Simple->import_from($config_file, \%bconf);
my $backup_folder = "ORIG.web";
my $backup_destino = "DEST.webbackup";

chdir($backup_folder) or die ("No puedo entrar en el directorio '$backup_folder'");


    print "Haciendo Backup de $backup_folder en $backup_destino...";
    `rsync -a  $backup_folder $backup_destino`;
    print "Comprimiendo..." ;
    `tar -jcvf $fecha.tar.bz2 $lugar_backup`;
    print "Listo\n";

}
