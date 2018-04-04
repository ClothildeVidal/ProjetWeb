package Model;

import javax.sql.DataSource;

public class DataSourceFactory {

	public enum DriverType {
		embedded, server
	};
	
	// Choix du type de driver : embedded ou serveur
	private static final DriverType TYPE = DriverType.server;
	/*
	 Renvoie la source de données (server ou embbeded)
	 @return  la source de données
	 */
	public static DataSource getDataSource() {
		DataSource result;

		switch (TYPE) {
			case server: // Derby mode serveur, doit être démarré indépendamment
				org.apache.derby.jdbc.ClientDataSource ds = new org.apache.derby.jdbc.ClientDataSource();
				ds.setDatabaseName("sample");
				ds.setUser("app");
				ds.setPassword("app");
				ds.setServerName("localhost");
				ds.setPortNumber(1527);
				result = ds;
				break;
			default: // Derby mode embedded, démarré automatiquement avec l'application
				org.apache.derby.jdbc.EmbeddedDataSource es = new org.apache.derby.jdbc.EmbeddedDataSource();
				es.setCreateDatabase("create");
				es.setDatabaseName("embedded_sample");
				result = es;
		}

		return result;
	}

}
