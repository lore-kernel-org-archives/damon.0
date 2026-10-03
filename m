Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108832882AB
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062420; cv=none; b=Y99FUhGSttmMtT7ynDv3ojeaBIrtqpzAE+BordmtC4jLGkN/XYIlbvz9y2T0WJSh46kT3J8KXntH/3PF5eXCDblbnpbsqKIvvR3Q3wylaJjff9UYxxk1HInHA5LP4qYu9ymKS/ejicdmhTIPM0wT2U5UaIbiERkPppOi6UlE7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062420; c=relaxed/simple;
	bh=8kwFveizhlxq2LAtjF3TdgPCa7s5bJQLDlbPEhrmaac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UN/Fi3vK6p7WklOsWs/qiQ0jupKGaz9xeummEM7mEuT87kCdNUyWPq0dLtZPCkRs5HtpyKfteSfn6HA1d5iMnLEwIb0mPHVUHIyQgzfblWXRg1luj+gLpBfs+qKWyr2dy6o4WWVRf4V9E3mEgAUzqtLexn08kr7GIcGOogCUzqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKLsfY0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKLsfY0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58FF1F0089B;
	Sat,  3 Oct 2026 21:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062418;
	bh=+MwthJLQQLxirCrLA4fbkJJHvJUrYyIxzZO08vkm+B8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fKLsfY0NI0AGmB+1oSO17wT3G8ieez+uqAPLvAdKGwo8dI/CkB0VJ67pPOh8Qmdol
	 R3eteveQCB6Ip7/0mYqzJMTQNp3Tb03nxxf5W0oy+EEAAzF7OW8zOp49XsI7Sf73lZ
	 M5igW0Ey8NoWAMLUK2LdKRfQZNZrH7gGXSMVWqt3uKvZgdXz+A0sPx9UEGeaWQ9Bnj
	 dzVu4e8fhyuUXgacnuB1Q8aO4ThJOyFoN6hvSrcwpkhUetRfqNrqki85BaTBZksmKg
	 TrTsIvKmuae0Uu2Aii3CyC4hk2QHJ+ICr0ehoS6VyWBsNPoumSGCWWOElNNOE9TENA
	 G2BMdZrHjkW/A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 6/9] mm/damon/sysfs: expose perf_event prep
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-6-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
 <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-6-0f00417b41bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 21:20:18 +0000
Message-Id: <20261003212018.B58FF1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: damon: unconditionally accepting DAMON_PREP_PERF_EVENT in sysfs
- [Low] mm: damon: missing lock in sysfs stores for perf config causes TOCT=
OU
--

commit 78f93348dd1c6285a193d16bcc3c5698cbede00f
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon/sysfs: expose perf_event prep attributes

This commit wires the DAMON_PREP_PERF_EVENT prep type into sysfs, allowing
user space to configure a PMU hotness probe through the preps/N/ directory.
It adds various perf_event attributes and sets up the probe descriptor when
the kdamond is turned on.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 80e6fc8004e5d..36bccf9480254 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
[ ... ]
> @@ -834,8 +854,122 @@ static void damon_sysfs_prep_release(struct kobject=
 *kobj)
