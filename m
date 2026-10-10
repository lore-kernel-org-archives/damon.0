Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B131EB5CE
	for <damon@lists.linux.dev>; Sat, 10 Oct 2026 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614762; cv=none; b=k7PXmlnzoFdvF4M7fgpiv0L5qPq60ABdkHK5t21IkcR3dJaXscMcvEb3DHReAWTMbhhMN1BLtu/eY2jw468ksCH9j38pcnP9/ENLaRCAuMi1l7/8MTulZgE4rtHc8FMf0bHp4NXtrhNKwo09MayAG2K9bIcjYiVSEbd1tLxt9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614762; c=relaxed/simple;
	bh=EVdHDA1UPRSt6E10nIwTGnKJmzo0mzjV6/CcFxODIL8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VFtrInaljqR6dvNaISSc8Da0ayhrFauUA7JkEusEMkqonC7ywq4qjR6fFJxmBvL1HcLNmDinTdWbYgvrb47brldiOQTYizAtTzL2b0YfjJ89Q3WEfqiZc+mmRCiLHYJ6n/W86lqU+LlMQkH4iYF1XSIXpHSnwMhBkpuG+apRjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GONpC1SK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GONpC1SK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400421F000FF;
	Sat, 10 Oct 2026 06:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791614761;
	bh=cIBZRmo6myNW3ZV4pHWrFnaWj3yujH8iqdGH+icHZwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GONpC1SKgP30O1aV0EDzx90Ti9LzhtKP/ZGEjpJWfX5QuWJ1buDnRng/AF0k5DYlL
	 L4bYZEQUl5tihkU8jyt6DT2tF82WXRsEj2dioso3eQbBhn5g529akDpW947EPyeAC1
	 522I1oRCDy2laPbQF1NTC/iVOrQ5MfKou2sMCnbeAJxYRz+a8JrRsppO7VZ3gquhl+
	 Rh6ecCD9s7Dc/cu5wHJECdI2l2hxxinHy67RLjj3gnhCuffLOebzKyZRopPzWa01s1
	 dmUbOLati1QQDpqNqJ7LSMNhgyi7PBynKMfSAkoinRbf4DTYLOZM8PSz51TL4Yy830
	 jC7Xx9BPDZyNg==
Message-ID: <sashiko-outbox-166285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y v3 2/2] mm/damon/core: fix unconditionally skip
 last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261010063042.8611-3-sj@kernel.org>
References: <2026092949-surpass-thimble-02a8@gregkh>
 <20261010063042.8611-1-sj@kernel.org> <20261010063042.8611-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 06:46:00 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: damon: use-after-free and permanent scheme disablement on targ=
et destroy
--

commit c97d3ff78284ee81310d99deee85b79f32b561d5
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix unconditionally skip last region

Once quota set, the charge_{target,addr}_from unconditionally skips and
resets at the last region of the tracked target, so the last region can be
skipped even when it has not been processed.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b5c85e6488596..1b9fb00405cfb 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -768,14 +769,11 @@ static void damon_do_apply_schemes(struct damon_ctx=
 *c,
>  		if (quota->charge_target_from) {
>  			if (t !=3D quota->charge_target_from)
>  				continue;

[Severity: High]
Does this code have a use-after-free and permanent scheme disablement issue
when a target is destroyed?

If the user dynamically removes a target via sysfs, damon_sysfs_set_targets=
()
calls damon_destroy_target() which frees the target memory:

mm/damon/sysfs.c:damon_sysfs_set_targets() {
        ...
		} else {
			if (damon_target_has_pid(ctx))
				put_pid(t->pid);
			damon_destroy_target(t);
		}
        ...
}

mm/damon/core.c:damon_destroy_target() {
	damon_del_target(t);
	damon_free_target(t);
}

Existing schemes are updated in-place via damon_sysfs_update_scheme(), which
does not clear the charge_target_from pointer, leaving a dangling pointer in
the scheme.

Immediately after, when kdamond_apply_schemes() runs in the same thread,
damon_do_apply_schemes() compares the valid remaining targets against this
dangling pointer (if (t !=3D quota->charge_target_from)). Since it does not
match the remaining targets, it unconditionally executes continue, skipping
the scheme for all regions.

Because a matching target is never reached, the pointer is never reset (the
code cannot reach the clean_charge_from_skip label). This results in
permanent disablement of the scheme and persistent use-after-free compariso=
ns
against the dangling pointer.

> -			if (r =3D=3D damon_last_region(t)) {
> -				quota->charge_target_from =3D NULL;
> -				quota->charge_addr_from =3D 0;
> -				continue;
> -			}
>  			if (quota->charge_addr_from &&
> -					r->ar.end <=3D quota->charge_addr_from)
> -				continue;
> +					r->ar.end <=3D quota->charge_addr_from) {
> +				skip =3D true;
> +				goto clean_charge_from_skip;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010063042.8611=
-1-sj@kernel.org?part=3D2
