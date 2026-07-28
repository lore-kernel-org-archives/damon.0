Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161433A2E3F
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 04:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212720; cv=none; b=ZAJ/Y1e7T6uGRJcRkZdTiEczfGmmEPTcAq5H2ZKd2iD5rr/NLD9l4GDDIU/VP1vbMpegj+QmlK5NxhGmQO42tgFCjupNPbVr2wvn8uLRWj+az0uzL30MKGUUR0YXzKoLOy21zAKNaMUpgNCdr3FAoaT6w6JylpBWLWLUVlXwLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212720; c=relaxed/simple;
	bh=RfX0zQbZpgZJBjoNxPRGVm0Dw5SmRsYH5Of9dwZ6HVE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f3cwWfu+PCkV56PF/l/ovrRvA2lQSyLRm/ixayB5UeBKvVUI6IOT+QMsOpKOPGgOCd9mFLuFejqC9R2JQPnGa/RfhY+54acknkYLPgJ3S+CeuAKwNyRPABY2pquOfsvMot4LGwmC1MLYZg93LQrs1WVm5eCBRaaGLg8TNQqSFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfT0i1Gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfT0i1Gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899B61F000E9;
	Tue, 28 Jul 2026 04:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785212718;
	bh=i3jg/617ibT4OT4e/84y40B3MTcKUyv9FV5VbUtPkP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KfT0i1GgpTSmxk8VfmFuINtfsT/0v7agRQgGd5CSm+HJGPDIBJsILZ3Qd38Cb2MsD
	 F1RP/aGivP/iIWQCqnmR0TISAkQGNH0P4kUOenFjMhGZ6hO3J2lrGlaKKIlRKHXRg1
	 JT7mr4MCdlcjbOPmzCtMGXloE0ImE2soageUd4VLD8E6/xlzN7++dxjmS4Ak8aE/yA
	 Sbb8d6xh1Ve41eZ35rj6Pu0ft18jlhVALHrXAw/44cJ2tpPWgiPMUeN8zDarlXI4yX
	 v4fN0invBk0D12Fqlq4EQB7aaVMOEdyKYunAnCPi4ik3Mzi9oM3hWqs+dbHcWnXXLa
	 C29N2JfuJzq0w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 05/17] mm/damon/core: introduce damon_prep
 struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728041242.187380-6-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
 <20260728041242.187380-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:25:18 +0000
Message-Id: <20260728042518.899B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly introduced `preps` list in `struct damon_probe` is not=
 synchronized during `damon_commit_probes()`.
- [Medium] Missing public API to remove or destroy individual `damon_prep` =
instances dynamically.
--

--- Patch [5]: [RFC PATCH v2.2 05/17] mm/damon/core: introduce damon_prep s=
truct ---
commit d7a749334ed0e3303b955b00673d30f87ca5091c
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_prep struct

Some DAMON probe filter types require preparatory actions to operate
effectively, such as setting the PG_Idle flag at a specific time. This
commit introduces a new data type called damon_prep to specify these
preparation actions for each probe. DAMON will execute the action for
each region per sampling interval.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a8bb9ee6979e3..1a8de735f955b 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h

[ ... ]

> @@ -780,6 +801,8 @@ struct damon_filter {
>  struct damon_probe {
>  	unsigned int weight;
>  /* private: */
> +	/* Preparation actions to apply to each probing memory. */
> +	struct list_head preps;
>  	/* Filters for assessing if a given region is for this probe. */
>  	struct list_head filters;
>  	/* Siblings list. */

[Severity: Medium]
Will this preps list be synchronized when a DAMON context is updated or
cloned?

Looking at damon_commit_probes() in mm/damon/core.c, it only seems to copy
the weight and filters from the source probe to the destination probe:

mm/damon/core.c:damon_commit_probes() {
    ...
    if (src_probe) {
        dst_probe->weight =3D src_probe->weight;
        err =3D damon_commit_filters(dst_probe, src_probe);
        if (err)
            return err;
    } else {
        damon_destroy_probe(dst_probe);
    }
    ...
}

It appears there is no logic to copy the new preps list. Could this leave
the running context's preparation actions out of sync and silently discard
configurations when damon_commit_ctx() is called?

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..0b396c2456d05 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -111,6 +111,28 @@ int damon_select_ops(struct damon_ctx *ctx, enum dam=
on_ops_id id)
>  	return err;
>  }
> =20
> +struct damon_prep *damon_new_prep(enum damon_prep_action action)
> +{
> +	struct damon_prep *prep;
> +
> +	prep =3D kmalloc_obj(*prep);
> +	if (!prep)
> +		return NULL;
> +	prep->action =3D action;
> +	INIT_LIST_HEAD(&prep->list);
> +	return prep;
> +}
> +
> +void damon_add_prep(struct damon_probe *p, struct damon_prep *prep)
> +{
> +	list_add_tail(&prep->list, &p->preps);
> +}
> +
> +static void damon_free_prep(struct damon_prep *p)
> +{
> +	kfree(p);
> +}

[Severity: Medium]
Should there be a public API to remove or destroy individual damon_prep
instances dynamically?

Since damon_add_prep() is provided to dynamically add preparation actions
to a probe, it seems there might be a need for a corresponding
damon_destroy_prep() or damon_del_prep(). Without exporting such functions
and with damon_free_prep() restricted to static scope, is there a way for
API consumers to dynamically remove or free a prep without destroying the
entire probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728041242.1873=
80-1-sj@kernel.org?part=3D5
