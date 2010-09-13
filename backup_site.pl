#!/usr/bin/env perl

# por huevos tiene que venir esto
$backup_folder = '/var/backup/sitio/';
$fecha = `date +%Y%m%d`;

#declaraciones
use File::Basename;
my $config_file = dirname($0) . "./backup.conf";
my @todos_lugares = quitarComentarios(getContenidoArchi($config_file));

chdir($backup_folder) or die ("No puedo entrar en el directorio '$backup_folder'");

foreach my $lugares_directorio (@todos_lugares) {
    my($carpeta, $lugar_backup) = split(/\s+/,$lugares_directorio);

    print "Haciendo Backup de $carpeta en $lugar_backup...";
    `rsync -a $carpeta $backup_folder/$lugar_backup`;
    print "Comprimiendo..." ;
    `tar -jcvf $fecha.tar.bz2 $lugar_backup`;
    print "Listo\n";
}

sub getContenidoArchi {
    my $archivo = shift;
    my @lineas;
    if(!open(FILE,$archivo)){
	die("No puedo abrir '$archivo': $!");
    }else{
	@lineas=<FILE>;
	close(FILE);
    }
    return @lineas;
}

sub quitarComentarios {
    my @lineas = @_;

    @limpio = grep(!/^\s*#/, @lineas); #quito comentarios
    @limpio = grep(!/^\s*$/, @limpio); #quito lineas vacías
    
    return @limpio;
}
