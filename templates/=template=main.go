package main

import (
	"fmt"
	"net"
	"net/http"
	"os"

	"github.com/gomicro/ledger"
	"github.com/gomicro/steward"
	"github.com/gorilla/mux"
	"github.com/kelseyhightower/envconfig"
	/*
		"database/sql"
		"github.com/gomicro/blockit"
		_ "github.com/lib/pq"
	*/)

const (
	appName = "yourservice"
)

var (
	appVersion string
	buildTime  string

	log    *ledger.Ledger
	config configuration

	/*
		db *sql.DB
	*/
)

type configuration struct {
	Host        string `default:"0.0.0.0"`
	Port        string `default:"4567"`
	SSLCertFile string
	SSLKeyFile  string

	LogLevel string `default:"debug"`

	/*
		DBHost     string `default:"database"`
		DBPort     string `default:"5432"`
		DBName     string `default:"yourservice"`
		DBUser     string `default:"yourservice"`
		DBPassword string `default:"yourservice"`
		DBSSL      string `default:"disable"`
	*/
}

type statusResponse struct {
	Application string    `json:"app"`
	Version     string    `json:"version"`
	BuildTime   string    `json:"buildTime"`
	SSLStatus   sslStatus `json:"ssl"`
}

type sslStatus struct {
	ServingSSL bool `json:"serving_ssl"`
	//DBSSL      bool `json:"db_ssl"`
}

func main() {
	configure()

	err := startService()
	if err != nil {
		log.Errorf("Something went wrong: %v", err.Error())
		return
	}

	log.Info("Server stopping")
}

func configure() {
	err := envconfig.Process(appName, &config)
	if err != nil {
		fmt.Printf("Fatal: Unable to configure service: %v\n", err.Error())
		os.Exit(1)
	}

	log = ledger.New(os.Stdout, ledger.ParseLevel(config.LogLevel))
	log.Debug("Logger configured")

	steward.SetStatusResponse(&statusResponse{
		Application: appName,
		Version:     appVersion,
		BuildTime:   buildTime,
		SSLStatus: sslStatus{
			ServingSSL: (config.SSLKeyFile != "" && config.SSLCertFile != ""),
			//DBSSL:      (config.DBSSL != "disable"),
		},
	})
	log.Debug("Status endpoint configured")

	/*
		connStr := fmt.Sprintf(
			"host=%s port=%s user=%s password=%s dbname=%s sslmode=%s",
			config.DBHost, config.DBPort, config.DBUser, config.DBPassword, config.DBName, config.DBSSL,
		)
		db, err = sql.Open("postgres", connStr)
		if err != nil {
			log.Errorf("Cannot open sql connection: %v", err.Error())
		}

		db.SetMaxIdleConns(50)
		db.SetMaxOpenConns(50)

		dbb := dbblocker.New(db)
		log.Debug("Database connection configured")

		log.Debug("Waiting for dependencies to stablize")
		<-dbb.Blockit()
		log.Debug("Dependencies have stablized")
	*/

	log.Info("Configuration complete")
}

func startService() error {
	log.Infof("Listening on %v:%v", config.Host, config.Port)

	http.Handle("/", registerEndpoints())

	if config.SSLKeyFile != "" && config.SSLCertFile != "" {
		log.Info("Serving with SSL")
		return http.ListenAndServeTLS(net.JoinHostPort(config.Host, config.Port), config.SSLCertFile, config.SSLKeyFile, nil)
	}

	log.Info("Serving without SSL")
	return http.ListenAndServe(net.JoinHostPort(config.Host, config.Port), nil)
}

func registerEndpoints() http.Handler {
	r := mux.NewRouter()

	//r.HandleFunc("/some/endpoint", handleSomeEndpoint)

	return r
}
