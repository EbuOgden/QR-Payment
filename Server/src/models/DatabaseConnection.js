
import cassandra from 'cassandra-driver';
import {config} from '../config';

export const cassandraClient = new cassandra.Client({contactPoints : [config.databaseLogin], keyspace : [config.databaseKeyspace]});
export const cassandraUUID = cassandra.types.Uuid;
