-- Noah Asgodom 
-- cleaning NashvilleHousing in SQL 

Select *
From PortfolioProfile.dbo.NashvilleHousing

-- Standardize Date Format

SELECT 
    SaleDate,
    CONVERT(date, SaleDate) AS SaleDateConverted
FROM PortfolioProfile.dbo.NashvilleHousing;

UPDATE PortfolioProfile.dbo.NashvilleHousing
SET SaleDate = CONVERT(date, SaleDate);

-- Populate Property Address data

Select PropertyAddress
From PortfolioProfile.dbo.NashvilleHousing

Select *
From PortfolioProfile.dbo.NashvilleHousing
--Where PropertyAddress is null
Order by ParcelID

SELECT 
    a.ParcelID, 
    a.PropertyAddress, 
    b.ParcelID, 
    b.PropertyAddress
FROM PortfolioProfile.dbo.NashvilleHousing a
JOIN PortfolioProfile.dbo.NashvilleHousing b
    ON a.ParcelID = b.ParcelID
    AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

SELECT 
    a.ParcelID, 
    a.PropertyAddress, 
    b.ParcelID, 
    b.PropertyAddress,
    ISNULL(a.PropertyAddress, b.PropertyAddress) AS FilledAddress
FROM PortfolioProfile.dbo.NashvilleHousing a
JOIN PortfolioProfile.dbo.NashvilleHousing b
    ON a.ParcelID = b.ParcelID
    AND a.[UniqueID ] <> b.[UniqueID ]

UPDATE a
SET a.PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProfile.dbo.NashvilleHousing a
JOIN PortfolioProfile.dbo.NashvilleHousing b
    ON a.ParcelID = b.ParcelID
    AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

-- Breaking out Address into Individual Columns (Address, City, State)
Select PropertyAddress
From PortfolioProfile.dbo.NashvilleHousing
 -- Where PropertyAddress is null
-- order by ParcelID

SELECT
    SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address
FROM PortfolioProfile.dbo.NashvilleHousing;

-- Split PropertyAddress into Street (before comma) and City (after comma)
SELECT
    SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address,
    SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS City
FROM PortfolioProfile.dbo.NashvilleHousing;

-- Add a new column to store the street portion of PropertyAddress
ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);

-- Populate PropertySplitAddress with the text before the comma in PropertyAddress
UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1);

-- Add a new column to store the city portion of PropertyAddress
ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(255);

-- Populate PropertySplitCity with the text after the comma in PropertyAddress
UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress));

-- Return every row and every column from the NashvilleHousing table
SELECT *
FROM PortfolioProfile.dbo.NashvilleHousing;

Select OwnerAddress
From PortfolioProfile.dbo.NashvilleHousing

-- Split OwnerAddress into Address, City, and State using PARSENAME after replacing commas with periods
SELECT
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS OwnerSplitAddress,
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS OwnerSplitCity,
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS OwnerSplitState
FROM PortfolioProfile.dbo.NashvilleHousing;

-- Add a new column to store the street portion of OwnerAddress
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255);

-- Populate OwnerSplitAddress with the first part of OwnerAddress (before the first period)
UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);

-- Add a new column to store the city portion of OwnerAddress
ALTER TABLE NashvilleHousing
ADD OwnerSplitCity NVARCHAR(255);

-- Populate OwnerSplitCity with the second part of OwnerAddress (middle section)
UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);

-- Change Y and N to Yes and No in "Sold as Vacant" field

-- Return each SoldAsVacant value and how many times it appears in the dataset
SELECT 
    SoldAsVacant,
    COUNT(*) AS CountOfValues
FROM PortfolioProfile.dbo.NashvilleHousing
GROUP BY SoldAsVacant;

-- Standardize SoldAsVacant values by converting Y/N to Yes/No
SELECT 
    SoldAsVacant,
    CASE 
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END AS SoldAsVacantCleaned
FROM PortfolioProfile.dbo.NashvilleHousing;

-- Update SoldAsVacant by converting Y/N values into Yes/No
UPDATE NashvilleHousing
SET SoldAsVacant = CASE 
                       WHEN SoldAsVacant = 'Y' THEN 'Yes'
                       WHEN SoldAsVacant = 'N' THEN 'No'
                       ELSE SoldAsVacant
                   END;


-- Identify duplicate rows by assigning a row number to records with matching key fields
SELECT 
    *,
    ROW_NUMBER() OVER (
        PARTITION BY ParcelID,
                     PropertyAddress,
                     SalePrice,
                     SaleDate,
                     LegalReference
        ORDER BY UniqueID
    ) AS row_num
FROM PortfolioProfile.dbo.NashvilleHousing
ORDER BY ParcelID;


-- Use a CTE to identify duplicate rows by assigning row numbers to matching records
WITH RowNumCTE AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY ParcelID,
                         PropertyAddress,
                         SalePrice,
                         SaleDate,
                         LegalReference
            ORDER BY UniqueID
        ) AS row_num
    FROM PortfolioProfile.dbo.NashvilleHousing
)

SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress;

--Delete all Dublicates
WITH RowNumCTE AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY ParcelID,
                         PropertyAddress,
                         SalePrice,
                         SaleDate,
                         LegalReference
            ORDER BY UniqueID
        ) AS row_num
    FROM PortfolioProfile.dbo.NashvilleHousing
)

DELETE
FROM RowNumCTE
WHERE row_num > 1

-- Delete Unused Columns

Select *
From PortfolioProfile.dbo.NashvilleHousing

ALTER TABLE PortfolioProfile.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProfile.dbo.NashvilleHousing
DROP COLUMN SaleDate