¿Qué diferencia existe entre crypt() y pgp_sym_encrypt()?

crypt() se utiliza para proteger contraseñas mediante un hash, por lo que no permite recuperar el valor original. En cambio, pgp_sym_encrypt() cifra la información utilizando una clave y posteriormente permite descifrarla para recuperar el dato original.

¿Cuál de los dos mecanismos permite recuperar el dato original?

pgp_sym_encrypt() permite recuperar el dato original utilizando la función pgp_sym_decrypt() y la clave correcta. crypt() no permite recuperar la contraseña original.

¿Qué ocurre si se utiliza una clave incorrecta?

El dato no podrá descifrarse correctamente y PostgreSQL generará un error o devolverá información inválida, impidiendo recuperar el contenido original.

¿Qué problema de seguridad representa colocar la clave directamente en una consulta?

La clave queda expuesta en el código, scripts, archivos SQL, repositorios Git, registros o respaldos. Si una persona obtiene acceso a esa consulta, también obtendrá la clave necesaria para descifrar la información protegida, comprometiendo la confidencialidad de los datos.
