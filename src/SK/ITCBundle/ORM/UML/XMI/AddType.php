<?php

namespace SK\ITCBundle\ORM\UML\XMI;

/**
 * Class representing AddType
 *
 *
 * XSD Type: Add
 */
class AddType extends DifferenceType
{

    /**
     * @property string $position
     */
    private $position = null;

    /**
     * @property string $addition
     */
    private $addition = null;

    /**
     * Gets as position
     *
     * @return string
     */
    public function getPosition()
    {
        return $this->position;
    }

    /**
     * Sets a new position
     *
     * @param string $position
     * @return self
     */
    public function setPosition($position)
    {
        $this->position = $position;
        return $this;
    }

    /**
     * Gets as addition
     *
     * @return string
     */
    public function getAddition()
    {
        return $this->addition;
    }

    /**
     * Sets a new addition
     *
     * @param string $addition
     * @return self
     */
    public function setAddition($addition)
    {
        $this->addition = $addition;
        return $this;
    }


}

