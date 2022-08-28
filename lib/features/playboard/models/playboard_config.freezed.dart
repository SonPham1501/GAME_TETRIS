// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'playboard_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PlayboardConfigTearOff {
  const _$PlayboardConfigTearOff();

  NonePlayboardConfig none() {
    return const NonePlayboardConfig();
  }

  BlindPlayboardConfig blind(ButtonColors colors) {
    return BlindPlayboardConfig(
      colors,
    );
  }
}

/// @nodoc
const $PlayboardConfig = _$PlayboardConfigTearOff();

/// @nodoc
mixin _$PlayboardConfig {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(ButtonColors colors) blind,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(ButtonColors colors)? blind,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(ButtonColors colors)? blind,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NonePlayboardConfig value) none,
    required TResult Function(BlindPlayboardConfig value) blind,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NonePlayboardConfig value)? none,
    TResult Function(BlindPlayboardConfig value)? blind,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NonePlayboardConfig value)? none,
    TResult Function(BlindPlayboardConfig value)? blind,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayboardConfigCopyWith<$Res> {
  factory $PlayboardConfigCopyWith(
          PlayboardConfig value, $Res Function(PlayboardConfig) then) =
      _$PlayboardConfigCopyWithImpl<$Res>;
}

/// @nodoc
class _$PlayboardConfigCopyWithImpl<$Res>
    implements $PlayboardConfigCopyWith<$Res> {
  _$PlayboardConfigCopyWithImpl(this._value, this._then);

  final PlayboardConfig _value;
  // ignore: unused_field
  final $Res Function(PlayboardConfig) _then;
}

/// @nodoc
abstract class $NonePlayboardConfigCopyWith<$Res> {
  factory $NonePlayboardConfigCopyWith(
          NonePlayboardConfig value, $Res Function(NonePlayboardConfig) then) =
      _$NonePlayboardConfigCopyWithImpl<$Res>;
}

/// @nodoc
class _$NonePlayboardConfigCopyWithImpl<$Res>
    extends _$PlayboardConfigCopyWithImpl<$Res>
    implements $NonePlayboardConfigCopyWith<$Res> {
  _$NonePlayboardConfigCopyWithImpl(
      NonePlayboardConfig _value, $Res Function(NonePlayboardConfig) _then)
      : super(_value, (v) => _then(v as NonePlayboardConfig));

  @override
  NonePlayboardConfig get _value => super._value as NonePlayboardConfig;
}

/// @nodoc

class _$NonePlayboardConfig implements NonePlayboardConfig {
  const _$NonePlayboardConfig();

  @override
  String toString() {
    return 'PlayboardConfig.none()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NonePlayboardConfig);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(ButtonColors colors) blind,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(ButtonColors colors)? blind,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(ButtonColors colors)? blind,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NonePlayboardConfig value) none,
    required TResult Function(BlindPlayboardConfig value) blind,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NonePlayboardConfig value)? none,
    TResult Function(BlindPlayboardConfig value)? blind,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NonePlayboardConfig value)? none,
    TResult Function(BlindPlayboardConfig value)? blind,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class NonePlayboardConfig implements PlayboardConfig {
  const factory NonePlayboardConfig() = _$NonePlayboardConfig;
}

/// @nodoc
abstract class $BlindPlayboardConfigCopyWith<$Res> {
  factory $BlindPlayboardConfigCopyWith(BlindPlayboardConfig value,
          $Res Function(BlindPlayboardConfig) then) =
      _$BlindPlayboardConfigCopyWithImpl<$Res>;
  $Res call({ButtonColors colors});
}

/// @nodoc
class _$BlindPlayboardConfigCopyWithImpl<$Res>
    extends _$PlayboardConfigCopyWithImpl<$Res>
    implements $BlindPlayboardConfigCopyWith<$Res> {
  _$BlindPlayboardConfigCopyWithImpl(
      BlindPlayboardConfig _value, $Res Function(BlindPlayboardConfig) _then)
      : super(_value, (v) => _then(v as BlindPlayboardConfig));

  @override
  BlindPlayboardConfig get _value => super._value as BlindPlayboardConfig;

  @override
  $Res call({
    Object? colors = freezed,
  }) {
    return _then(BlindPlayboardConfig(
      colors == freezed
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as ButtonColors,
    ));
  }
}

/// @nodoc

class _$BlindPlayboardConfig implements BlindPlayboardConfig {
  const _$BlindPlayboardConfig(this.colors);

  @override
  final ButtonColors colors;

  @override
  String toString() {
    return 'PlayboardConfig.blind(colors: $colors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BlindPlayboardConfig &&
            const DeepCollectionEquality().equals(other.colors, colors));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(colors));

  @JsonKey(ignore: true)
  @override
  $BlindPlayboardConfigCopyWith<BlindPlayboardConfig> get copyWith =>
      _$BlindPlayboardConfigCopyWithImpl<BlindPlayboardConfig>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(ButtonColors colors) blind,
  }) {
    return blind(colors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(ButtonColors colors)? blind,
  }) {
    return blind?.call(colors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(ButtonColors colors)? blind,
    required TResult orElse(),
  }) {
    if (blind != null) {
      return blind(colors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NonePlayboardConfig value) none,
    required TResult Function(BlindPlayboardConfig value) blind,
  }) {
    return blind(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NonePlayboardConfig value)? none,
    TResult Function(BlindPlayboardConfig value)? blind,
  }) {
    return blind?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NonePlayboardConfig value)? none,
    TResult Function(BlindPlayboardConfig value)? blind,
    required TResult orElse(),
  }) {
    if (blind != null) {
      return blind(this);
    }
    return orElse();
  }
}

abstract class BlindPlayboardConfig implements PlayboardConfig {
  const factory BlindPlayboardConfig(ButtonColors colors) =
      _$BlindPlayboardConfig;

  ButtonColors get colors;
  @JsonKey(ignore: true)
  $BlindPlayboardConfigCopyWith<BlindPlayboardConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
