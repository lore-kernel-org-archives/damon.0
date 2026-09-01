Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5724CCDF0
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237963; cv=none; b=oaZQ5VSiidggLiKXiX3KQnCYKprqnrU4IJPjX3Go8V/9aqrogGUU1io6fLI7/sLTz3Bn2wszN9gUh46i/7xcS3gGEgJzwZF48rYpv2JyxkaUgK0BSxemCEjP41qE4DgvxNICN3p6K1XCeUGdq+HFX1g19ZYgzUIER75S8tO6v5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237963; c=relaxed/simple;
	bh=DYybcLlaM1rE9EUnKOU7NR5P+lacVBLAG3lint6rDsw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VqTjy7kbNId+axEKM463g/VfaVpN5c2LC4e5gr+G7U1iS/s5taUTahxkv+og+t4O3hss317J/6icEFY7p8IXrij8eVOJYc8XqVjKa1hLlkMQtdebH63Diq036uPG7ZM9VWlH9ZZKb3toPqjajIUOMPH5J/cuY5UTHiFPQUnmvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCcVRFpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCcVRFpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FCA1F00A3D;
	Tue,  1 Sep 2026 04:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237961;
	bh=sEBOYzbljhMtSjuVgTrel9F+AO/6LAqqAfamzwiLZSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KCcVRFpasZjCxFzIQYQqozA0O+gP8znjnR3257GzlpARNInsmfWmt3r+MtITsSW9v
	 fG3iuXO1+ofLxXeqGegB43OYh546y7DjkDi5uvGCO2sCTHxFq8uQMjWVDzYxEPoQl1
	 k+PdEl3daGKqOrnxdQWO7n3PxAIYo1TEB+inDD2J3i0L4EGsHmn13iGWhQV5Gk+68I
	 ut0UCGP72uJSRxgHI6VO8qJbxTDRp3K89eyBnn7EjgmlycfO7bOaWaU2W9BwZQwncl
	 Bf+1PjeyydeTkPXHrSjNOqHYVBFyVQrvZYus5KRlEPSYWoR9l0ki/nbej+iu9ANCGC
	 coXLq3gkndcQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/17] mm/damon/core: introduce damon_prep struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-6-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:46:01 +0000
Message-Id: <20260901044601.B5FCA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing exported cleanup API for `struct damon_prep` leads to broke=
n abstraction on error paths.
--

commit 046989ba790c1b12be9fe4a07f46c502a62eeb7b
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_prep struct

This commit introduces the damon_prep data structure to specify preparatory
actions for DAMON probes. It also adds DAMON_PREP_SET_PGIDLE as the initial
preparation action for access monitoring.

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

[Severity: Low]
Is there a missing exported cleanup API for struct damon_prep?

Since damon_new_prep() is exposed for external modules to allocate a new
prep structure, do they need a corresponding exported destructor (like
damon_destroy_prep()) to clean it up if an error occurs before it is
attached to a probe via damon_add_prep()?

Currently, damon_free_prep() is static, which forces any external caller to
manually call kfree() on error paths, potentially breaking the subsystem's
abstraction.

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D5
