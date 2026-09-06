Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B66391E51
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721113; cv=none; b=Yss6KcocVv5Y85jP1YAVqqxekHy/D4LppAVNykWkVxiIZNHKNQ2gnwMlDu25IVr52zYCuoJi9W63T6gLJ6PG+B9FF0CsOE9sYyPgHkVOVDPIDxP5IkeP3m5JcZHbsqs2v9S6HRCYeqV8gDPDtnYnEhCxPfwNqG8TnR+N7198lSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721113; c=relaxed/simple;
	bh=ZbLWwTK/Jocu6SkRAujFQLJHSax5lQt5E0TCJgEZqGk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=atKCcgvqpzngdBRn4+vvj48sBYLqucwBy9Z5sT9g8PNOnfsbH7n+rvd1Kfrmesx9qxDowTnREa0DodhS8yuBd8jUY/01nFB3tfUeBTrg3klwiDQTo89M+YQFYkHqIuMEE4QhJx8+2tDgyYYjUpj5e9c46wSPQPaLmuLeuMuy9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI23hwnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI23hwnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535EB1F00A3A;
	Sun,  6 Sep 2026 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788721111;
	bh=20XEzvUQf9yxkzJzWRD9FiWO05u5w9/aMYKCYLAvJng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JI23hwnzUMRM0pa9enUFI3gfaH0Q/ldpzweSfZk0sjGGQgSjBj3PXW0xe+gvVy1Fr
	 mKJiqkfg/JciOO9Arp4onn7su5/pjn/+HPygswe8eXLXKcj+eQy27kZnZm5F3uC6w/
	 UDgVMQXJ7PdP/olaHhsc8UZWeWKDjApnEbiz2uiEX6dRbqa6FSOdq+B9AO0BplUngc
	 2vOIy6istHWNgAQdJLbXVQc8cDPLgx5BnNIIi+3Ep6QlJJabVEnQkbGW1nemwJivbF
	 gxVSlrWff2EzaTfIYCf6vLEjZy74LQs5cQkySRs7AlhNot+X5epGfplNuwI2BlbpGw
	 Hi8iMoJkeQ8UQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: reset invalid
 quota->charge_target_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906183654.95634-1-sj@kernel.org>
References: <20260906183654.95634-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 18:58:30 +0000
Message-Id: <20260906185831.535EB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The new `damos_reset_invalid_charge_target_from()` function fails =
to reset dangling `charge_target_from` pointers for PADDR operations, perma=
nently breaking `damon_reclaim` functionality across restarts.
--

commit 6f10f4f2fc1ae76229671b5157f9aa34aed9227b
Author: SJ Park <sj@kernel.org>

    mm/damon/core: reset invalid quota->charge_target_from

This commit fixes an issue where DAMOS suddenly stops working if a target
process that a quota just fully charged in is terminated. It catches this
corner case and resets the invalid quota->charge_target_from pointer.

Link: https://lore.kernel.org/20260830064708.40CA61F000E9@smtp.kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ce8c6f99106ed..2c58be9edbde4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3283,6 +3283,22 @@ static void damos_trace_esz(struct damon_ctx *c, s=
truct damos *s,
>  	trace_damos_esz(cidx, sidx, quota->esz);
>  }
> =20
> +static void damos_reset_invalid_charge_target_from(struct damos_quota *q=
uota,
> +		struct damon_ctx *c)
> +{
> +	struct damon_target *t;
> +
> +	t =3D quota->charge_target_from;
> +	if (!t)
> +		return;
> +	if (!c->ops.target_valid)
> +		return;

[Severity: High]
This is a pre-existing issue, but by returning early here, does this new
function fail to clear dangling charge_target_from pointers for PADDR
operations (like damon_reclaim)?

If damon_reclaim is enabled with quotas and hits quota exhaustion,
quota->charge_target_from is set. If damon_reclaim is then disabled,
damon_stop() destroys the targets, leaving charge_target_from as a dangling
pointer.

When damon_reclaim is re-enabled, a new target is created. Because
target_valid is NULL for PADDR operations, this new function returns early.

Could this lead to damos_skip_charged_region() comparing the new target
against the dangling pointer, evaluating to true, and permanently skipping
all memory reclaim actions?

> +	if (c->ops.target_valid(t))
> +		return;
> +	quota->charge_target_from =3D NULL;
> +	quota->charge_addr_from =3D 0;
> +}
>
>  static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906183654.9563=
4-1-sj@kernel.org?part=3D1
