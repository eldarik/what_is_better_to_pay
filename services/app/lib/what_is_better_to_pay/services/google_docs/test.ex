defmodule WhatIsBetterToPay.Services.GoogleDocs.Test do
  def fetch_document(_link) do
    ~S"""
    карта,процент,категория,место
    TINKOFF BLACK 1234,5%,жд,-
    TINKOFF BLACK 1234,5%,кино,-
    TINKOFF BLACK 1234,5%,транспорт,-
    TINKOFF BLACK 1234,5%,аптеки,-
    TINKOFF BLACK 1234,5%,красота,-
    TINKOFF BLACK 1234,5%,спорттовары,-
    ROCKET BANK 1234,8%,-,букет столицы
    ROCKET BANK 1234,5%,-,terranova
    ROCKET BANK 1234,5%,-,beanhearts coffee
    TINKOFF ALL AIRLINES 1234,2%,*,*
    TINKOFF BLACK 1234,1%,*,*
    """
  end
end
