<?php

namespace SK\ITCBundle\UML\XMI;

/**
 * Class representing ExtensionType
 *
 *
 * XSD Type: Extension
 */
class ExtensionType
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
     * @property string $extender
     */
    private $extender = null;

    /**
     * @property string $extenderID
     */
    private $extenderID = null;

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
     * Gets as extender
     *
     * @return string
     */
    public function getExtender()
    {
        return $this->extender;
    }

    /**
     * Sets a new extender
     *
     * @param string $extender
     * @return self
     */
    public function setExtender($extender)
    {
        $this->extender = $extender;
        return $this;
    }

    /**
     * Gets as extenderID
     *
     * @return string
     */
    public function getExtenderID()
    {
        return $this->extenderID;
    }

    /**
     * Sets a new extenderID
     *
     * @param string $extenderID
     * @return self
     */
    public function setExtenderID($extenderID)
    {
        $this->extenderID = $extenderID;
        return $this;
    }


}

