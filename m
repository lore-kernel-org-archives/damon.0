Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC82221DB3
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777355344; cv=none; b=YBHBrnvFDiim3SVIxLXoXXBPiTTbvJ3fcYBXjDXYahIk1l3LVvYA52AS8F9ZBdDvm3EfdfBAJzgYMvHB6tdpz3zEH8CRtTXFXblUM6fV87bjqPnswIFxEVrcxBbhYVwe1c3IAiofp6pdBC6akpX6j/sB8nT6NyvzWy9Co9i+x9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777355344; c=relaxed/simple;
	bh=N8XuuUOvPNkqSlmL9ZZTtiN0wBCVeG8h18A63HMQYto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bRssvBMYZkoQ1BHaKs/xLBGrA81uBxl4TwZhTcsrdNlyDqZ20LzKUUlKXNl8w4KVPgqH0wDSBuRr/c4xOenNxdzgv/AW0SBg/0qHR4ImkmN2ItAxr8QSSwUmpWOmwkWjTOZGuIOSbHf4O/Rj739aKRaH9H9C+3DKkZuM/3BwG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7OZHiHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7OZHiHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6110C2BCAF;
	Tue, 28 Apr 2026 05:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777355343;
	bh=N8XuuUOvPNkqSlmL9ZZTtiN0wBCVeG8h18A63HMQYto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=p7OZHiHqfBSEO0jMYL+ksu22OoONeEeA6d1YcCJzTO7d+GugES6WoccwLn2gYzG2e
	 eHQ3HH+w4EmW5Mdd+7/1DFQJCB+VwkHg7G9mEtR1+1xK50QyO9XVPXuVFuZKkhnRt2
	 L/aTz0XkDwprwymOtalOcr7Ut2f/uvRnF+XZuXpgfnn2Wxsf9DRD8ROpV5jvSXDAig
	 jOfKPttT/iy962lv/PW4CHaZe+nqF0iW3tN/+WAFDO1mmQncfzM+hUnu/n1VaN16/9
	 mM/KTf40SmOU8pyuViGsTfvU0Xwsb5R1xDrR+vAWe63i98NyWms0CbEbYtNvzaSv9u
	 U1Gb3PBOltWnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: make charge_addr_from aware of
 end-address exclusivity
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260428042942.118230-1-sj@kernel.org>
References: <20260428042942.118230-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 05:49:03 +0000
Message-Id: <20260428054903.A6110C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 3 potential issue(s):
- [High] The remainder of the last region of a target is unconditionally sk=
ipped during quota resumption.
- [High] Quota state is not saved when the remaining quota is less than `mi=
n_region_sz`, breaking round-robin fairness.
- [Medium] Setting `charge_addr_from =3D r->ar.end` causes resumption failu=
re when a region covers the end of the address space.
--

commit 50bbd8d578080e27beac4fe1ad0cecbb013a8fd7
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: make charge_addr_from aware of end-address exclusivity

This commit updates the DAMOS quota charge assignment to use the exclusive
region end address rather than assuming it is inclusive. This addresses a
bug where the action might skip the next memory block up to min_region_sz.

Link: https://lore.kernel.org/20260428032324.115663-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3dbbbfdeff71..901ffdaefb7f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2106,7 +2106,7 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  		if (damos_quota_is_set(quota) &&
>  				quota->charged_sz >=3D quota->esz) {
>  			quota->charge_target_from =3D t;
> -			quota->charge_addr_from =3D r->ar.end + 1;
> +			quota->charge_addr_from =3D r->ar.end;

Does this cause a resumption failure if the region covers the absolute end =
of
the address space?

If r->ar.end wraps to 0 (e.g., ULONG_MAX + 1), charge_addr_from is assigned
0. Since DAMON uses 0 as a sentinel value for an uninitialized state, the
checks for quota->charge_addr_from in damos_skip_charged_region() will
evaluate to false.

Will this completely fail to identify the resumption point, prematurely cle=
ar
the state, and restart from the first region instead of resuming?

Additionally, this isn't a bug introduced by this patch, but does the
resuming logic unconditionally skip the remainder of the last region of
a target?

In damos_skip_charged_region(), the damon_last_region() check executes befo=
re
evaluating charge_addr_from:

mm/damon/core.c:damos_skip_charged_region() {
    ...
	if (quota->charge_target_from) {
		if (t !=3D quota->charge_target_from)
			return true;
		if (r =3D=3D damon_last_region(t)) {
			quota->charge_target_from =3D NULL;
			quota->charge_addr_from =3D 0;
			return true;
		}
        ...
}

If a target's last region is partially charged and split during a window, t=
he
uncharged remainder becomes the new damon_last_region. In the next quota
window, when the loop reaches this remainder, will it immediately match the
last region check, clear the state, and permanently starve the end of targe=
ts
by returning true (skip)?

Finally, this isn't a bug introduced by this patch, but is the quota state
lost when the remaining quota is less than min_region_sz?

Earlier in damos_apply_scheme(), if the remaining quota is small:

mm/damon/core.c:damos_apply_scheme() {
    ...
		if (damos_quota_is_set(quota) &&
				quota->charged_sz + sz > quota->esz) {
			sz =3D ALIGN_DOWN(quota->esz - quota->charged_sz,
					c->min_region_sz);
			if (!sz)
				goto update_stat;
    ...
}

Does the goto update_stat bypass incrementing quota->charged_sz and saving
charge_target_from and charge_addr_from?

Because charged_sz never reaches esz, the loop will uselessly evaluate all
remaining regions. Because the resume state is never saved, will the next
interval incorrectly restart from the very first target and region, breaking
round-robin fairness and starving later regions whenever the dynamically
calculated quota is not perfectly aligned?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428042942.1182=
30-1-sj@kernel.org?part=3D1
