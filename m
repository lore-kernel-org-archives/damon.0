Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023891;
	b=b+2WZ+p9/mg7fGFPvCI+FSBfz/1diPj50peaet5OKSn3ChX3jq4f8AtKWNNbtTxRWn49
	 qeGhLWplqxtsRgPMPAZqX6WsPvALxmAbTHu1zd1z1BouKYYZih0O/aEzTjIYKXOkHKTem
	 KpNoSLrKC0MwWsiTsNfaQUSofZqyh07BgB3XFb/XOc01iwFZDe7oqydXxTSmCbPXKKSZp
	 vJV8vI6U8JNziXnspI6uanb0GOte3w7mKq1hBbZzUFcskKwlTc6cWX5TD/C0ABAg1tYl1
	 M7E6Em8rqv3vPsk5N6kPxnvFU+AAr2Ew0esAACPjxjvfN+WTSWAAC9TDgsnj24enpXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023891;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b1z6uUx4ZdMo2N5+aoAcDCMioFr0x+B/lAmEEynuZSk=;
	b=0gpiWOG2MDrubYHvezdawwtus+KOEka6u6I5RUW2fUR0twBx4FKXEYZNfhdmrFBGQHAF
	 dCZjR811Jdw/4BPYpSVwQzgxUGB/EbQ//0ECtLAIduR+9Ucm5pt7YhwLTEn46qPsUcYAh
	 pvbptGfG5jV2O4CAquVZ22QGIdUrjj6T2gtW00638zqXJQLfHQjJwsXJ4OnnT8VPbjl8i
	 i15udJ6Joa4zCx9SFQpYprrZb9WswQsWZW2QTrNCySYRLiosT4ObJo5BL34YEVGudurmz
	 war2JL3wGbb0JF3D71OVoqj4aAg4W0Zq6J4avkdSr4nKVUEZelW1UK9l33cprLG2Mxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ip6XgOhe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142A606A31A
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ip6XgOhe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F2E1F01828;
	Mon, 26 Oct 2026 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793023891;
	bh=b1z6uUx4ZdMo2N5+aoAcDCMioFr0x+B/lAmEEynuZSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ip6XgOheGZu2j4YrE8jAzgPZ+SjimhRitLbh3QzOKUEj+yEGJFz5C1OwMD3qz+TmB
	 GelXorRMy2PlR5g+G2HF3N1AmCrdiT31xCq9bxJM/fbDMc/Z0EAqk//AnJrRD1Fi+O
	 Q7UPbG7iR7uTHL+kxiI2b93UptBMFo4pX46xpWl3XEnKG4PzmZVSGTymS9keFynLoi
	 h2/DtRx4PzAoC2mXfQEiUwcgChce9ee0M45wTnCnt90NlorIu0e8rsebicIhPndvqN
	 SvXAJDrUqSYKmoDJ4UUF3806BPUYOV+3jl+qpJRRjZtkBcClc65W2hEFdmJCl5JMR0
	 rCNc8R9OYEA2Q==
Message-ID: <sashiko-outbox-185379@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.12.y v2] mm/damon/core: error
 damos_commit_quota_goal() for zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261026135555.149244-1-sj@kernel.org>
References: <20261026135555.149244-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 14:11:30 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/damon/sysfs: pid leak in damon_sysfs_turn_damon_on() on inval=
id start ctx
--

commit dc23c827b1a01b5ed768b0a218bb6a67def40106
Author: SJ Park <sj@kernel.org>

mm/damon/core: error damos_commit_quota_goal() for zero target_value

This commit validates that DAMOS quota goal target_value is non-zero in
damos_commit_quota_goal() and damos_commit_quota_goals() to prevent a
division-by-zero error. For the stable backport, it also adds
damon_sysfs_valid_start_ctx() to reject zero target_value before starting
DAMON in damon_sysfs_turn_damon_on().

Link: https://lore.kernel.org/20260903010722.94244-1-sj@kernel.org
Link: https://lore.kernel.org/20260903010722.94244-2-sj@kernel.org
Link: https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org [1]

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 5aa23c6545cb8..2c8749b62c621 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1497,6 +1497,20 @@ static struct damon_ctx *damon_sysfs_build_ctx(
>  	return ctx;
>  }
> =20
> +static bool damon_sysfs_valid_start_ctx(struct damon_ctx *ctx)
> +{
> +	struct damos *s;
> +	struct damos_quota_goal *g;
> +
> +	damon_for_each_scheme(s, ctx) {
> +		damos_for_each_quota_goal(g, (&s->quota)) {
> +			if (!g->target_value)
> +				return false;
> +		}
> +	}
> +	return true;
> +}
> +
>  static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
>  {
>  	struct damon_ctx *ctx;
> @@ -1517,6 +1531,10 @@ static int damon_sysfs_turn_damon_on(struct damon_=
sysfs_kdamond *kdamond)
>  	ctx =3D damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
> +	if (!damon_sysfs_valid_start_ctx(ctx)) {
> +		damon_destroy_ctx(ctx);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Does this error path leak the target struct pid references (t->pid) when
damon_target_has_pid(ctx) is true?

When damon_sysfs_build_ctx() constructs ctx via damon_sysfs_apply_inputs() =
->
damon_sysfs_add_targets() -> damon_sysfs_add_target(), it acquires a struct
pid reference for each target:

mm/damon/sysfs.c:damon_sysfs_add_target() {
	...
	if (damon_target_has_pid(ctx)) {
		t->pid =3D find_get_pid(sys_target->pid);
		if (!t->pid)
			goto destroy_targets_out;
	}
	...
}

Because damon_sysfs_valid_start_ctx(ctx) fails before damon_start() is
called, kdamond never runs and ctx->callback.before_terminate
(damon_sysfs_before_terminate()) is never invoked to release those
references. Calling damon_destroy_ctx(ctx) invokes damon_destroy_targets(ct=
x),
which frees each target without calling put_pid(t->pid):

mm/damon/core.c:damon_destroy_targets() {
	struct damon_target *t, *next_t;

	if (ctx->ops.cleanup) {
		ctx->ops.cleanup(ctx);
		return;
	}

	damon_for_each_target_safe(t, next_t, ctx)
		damon_destroy_target(t);
}

In comparison, damon_sysfs_commit_input() cleans up an unstarted context fr=
om
damon_sysfs_build_ctx() by calling damon_sysfs_destroy_targets() before
damon_destroy_ctx():

mm/damon/sysfs.c:damon_sysfs_commit_input() {
	...
	err =3D damon_commit_ctx(kdamond->damon_ctx, param_ctx);
	damon_sysfs_destroy_targets(param_ctx);
	damon_destroy_ctx(param_ctx);
	return err;
}

Should damon_sysfs_turn_damon_on() also call damon_sysfs_destroy_targets(ct=
x)
before damon_destroy_ctx(ctx) here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026135555.1492=
44-1-sj@kernel.org?part=3D1
