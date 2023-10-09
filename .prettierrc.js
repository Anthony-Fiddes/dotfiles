module.exports = {
	plugins: ["/usr/lib/node_modules/prettier-plugin-sql-cst/dist/index.js"],
	overrides: [
		{
			files: ["*.sql"],
			options: { parser: "bigquery" },
		},
	],
};
