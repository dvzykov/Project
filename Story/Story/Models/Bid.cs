using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Story.Models
{
    public class Bid
    {
        public virtual int Id { get; set; }
        // Фамилия клиента
        [DisplayName("Фамилия заявителя")]
        public virtual string FirstName { get; set; }
        // Имя клиента
        [DisplayName("Имя заявителя")]
        public virtual string LastName { get; set; }
        // Адресс
        [DisplayName("Адрес доставки")]
        public virtual string Address { get; set; }
        //Телефон
        [DisplayName("Телефон")]
        public virtual string Phone { get; set; }
        // Картинка товара
        public virtual string Img { set; get; }
        // Название производителя
        [DisplayName("Марка")]
        public virtual string Maker { set; get; }
        //// Тип велосипеда
        [DisplayName("Тип")]
        public virtual string BikeType { set; get; }
        //Колеса велосипеда
        [DisplayName("Диамер колес")]
        public virtual string Wheel { set; get; }
        //Рама 
        [DisplayName("Рама")]
        public virtual string Frame { set; get; }
        //цена
        [DisplayName("Цена")]
        public virtual string Price { set; get; }
        
        [DisplayName("Дата подачи заявки")]
        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yy}")]
        public virtual DateTime BidDate { get; set; }
        //комментарии
        [DisplayName("Комментарий")]
        public virtual string Comment { set; get; }

    }
}