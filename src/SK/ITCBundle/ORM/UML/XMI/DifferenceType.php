<?php

namespace SK\ITCBundle\ORM\UML\XMI;

/**
 * Class representing DifferenceType
 *
 *
 * XSD Type: Difference
 */
class DifferenceType
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
     * @property \SK\ITCBundle\ORM\UML\XMI\DifferenceType\TargetAType[] $target
     */
    private $target = null;

    /**
     * @property \SK\ITCBundle\ORM\UML\XMI\DifferenceType[] $container
     */
    private $container = null;

    /**
     * @property \SK\ITCBundle\ORM\UML\XMI\DifferenceType[] $difference
     */
    private $difference = null;

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
     * Adds as target
     *
     * @return self
     * @param \SK\ITCBundle\ORM\UML\XMI\DifferenceType\TargetAType $target
     */
    public function addToTarget(\SK\ITCBundle\ORM\UML\XMI\DifferenceType\TargetAType $target)
    {
        $this->target[] = $target;
        return $this;
    }

    /**
     * isset target
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetTarget($index)
    {
        return isset($this->target[$index]);
    }

    /**
     * unset target
     *
     * @param scalar $index
     * @return void
     */
    public function unsetTarget($index)
    {
        unset($this->target[$index]);
    }

    /**
     * Gets as target
     *
     * @return \SK\ITCBundle\ORM\UML\XMI\DifferenceType\TargetAType[]
     */
    public function getTarget()
    {
        return $this->target;
    }

    /**
     * Sets a new target
     *
     * @param \SK\ITCBundle\ORM\UML\XMI\DifferenceType\TargetAType[] $target
     * @return self
     */
    public function setTarget(array $target)
    {
        $this->target = $target;
        return $this;
    }

    /**
     * Adds as container
     *
     * @return self
     * @param \SK\ITCBundle\ORM\UML\XMI\DifferenceType $container
     */
    public function addToContainer(\SK\ITCBundle\ORM\UML\XMI\DifferenceType $container)
    {
        $this->container[] = $container;
        return $this;
    }

    /**
     * isset container
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetContainer($index)
    {
        return isset($this->container[$index]);
    }

    /**
     * unset container
     *
     * @param scalar $index
     * @return void
     */
    public function unsetContainer($index)
    {
        unset($this->container[$index]);
    }

    /**
     * Gets as container
     *
     * @return \SK\ITCBundle\ORM\UML\XMI\DifferenceType[]
     */
    public function getContainer()
    {
        return $this->container;
    }

    /**
     * Sets a new container
     *
     * @param \SK\ITCBundle\ORM\UML\XMI\DifferenceType[] $container
     * @return self
     */
    public function setContainer(array $container)
    {
        $this->container = $container;
        return $this;
    }

    /**
     * Adds as difference
     *
     * @return self
     * @param \SK\ITCBundle\ORM\UML\XMI\DifferenceType $difference
     */
    public function addToDifference(\SK\ITCBundle\ORM\UML\XMI\DifferenceType $difference)
    {
        $this->difference[] = $difference;
        return $this;
    }

    /**
     * isset difference
     *
     * @param scalar $index
     * @return boolean
     */
    public function issetDifference($index)
    {
        return isset($this->difference[$index]);
    }

    /**
     * unset difference
     *
     * @param scalar $index
     * @return void
     */
    public function unsetDifference($index)
    {
        unset($this->difference[$index]);
    }

    /**
     * Gets as difference
     *
     * @return \SK\ITCBundle\ORM\UML\XMI\DifferenceType[]
     */
    public function getDifference()
    {
        return $this->difference;
    }

    /**
     * Sets a new difference
     *
     * @param \SK\ITCBundle\ORM\UML\XMI\DifferenceType[] $difference
     * @return self
     */
    public function setDifference(array $difference)
    {
        $this->difference = $difference;
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

