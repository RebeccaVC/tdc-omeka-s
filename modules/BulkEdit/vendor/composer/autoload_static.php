<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInitaf7439213ecee7dd652ea8dcdc84642e
{
    public static $prefixLengthsPsr4 = array (
        'B' => 
        array (
            'BulkEdit\\' => 9,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'BulkEdit\\' => 
        array (
            0 => __DIR__ . '/../..' . '/src',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInitaf7439213ecee7dd652ea8dcdc84642e::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInitaf7439213ecee7dd652ea8dcdc84642e::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}