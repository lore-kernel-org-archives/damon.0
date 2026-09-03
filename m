Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A711A5B9D
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398182; cv=none; b=a3kzlgG1adsgirX9/0PCP/5GvXPqEw4RKpyJ7kZsdUEbAYrb5uCw5CJe2/qX1PiusRTBxqXBc3AkkaBWgP9IGH+LRvH8vU90gEVqtBzhRkovl8b3TfUvmt0+6kvOPZoHu4Vu1dGG5c2N0s8Mo+QqKlikUYliRo2NbVkMNvTfdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398182; c=relaxed/simple;
	bh=IbXtv9HybrWtAdH92ChDru812hi24KdntAfJsE1p854=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMUBMEh4hQYcVyqlJX6x7ngaG6sph0fZhlAM7G9ScBS4FbVNctedxEgeEQdjNiiJUfPTyjueaNyvkEWV87JNdhL5980fUZe/dO06U/pSZcMYPC012MI4Tuy4QxYSdB3LR0fcDG5FE3+iECqgUBml+T439Ba5ODYWNdgnfEDUkrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkn9pNpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkn9pNpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D8C1F000E9;
	Thu,  3 Sep 2026 01:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788398181;
	bh=FxIlq6MEIFR5Oif+IgQ1CFSLZmfdGzVq7acmESFj5XA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fkn9pNpc4oj+3kXuSla5CULyWWqTowqmBIhVBYnOSaOF/litwny3NoiXz4w9zTsS1
	 o87DsKas7NHb6EMbtnTLvkr/iJ6pr7B7TDOyW5dirh0NLytCXRzbvXtDYvCqpffPn7
	 GyeiCllNMS9wl3+MLMQ3gtAlIZFKTyQISYMkg/fWWDMzLP7X1yhFK8l2FxKM3TJoqD
	 vEmXQZ/pkBvYXKvFdXXoy1GpGvzi5gv1GjIRuA/rN8TZmsF6gk41OnVpX7fYV6iv2a
	 MyCmLhM9GH7K+R2hDOJGrUMBBLkAa8cnttafY9gxSe+jX/4taeBqIylXfholhN80j6
	 rdXYwhUZgNFKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] mm/damon/core: set ctx->call_controls_obsolete in
 damon_new_ctx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260903010334.93622-3-sj@kernel.org>
References: <20260903010334.93622-1-sj@kernel.org>
 <20260903010334.93622-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 01:16:20 +0000
Message-Id: <20260903011621.29D8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch correctly fixes an indefinite wait vulnerability in damo=
n_call() by initializing ctx->call_controls_obsolete to true, but fails to =
initialize the identical ctx->walk_control_obsolete flag. This leaves damos=
_walk() vulnerable to the exact same indefinite hang if called on an unstar=
ted context.
--

commit 55412502962e64df1de83b2c9805595450e93fc7
Author: SJ Park <sj@kernel.org>

mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()

This patch sets ctx->call_controls_obsolete to true in damon_new_ctx() to
prevent indefinite hangs when damon_call() is used on an unstarted context.

Link: https://lore.kernel.org/20260803134646.16640-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f1f007d8dd1d9..610556abb129e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -933,6 +933,7 @@ struct damon_ctx *damon_new_ctx(void)
>  	INIT_LIST_HEAD(&ctx->adaptive_targets);
>  	INIT_LIST_HEAD(&ctx->schemes);
> =20
> +	ctx->call_controls_obsolete =3D true;

[Severity: High]
This is a pre-existing issue, but does the same fix need to be applied to
ctx->walk_control_obsolete?

Because walk_control_obsolete is zero-initialized (false) by kzalloc_obj(),
calling damos_walk() on an unstarted context will bypass the obsolete check:

mm/damon/core.c:damos_walk() {
	if (ctx->walk_control_obsolete) {
		mutex_unlock(&ctx->walk_control_lock);
		return -ECANCELED;
	}
	...
	wait_for_completion(&control->completion);
}

This could lead to an indefinite hang in wait_for_completion(), since the
DAMON worker thread is not running to signal the completion. Should
ctx->walk_control_obsolete also be initialized to true here?

>  	prandom_seed_state(&ctx->rnd_state, get_random_u64());
> =20
>  	return ctx;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903010334.9362=
2-1-sj@kernel.org?part=3D2
