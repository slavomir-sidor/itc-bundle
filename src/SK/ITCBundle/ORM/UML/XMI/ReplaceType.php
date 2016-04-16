<?php

namespace SK\ITCBundle\ORM\UML\XMI;

/**
 * Class representing ReplaceType
 *
 *
 * XSD Type: Replace
 */
class ReplaceType extends DifferenceType
{

    /**
     * @property string $position
     */
    private $position = null;

    /**
     * @property string $replacement
     */
    private $replacement = null;

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
     * Gets as replacement
     *
     * @return string
     */
    public function getReplacement()
    {
        return $this->replacement;
    }

    /**
     * Sets a new replacement
     *
     * @param string $replacement
     * @return self
     */
    public function setReplacement($replacement)
    {
        $this->replacement = $replacement;
        return $this;
    }


}

