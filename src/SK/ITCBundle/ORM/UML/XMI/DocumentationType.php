<?php

namespace SK\ITCBundle\ORM\UML\XMI;

/**
 * Class representing DocumentationType
 *
 *
 * XSD Type: Documentation
 */
class DocumentationType
{

    /**
     * @property string $id
     */
    private $id = null;

    /**
     * @property string $label
     */
    private $label = null;

    /**
     * @property string $uuid
     */
    private $uuid = null;

    /**
     * @property string $href
     */
    private $href = null;

    /**
     * @property string $idref
     */
    private $idref = null;

    /**
     * @property string $version
     */
    private $version = null;

    /**
     * @property string $type
     */
    private $type = null;

    /**
     * @property string[] $contact
     */
    private $contact = null;

    /**
     * @property string[] $exporter
     */
    private $exporter = null;

    /**
     * @property string[] $exporterVersion
     */
    private $exporterVersion = null;

    /**
     * @property string[] $longDescription
     */
    private $longDescription = null;

    /**
     * @property string[] $shortDescription
     */
    private $shortDescription = null;

    /**
     * @property string[] $notice
     */
    private $notice = null;

    /**
     * @property string[] $owner
     */
    private $owner = null;

    /**
     * @property string[] $exporterID
     */
    private $exporterID = null;

    /**
     * @property \SK\ITCBundle\ORM\UML\XMI\Extension[] $extension
     */
    private $extension = null;

    /**
     * Gets as id
     *
     * @return string
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Sets a new id
     *
     * @param string $id
     * @return self
     */
    public function setId($id)
    {
        $this->id = $id;
        return $this;
    }

    /**
     * Gets as label
     *
     * @return string
     */
    public function getLabel()
    {
        return $this->label;
    }

    /**
     * Sets a new label
     *
     * @param string $label
     * @return self
     */
    public function setLabel($label)
    {
        $this->label = $label;
        return $this;
    }

    /**
     * Gets as uuid
     *
     * @return string
     */
    public function getUuid()
    {
        return $this->uuid;
    }

    /**
     * Sets a new uuid
     *
     * @param string $uuid
     * @return self
     */
    public function setUuid($uuid)
    {
        $this->uuid = $uuid;
        return $this;
    }

    /**
     * Gets as href
     *
     * @return string
     */
    public function getHref()
    {
        return $this->href;
    }

    /**
     * Sets a new href
     *
     * @param string $href
     * @return self
     */
    public function setHref($href)
    {
        $this->href = $href;
        return $this;
    }

    /**
     * Gets as idref
     *
     * @return string
     */
    public function getIdref()
    {
        return $this->idref;
    }

    /**
     * Sets a new idref
     *
     * @param string $idref
     * @return self
     */
    public function setIdref($idref)
    {
        $this->idref = $idref;
        return $this;
    }

    /**
     * Gets as version
     *
     * @return string
     */
    public function getVersion()
    {
        return $this->version;
    }

    /**
     * Sets a new version
     *
     * @param string $version
     * @return self
     */
    public function setVersion($version)
    {
        $this->version = $version;
        return $this;
    }

    /**
     * Gets as type
     *
     * @return string
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * Sets a new type
     *
     * @param string $type
     * @return self
     */
    public function setType($type)
    {
        $this->type = $type;
        return $this;
    }

    /**
     * Adds as contact
     *
     * @return self
     * @param string $contact
     */
    public function addToContact($contact)
    {
        $this->contact[] = $contact;
        return $this;
    }

    /**
     * isset contact
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetContact($index)
    {
        return isset($this->contact[$index]);
    }

    /**
     * unset contact
     *
     * @param scalar $index
     * @return void
     */
    public function unsetContact($index)
    {
        unset($this->contact[$index]);
    }

    /**
     * Gets as contact
     *
     * @return string[]
     */
    public function getContact()
    {
        return $this->contact;
    }

    /**
     * Sets a new contact
     *
     * @param string[] $contact
     * @return self
     */
    public function setContact(array $contact)
    {
        $this->contact = $contact;
        return $this;
    }

    /**
     * Adds as exporter
     *
     * @return self
     * @param string $exporter
     */
    public function addToExporter($exporter)
    {
        $this->exporter[] = $exporter;
        return $this;
    }

    /**
     * isset exporter
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetExporter($index)
    {
        return isset($this->exporter[$index]);
    }

    /**
     * unset exporter
     *
     * @param scalar $index
     * @return void
     */
    public function unsetExporter($index)
    {
        unset($this->exporter[$index]);
    }

    /**
     * Gets as exporter
     *
     * @return string[]
     */
    public function getExporter()
    {
        return $this->exporter;
    }

    /**
     * Sets a new exporter
     *
     * @param string[] $exporter
     * @return self
     */
    public function setExporter(array $exporter)
    {
        $this->exporter = $exporter;
        return $this;
    }

    /**
     * Adds as exporterVersion
     *
     * @return self
     * @param string $exporterVersion
     */
    public function addToExporterVersion($exporterVersion)
    {
        $this->exporterVersion[] = $exporterVersion;
        return $this;
    }

    /**
     * isset exporterVersion
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetExporterVersion($index)
    {
        return isset($this->exporterVersion[$index]);
    }

    /**
     * unset exporterVersion
     *
     * @param scalar $index
     * @return void
     */
    public function unsetExporterVersion($index)
    {
        unset($this->exporterVersion[$index]);
    }

    /**
     * Gets as exporterVersion
     *
     * @return string[]
     */
    public function getExporterVersion()
    {
        return $this->exporterVersion;
    }

