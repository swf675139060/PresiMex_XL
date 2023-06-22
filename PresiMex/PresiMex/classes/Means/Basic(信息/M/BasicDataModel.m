//
//  BasicDataModel.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/19.
//

#import "BasicDataModel.h"
@implementation BasicData

-(void)initData{
    self.Género = @[
        [BasicDataModel createWithTitle:@"Hombre" ID:1],
        [BasicDataModel createWithTitle:@"Mujer" ID:2]
    ];
    self.EstadoCivil = @[
        [BasicDataModel createWithTitle:@"Soltero/a" ID:1],
        [BasicDataModel createWithTitle:@"Casado/a sin Hijos" ID:2],
        [BasicDataModel createWithTitle:@"Casado/a con Hijos" ID:3],
        [BasicDataModel createWithTitle:@"Divorciado/a o Viudo/a" ID:4]
    ];
    self.NumeroDeNiños = @[
        [BasicDataModel createWithTitle:@"0" ID:0],
        [BasicDataModel createWithTitle:@"1" ID:1],
        [BasicDataModel createWithTitle:@"2" ID:2],
        [BasicDataModel createWithTitle:@"3+" ID:3]
    ];
    self.AntecedenteEducacionales = @[
        [BasicDataModel createWithTitle:@"Primaria" ID:1],
        [BasicDataModel createWithTitle:@"Secundaria" ID:2],
        [BasicDataModel createWithTitle:@"Escuela secundaria" ID:3],
        [BasicDataModel createWithTitle:@"Preparatoria" ID:4],
        [BasicDataModel createWithTitle:@"Licenciatura" ID:5],
        [BasicDataModel createWithTitle:@"Posgrado" ID:6],
        [BasicDataModel createWithTitle:@"Doctorado" ID:7],
        [BasicDataModel createWithTitle:@"Otros" ID:0]
    ];
    self.EstadoDeTrabajo = @[
        [BasicDataModel createWithTitle:@"Tiempo completo" ID:1],
        [BasicDataModel createWithTitle:@"Tiempo parcial" ID:2],
        [BasicDataModel createWithTitle:@"Autónomos" ID:3],
        [BasicDataModel createWithTitle:@"Estudiante" ID:4],
        [BasicDataModel createWithTitle:@"Jubilado" ID:5],
        [BasicDataModel createWithTitle:@"Desempleados" ID:6]
    ];
    self.Industria = @[
        [BasicDataModel createWithTitle:@"Ventas por catálogo" ID:1],
        [BasicDataModel createWithTitle:@"Conductor/Taxi" ID:2],
        [BasicDataModel createWithTitle:@"Gobierno" ID:3],
        [BasicDataModel createWithTitle:@"Comerciante" ID:4],
        [BasicDataModel createWithTitle:@"Construcción" ID:5],
        [BasicDataModel createWithTitle:@"Finanzas" ID:6],
        [BasicDataModel createWithTitle:@"Fabricación" ID:7],
        [BasicDataModel createWithTitle:@"Servicios" ID:8],
        [BasicDataModel createWithTitle:@"Seguridad pública y privada" ID:9],
        [BasicDataModel createWithTitle:@"Transporte" ID:10],
        [BasicDataModel createWithTitle:@"Turismo" ID:11],
        [BasicDataModel createWithTitle:@"Venta de Autos" ID:12],
        [BasicDataModel createWithTitle:@"Venta de inmuebles" ID:13],
        [BasicDataModel createWithTitle:@"Bancario/Financiero" ID:14],
        [BasicDataModel createWithTitle:@"Fondo fiduciario" ID:15],
        [BasicDataModel createWithTitle:@"Fundaciones sin fines de lucro" ID:16],
        [BasicDataModel createWithTitle:@"Bases de ganancias" ID:17],
        [BasicDataModel createWithTitle:@"Organizaciones paraestatales" ID:18],
        [BasicDataModel createWithTitle:@"Organismos Descentralizados" ID:19],
        [BasicDataModel createWithTitle:@"Organismos Públicos Autónomos" ID:20],
        [BasicDataModel createWithTitle:@"Organizaciones de Seguridad Pública o Privada" ID:21],
        [BasicDataModel createWithTitle:@"Organizaciones Políticas" ID:22],
        [BasicDataModel createWithTitle:@"Organizaciones religiosas/de culto" ID:23],
        [BasicDataModel createWithTitle:@"Comunicación" ID:24]
    ];
    self.IngresoMensual = @[
        [BasicDataModel createWithTitle:@"menos a $1000" ID:1],
        [BasicDataModel createWithTitle:@"$1000 - $3000" ID:2],
        [BasicDataModel createWithTitle:@"$3000 - $5000" ID:3],
        [BasicDataModel createWithTitle:@"$5000 - $10000" ID:4],
        [BasicDataModel createWithTitle:@"$10000 - $20000" ID:5],
        [BasicDataModel createWithTitle:@"más de 20000" ID:6]
    ];
    
    self.TipoDeSalario = @[
        [BasicDataModel createWithTitle:@"Salario semanal" ID:1],
        [BasicDataModel createWithTitle:@"Salario semimensual" ID:2],
        [BasicDataModel createWithTitle:@"Salario mensual" ID:3],
        [BasicDataModel createWithTitle:@"Salario diario" ID:4],
        [BasicDataModel createWithTitle:@"Otro" ID:5]
    ];
    
    self.DíaDePago1 = @[
        [BasicDataModel createWithTitle:@"1" ID:1],
        [BasicDataModel createWithTitle:@"2" ID:2],
        [BasicDataModel createWithTitle:@"3" ID:3],
        [BasicDataModel createWithTitle:@"4" ID:4],
        [BasicDataModel createWithTitle:@"5" ID:5],
        [BasicDataModel createWithTitle:@"6" ID:6],
        [BasicDataModel createWithTitle:@"7" ID:7],
        [BasicDataModel createWithTitle:@"8" ID:8],
        [BasicDataModel createWithTitle:@"9" ID:9],
        [BasicDataModel createWithTitle:@"10" ID:10],
        [BasicDataModel createWithTitle:@"11" ID:11],
        [BasicDataModel createWithTitle:@"12" ID:12],
        [BasicDataModel createWithTitle:@"13" ID:13],
        [BasicDataModel createWithTitle:@"14" ID:14],
        [BasicDataModel createWithTitle:@"15" ID:15],
        [BasicDataModel createWithTitle:@"16" ID:16],
        [BasicDataModel createWithTitle:@"17" ID:17],
        [BasicDataModel createWithTitle:@"18" ID:18],
        [BasicDataModel createWithTitle:@"19" ID:19],
        [BasicDataModel createWithTitle:@"20" ID:20],
        [BasicDataModel createWithTitle:@"21" ID:21],
        [BasicDataModel createWithTitle:@"22" ID:22],
        [BasicDataModel createWithTitle:@"23" ID:23],
        [BasicDataModel createWithTitle:@"24" ID:24],
        [BasicDataModel createWithTitle:@"25" ID:25],
        [BasicDataModel createWithTitle:@"26" ID:26],
        [BasicDataModel createWithTitle:@"27" ID:27],
        [BasicDataModel createWithTitle:@"28" ID:28],
        [BasicDataModel createWithTitle:@"29" ID:29],
        [BasicDataModel createWithTitle:@"30" ID:30],
        [BasicDataModel createWithTitle:@"31" ID:31]
    ];
    
    
    self.DíaDePago2 = @[
        [BasicDataModel createWithTitle:@"1" ID:1],
        [BasicDataModel createWithTitle:@"2" ID:2],
        [BasicDataModel createWithTitle:@"3" ID:3],
        [BasicDataModel createWithTitle:@"4" ID:4],
        [BasicDataModel createWithTitle:@"5" ID:5],
        [BasicDataModel createWithTitle:@"6" ID:6],
        [BasicDataModel createWithTitle:@"7" ID:7],
        [BasicDataModel createWithTitle:@"8" ID:8],
        [BasicDataModel createWithTitle:@"9" ID:9],
        [BasicDataModel createWithTitle:@"10" ID:10],
        [BasicDataModel createWithTitle:@"11" ID:11],
        [BasicDataModel createWithTitle:@"12" ID:12],
        [BasicDataModel createWithTitle:@"13" ID:13],
        [BasicDataModel createWithTitle:@"14" ID:14],
        [BasicDataModel createWithTitle:@"15" ID:15],
        [BasicDataModel createWithTitle:@"16" ID:16],
        [BasicDataModel createWithTitle:@"17" ID:17],
        [BasicDataModel createWithTitle:@"18" ID:18],
        [BasicDataModel createWithTitle:@"19" ID:19],
        [BasicDataModel createWithTitle:@"20" ID:20],
        [BasicDataModel createWithTitle:@"21" ID:21],
        [BasicDataModel createWithTitle:@"22" ID:22],
        [BasicDataModel createWithTitle:@"23" ID:23],
        [BasicDataModel createWithTitle:@"24" ID:24],
        [BasicDataModel createWithTitle:@"25" ID:25],
        [BasicDataModel createWithTitle:@"26" ID:26],
        [BasicDataModel createWithTitle:@"27" ID:27],
        [BasicDataModel createWithTitle:@"28" ID:28],
        [BasicDataModel createWithTitle:@"29" ID:29],
        [BasicDataModel createWithTitle:@"30" ID:30],
        [BasicDataModel createWithTitle:@"31" ID:31]
    ];
  
    self.CiudadDonde = @[
        [BasicDataModel createWithTitle:@"Aguascalientes" ID:1],
        [BasicDataModel createWithTitle:@"Baja California" ID:2],
        [BasicDataModel createWithTitle:@"Baja California Sur" ID:3],
        [BasicDataModel createWithTitle:@"Campeche" ID:4],
        [BasicDataModel createWithTitle:@"Ciudad de México(CDMX)" ID:5],
        [BasicDataModel createWithTitle:@"Chiapas" ID:6],
        [BasicDataModel createWithTitle:@"Chihuahua" ID:7],
        [BasicDataModel createWithTitle:@"Coahuila" ID:8],
        [BasicDataModel createWithTitle:@"Colima" ID:9],
        [BasicDataModel createWithTitle:@"Durango" ID:10],
        [BasicDataModel createWithTitle:@"Guanajuato" ID:11],
        [BasicDataModel createWithTitle:@"Guerrero" ID:12],
        [BasicDataModel createWithTitle:@"Hidalgo" ID:13],
        [BasicDataModel createWithTitle:@"Jalisco" ID:14],
        [BasicDataModel createWithTitle:@"México" ID:15],
        [BasicDataModel createWithTitle:@"Michoacán" ID:16],
        [BasicDataModel createWithTitle:@"Morelos" ID:17],
        [BasicDataModel createWithTitle:@"Nayarit" ID:18],
        [BasicDataModel createWithTitle:@"Nuevo León" ID:19],
        [BasicDataModel createWithTitle:@"Oaxaca" ID:20],
        [BasicDataModel createWithTitle:@"Puebla" ID:21],
        [BasicDataModel createWithTitle:@"Querétaro" ID:22],
        [BasicDataModel createWithTitle:@"Quintana Roo" ID:23],
        [BasicDataModel createWithTitle:@"San Luis Potosi" ID:24],
        [BasicDataModel createWithTitle:@"Sinaloa" ID:25],
        [BasicDataModel createWithTitle:@"Sonora" ID:26],
        [BasicDataModel createWithTitle:@"Tabasco" ID:27],
        [BasicDataModel createWithTitle:@"Tamaulipas" ID:28],
        [BasicDataModel createWithTitle:@"Tlaxcala" ID:29],
        [BasicDataModel createWithTitle:@"Veracruz" ID:30],
        [BasicDataModel createWithTitle:@"Yucatán" ID:31],
        [BasicDataModel createWithTitle:@"Zacatecas" ID:32]
    ];
    
}


@end
@implementation BasicDataModel

+(BasicDataModel *)createWithTitle:(NSString *)title ID:(NSInteger)ID{
    BasicDataModel * model = [[BasicDataModel alloc]init];
    model.title = title;
    model.ID = ID;
    return model;
}

@end
