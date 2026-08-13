Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1EE345CDD
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593729; cv=none; b=VTysPiHvCMCjxd6YecF8cLtdFSXkZH8S4mUWhp7XF30ZbWwAb8icGKeLO0lc14JX3bexWgy5aZyjOfXafoIJOyYdTUqa2/UTL8YNh5dNuRXt/IwLsQPAfX8rVA3mfFssj38C2ZovuNp8Vsmb0B3IacuKmF00b6QfIVY7QttbJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593729; c=relaxed/simple;
	bh=OConATu4HVSrEkDh4PaoIlqmdeHqqY+Fv2m3kuwKaSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NSW7DlI0hvO/kBBe6ru3bUT7OcZDV9vYXiBL2kUjzk1Vx8iGacR2jZcMNJwpBmFG907UpTEQ3DD53BBAelB1S8qdEhPiTd52mQwg8Mc9r76ct8U/8Lyu00b49gYAiVWsbsRW2fnCsalzovDmaGjXvbeDzzklB4W4PN9F6Po/UTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqHhqRlv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqHhqRlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A046E1F000E9;
	Thu, 13 Aug 2026 04:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593728;
	bh=LrCuu0/jGaLwdV+0t5QH8saCgy2wcf4Lg74pAKTKBY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KqHhqRlvSeOVIMrKwvoJB2Z4gXjYMq5XLKJHIi/TtVUvFfxt2R3gWwtIUu5lvu+Pk
	 RDCDkVPDnK9LlLjEhSg3lTcDQnPVsHEGBOIzI7NVPsJlVzw8v8MfR46AgJpMm6oeiF
	 qxMN2jQ6BWnVLzWNJYJ1IO7iYqLDT/v2rHBDIapmGkpXU8uUYlHNg6PkH+dUd07vxk
	 TwHlRbGPjedXfnfxWFcwrv+j7wgMnCy67a6NzzddB1tI4sb0/yWhgiqVBQfpdPpVu4
	 7QcUqm15t9ch1I4Up9pjwBgPPRfOeeUnxJKxu++TiWfqdNRD2JI03c7v6A//SKn4UG
	 DIVos+9WKHR9A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] mm/damon/core: set ctx->call_controls_obsolete
 in damon_new_ctx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260813035001.97364-3-sj@kernel.org>
References: <20260813035001.97364-1-sj@kernel.org>
 <20260813035001.97364-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 04:02:07 +0000
Message-Id: <20260813040208.A046E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces an inconsistent state in the `damon_ctx` AP=
I by initializing `call_controls_obsolete` to true while leaving its identi=
cally-designed sibling field `walk_control_obsolete` as false.
--

--- Patch [2]: [RFC PATCH 2/4] mm/damon/core: set ctx->call_controls_obsole=
te in damon_new_ctx() ---
commit 94c12d6bfcca8f83b408960a36d0c0a8519d80c7
Author: SJ Park <sj@kernel.org>

mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()

This commit addresses an issue where passing an unstarted DAMON context
to damon_call() can cause an indefinite hang. It fixes this by initializing
ctx->call_controls_obsolete to true in damon_new_ctx().

Link: https://lore.kernel.org/20260803134646.16640-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index af7b77710745d..5080cb12220d2 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -864,6 +864,7 @@ struct damon_ctx *damon_new_ctx(void)
>  	INIT_LIST_HEAD(&ctx->adaptive_targets);
>  	INIT_LIST_HEAD(&ctx->schemes);
> =20
> +	ctx->call_controls_obsolete =3D true;

[Severity: Medium]
Should ctx->walk_control_obsolete also be initialized to true here?

Because walk_control_obsolete is zero-initialized to false during allocatio=
n,
an unstarted context passed to damos_walk() will bypass the obsolete check:

mm/damon/core.c:damos_walk() {
	...
	if (ctx->walk_control_obsolete) {
		mutex_unlock(&ctx->walk_control_lock);
		return -ECANCELED;
	}
	...
}

This appears to leave damos_walk() vulnerable to the exact same indefinite
wait_for_completion() hang on unstarted contexts that this patch resolves f=
or
damon_call().=20

Does it make sense to update walk_control_obsolete alongside
call_controls_obsolete to ensure the API behaves consistently?

>  	prandom_seed_state(&ctx->rnd_state, get_random_u64());
> =20
>  	return ctx;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813035001.9736=
4-1-sj@kernel.org?part=3D2