>  static struct kobj_attribute damon_sysfs_prep_prep_action_attr =3D
>  		__ATTR_RW_MODE(prep_action, 0600);
> =20
> +/*
> + * perf_event configuration attributes.  These mirror a subset of
> + * perf_event_attr and are only meaningful when prep_action is "perf_eve=
nt".
> + * They select the PMU (via type/config) and its sampling parameters, an=
d are
> + * copied into the perf-event probe when the kdamond is turned on.
> + *
> + * The sysfs file names stay bare (type, config, ...) while the backing C
> + * symbols are prefixed to avoid clashing with identically named attribu=
tes
> + * elsewhere in this file.
> + */
[ ... ]
> +#define DAMON_SYSFS_PREP_PERF_U64(name, field)				\
> +static ssize_t damon_sysfs_prep_##name##_show(struct kobject *kobj,	\
> +		struct kobj_attribute *attr, char *buf)			\
> +{									\
> +	struct damon_sysfs_prep *prep =3D container_of(kobj,		\
> +			struct damon_sysfs_prep, kobj);			\
> +	return sysfs_emit(buf, "%llu\n", prep->field);			\
> +}									\
> +static ssize_t damon_sysfs_prep_##name##_store(struct kobject *kobj,	\
> +		struct kobj_attribute *attr, const char *buf,		\
> +		size_t count)						\
> +{									\
> +	struct damon_sysfs_prep *prep =3D container_of(kobj,		\
> +			struct damon_sysfs_prep, kobj);			\
> +	u64 v;								\
> +	int err =3D kstrtou64(buf, 0, &v);				\
> +	if (err)							\
> +		return err;						\
> +	prep->field =3D v;						\
> +	return count;							\
> +}									\
> +static struct kobj_attribute damon_sysfs_prep_##name##_attr =3D __ATTR(n=
ame, \
> +		0600, damon_sysfs_prep_##name##_show,			\
> +		damon_sysfs_prep_##name##_store)

[Severity: Low]
Does this code allow concurrent sysfs writes to bypass the mutual exclusivi=
ty
checks? The generated store functions permit concurrent modification of the=
 prep
configuration fields since they do not take damon_sysfs_lock.

[ ... ]
> @@ -2261,14 +2395,62 @@ static int damon_sysfs_set_preps(struct damon_pro=
be *probe,
>  		struct damon_sysfs_preps *sys_preps)
>  {
>  	int i;
> +	bool seen_perf_prep =3D false;
> =20
>  	for (i =3D 0; i < sys_preps->nr; i++) {
>  		struct damon_sysfs_prep *sys_prep =3D sys_preps->preps_arr[i];
>  		struct damon_prep *prep;
> =20
> +		/*
> +		 * period and freq are mutually exclusive perf sampling modes;
> +		 * reject a config that sets both before it can arm a counter.
> +		 */
> +		if (sys_prep->action =3D=3D DAMON_PREP_PERF_EVENT &&

[Severity: High]
Is it possible for DAMON_PREP_PERF_EVENT to be parsed and accepted
unconditionally here, even when the kernel feature CONFIG_DAMON_PERF_SOURCE=
 is
disabled?

> +		    sys_prep->sample_period && sys_prep->sample_freq)
> +			return -EINVAL;

[Severity: Low]
Following up on the sysfs locking question above, could the shared configur=
ation
variables be evaluated multiple times without READ_ONCE() or local copies?
This could leave a window where their values change between this check and
the assignment below, potentially invalidating the check and passing an inv=
alid
perf configuration to the core.

[ ... ]
> @@ -2322,13 +2567,21 @@ static int damon_sysfs_set_probe(struct damon_pro=
be *probe,
>  			return err;
>  	}
>  	sys_filters =3D sys_probe->filters;
> -	if (!sys_filters)
> -		return 0;
> -	return damon_sysfs_set_filters(probe, sys_filters);
> +	if (sys_filters) {
> +		err =3D damon_sysfs_set_filters(probe, sys_filters);
> +		if (err)
> +			return err;
> +	}
> +#ifdef CONFIG_DAMON_PERF_SOURCE
> +	err =3D damon_sysfs_set_perf_probe(ctx, probe, arm);
> +	if (err)
> +		return err;
> +#endif
> +	return 0;
>  }

[Severity: High]
When CONFIG_DAMON_PERF_SOURCE is disabled, does this silently accept the
perf configuration without setting probe->event_driven =3D true?

If so, it seems the probe might fall back to broken software sampling witho=
ut
clearing the accessed bit, which could cause the probe to hallucinate 100%
memory hotness forever and potentially evict all hot pages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-damon-perf=
-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com?part=3D6
