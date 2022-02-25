using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.DataAccess;
using TrackerLibrary.Models;

namespace TrackerUI
{
    public partial class CreatePrizeForm : Form
    {
        public CreatePrizeForm()
        {
            InitializeComponent();
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void createPrizeButton_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                PrizeModel model = new PrizeModel(
                    placeNameValue.Text,
                    placeNumberValue.Text,
                    prizeAmountValue.Text,
                    prizePercentageValue.Text);

                foreach (IDataConnection db in GlobalConfig.Connections)
                {
                    db.CreatePrize(model);
                }

                placeNameValue.Text = "";
                placeNumberValue.Text = "";
                prizeAmountValue.Text = "";
                prizePercentageValue.Text = "";
            }
            else
            {
                MessageBox.Show("This form has invalid information. Please check it and try again.");
            }

        }

        private void prizeAmountValue_TextChanged(object sender, EventArgs e)
        {

        }

        private void CreatePrizeForm_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void prizePercentageLabel_Click(object sender, EventArgs e)
        {

        }

        private void prizePercentageValue_TextChanged(object sender, EventArgs e)
        {

        }

        private void prizeAmountLabel_Click(object sender, EventArgs e)
        {

        }

        private void firstNameValue_TextChanged(object sender, EventArgs e)
        {

        }

        private void placeNumberLabel_Click(object sender, EventArgs e)
        {

        }

        private void headerLabel_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void placeNameLabel_Click(object sender, EventArgs e)
        {

        }

        private bool ValidateForm()
        {
            bool output = true;
            int placeNumber = 0;
            bool PlaceNumberValidNumber = int.TryParse(placeNumberValue.Text, out placeNumber);

            if (PlaceNumberValidNumber == false)
            {
                output = false;
            }

            if (placeNumber < 1)
            {
                output = false;
            }

            if (placeNameValue.Text.Length == 0)
            {
                output = false;
            }


            decimal PrizeAmount = 0;
            double prizePercentage = 0;
            bool prizeAmountValid = decimal.TryParse(prizeAmountValue.Text, out PrizeAmount);
            bool prizePercentageValid = double.TryParse(prizePercentageValue.Text, out prizePercentage);
            if (prizeAmountValid == false && prizePercentageValid == false)
            {
                output = false;
            }

            if (PrizeAmount <= 0 && prizePercentage <= 0)
            {
                output = false;

            }

            if (prizePercentage < 0 || prizePercentage > 100)
            {
                output = false;
            }
            return output;
        }
    }
}