    /**
     * Sets a new exporterVersion
     *
     * @param string[] $exporterVersion
     * @return self
     */
    public function setExporterVersion(array $exporterVersion)
    {
        $this->exporterVersion = $exporterVersion;
        return $this;
    }

    /**
     * Adds as longDescription
     *
     * @return self
     * @param string $longDescription
     */
    public function addToLongDescription($longDescription)
    {
        $this->longDescription[] = $longDescription;
        return $this;
    }

    /**
     * isset longDescription
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetLongDescription($index)
    {
        return isset($this->longDescription[$index]);
    }

    /**
     * unset longDescription
     *
     * @param scalar $index
     * @return void
     */
    public function unsetLongDescription($index)
    {
        unset($this->longDescription[$index]);
    }

    /**
     * Gets as longDescription
     *
     * @return string[]
     */
    public function getLongDescription()
    {
        return $this->longDescription;
    }

    /**
     * Sets a new longDescription
     *
     * @param string[] $longDescription
     * @return self
     */
    public function setLongDescription(array $longDescription)
    {
        $this->longDescription = $longDescription;
        return $this;
    }

    /**
     * Adds as shortDescription
     *
     * @return self
     * @param string $shortDescription
     */
    public function addToShortDescription($shortDescription)
    {
        $this->shortDescription[] = $shortDescription;
        return $this;
    }

    /**
     * isset shortDescription
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetShortDescription($index)
    {
        return isset($this->shortDescription[$index]);
    }

    /**
     * unset shortDescription
     *
     * @param scalar $index
     * @return void
     */
    public function unsetShortDescription($index)
    {
        unset($this->shortDescription[$index]);
    }

    /**
     * Gets as shortDescription
     *
     * @return string[]
     */
    public function getShortDescription()
    {
        return $this->shortDescription;
    }

    /**
     * Sets a new shortDescription
     *
     * @param string[] $shortDescription
     * @return self
     */
    public function setShortDescription(array $shortDescription)
    {
        $this->shortDescription = $shortDescription;
        return $this;
    }

    /**
     * Adds as notice
     *
     * @return self
     * @param string $notice
     */
    public function addToNotice($notice)
    {
        $this->notice[] = $notice;
        return $this;
    }

    /**
     * isset notice
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetNotice($index)
    {
        return isset($this->notice[$index]);
    }

    /**
     * unset notice
     *
     * @param scalar $index
     * @return void
     */
    public function unsetNotice($index)
    {
        unset($this->notice[$index]);
    }

    /**
     * Gets as notice
     *
     * @return string[]
     */
    public function getNotice()
    {
        return $this->notice;
    }

    /**
     * Sets a new notice
     *
     * @param string[] $notice
     * @return self
     */
    public function setNotice(array $notice)
    {
        $this->notice = $notice;
        return $this;
    }

    /**
     * Adds as owner
     *
     * @return self
     * @param string $owner
     */
    public function addToOwner($owner)
    {
        $this->owner[] = $owner;
        return $this;
    }

    /**
     * isset owner
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetOwner($index)
    {
        return isset($this->owner[$index]);
    }

    /**
     * unset owner
     *
     * @param scalar $index
     * @return void
     */
    public function unsetOwner($index)
    {
        unset($this->owner[$index]);
    }

    /**
     * Gets as owner
     *
     * @return string[]
     */
    public function getOwner()
    {
        return $this->owner;
    }

    /**
     * Sets a new owner
     *
     * @param string[] $owner
     * @return self
     */
    public function setOwner(array $owner)
    {
        $this->owner = $owner;
        return $this;
    }

    /**
     * Adds as exporterID
     *
     * @return self
     * @param string $exporterID
     */
    public function addToExporterID($exporterID)
    {
        $this->exporterID[] = $exporterID;
        return $this;
    }

    /**
     * isset exporterID
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetExporterID($index)
    {
        return isset($this->exporterID[$index]);
    }

    /**
     * unset exporterID
     *
     * @param scalar $index
     * @return void
     */
    public function unsetExporterID($index)
    {
        unset($this->exporterID[$index]);
    }

    /**
     * Gets as exporterID
     *
     * @return string[]
     */
    public function getExporterID()
    {
        return $this->exporterID;
    }

    /**
     * Sets a new exporterID
     *
     * @param string[] $exporterID
     * @return self
     */
    public function setExporterID(array $exporterID)
    {
        $this->exporterID = $exporterID;
        return $this;
    }

    /**
     * Adds as extension
     *
     * @return self
     * @param \SK\ITCBundle\ORM\UML\XMI\Extension $extension
     */
    public function addToExtension(\SK\ITCBundle\ORM\UML\XMI\Extension $extension)
    {
        $this->extension[] = $extension;
        return $this;
    }

    /**
     * isset extension
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetExtension($index)
    {
        return isset($this->extension[$index]);
    }

    /**
     * unset extension
     *
     * @param scalar $index
     * @return void
     */
    public function unsetExtension($index)
    {
        unset($this->extension[$index]);
    }

    /**
     * Gets as extension
     *
     * @return \SK\ITCBundle\ORM\UML\XMI\Extension[]
     */
    public function getExtension()
    {
        return $this->extension;
    }

    /**
     * Sets a new extension
     *
     * @param \SK\ITCBundle\ORM\UML\XMI\Extension[] $extension
     * @return self
     */
    public function setExtension(array $extension)
    {
        $this->extension = $extension;
        return $this;
    }


}

