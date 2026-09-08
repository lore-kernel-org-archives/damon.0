Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC055D866
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876469; cv=none; b=ie0Xy+R4ZaOS70SBTUsZ0vKsC8EaCEdtMjgk0Bs/+Rcy2h9l/piSU/A7qen+gSayCoP7oSy/hdm5M70Zoq6t65wTl0sU8IDEtvYJN36Gr427LzugFQfn6rWMPOg3jWTqg0cnMd8Cg/vNjb7a/bfkOS/WwyD9S9MoqPIo4bWosNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876469; c=relaxed/simple;
	bh=SHHwwrDrhd+0jok6eY/88JkufPRJaqEVUuHeN8qGUo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TDNpL5Kfn1PoJnDeAq9X4ZHAoUSPwS9lczDWJn8StfqTd9BC8OcCYo/BLJzjQBBPGFD8dMHNLqsFqm+VNiQajbO99mqVT/9q5UjaJ/Y13ZPWbykWvWK4XTGZkofuwkEspFYv/41lPGQlskJAQCYvm2PcrUN41gnlZVQzYd+evXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps5+oEkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps5+oEkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2022F1F00A3E;
	Tue,  8 Sep 2026 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876457;
	bh=UU6rXakTu+1z0o/IlHVnFcO9HDStZqrIcezKBDrgTtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ps5+oEkVMKr39WAolqzQqT4jP5cCZWw9GwJvlYK0bDIyv3hZHx//Ze3WZbwirerpS
	 9gNrCT/eIpYdVYSoXlzCRWOZLdgTp6MC3OkdX4bisvIiH5sjG6OGgfZIPQPWut2Yas
	 cSzqybnRDuaV4HdpKZ7thIeZrUOmmf1xzWZBSp8jPbKHPp1i43lyUoQLCVrq16UNpc
	 b0hS67qxZzi0fUYaz5QHzYqrWbBMfkPUgngz64Y+1xOQkkPbtTUoFHRmPnUPTcSKGy
	 3+59fz2Kt7MNSKq2rI5kQCgZIkwlEzLU5Myn9vCVuP6RDwX8d97p4gYXIRp3wMqxRw
	 uipC9tEh/lPQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm/damon/core: fix unconditionally skip last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260908134739.96919-1-sj@kernel.org>
References: <20260908134739.96919-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:07:20 +0000
Message-Id: <20260908140737.2022F1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Quota tracking pointer `charge_target_from` can get permanently st=
uck if its corresponding target becomes invalid, freezing scheme applicatio=
n for all subsequent targets indefinitely.
--

commit 4d9a4144cc83637a927f5110bc1cc97f4064d9e8
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix unconditionally skip last region

This commit modifies damos_skip_charged_region() to only reset the quota's
charge_target_from and charge_addr_from when the last region is reached.
It ensures that the last region of a tracked target is only skipped if it
was actually applied or cannot be split.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ce8c6f99106ed..89d1c77417450 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2452,36 +2452,39 @@ static bool damos_skip_charged_region(struct damo=
n_target *t,
>  {
>  	struct damos_quota *quota =3D &s->quota;
>  	unsigned long sz_to_skip;
> +	bool skip =3D false;
> =20
>  	/* Skip previously charged regions */
>  	if (quota->charge_target_from) {
>  		if (t !=3D quota->charge_target_from)
>  			return true;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
quota->charge_target_from to remain stuck indefinitely if its corresponding
target becomes invalid?

Looking at kdamond_apply_schemes() in mm/damon/core.c, if a target becomes
invalid, it is skipped and damos_apply_target() is never called for it:

    damon_for_each_target(t, c) {
        if (c->ops.target_valid && c->ops.target_valid(t) =3D=3D false)
            continue;
        damos_apply_target(c, t, max_region_sz);
    }

If the previous quota window ended with quota->charge_target_from pointing
to this now-invalid target, wouldn't the 'return true' here in
damos_skip_charged_region() cause all regions of all subsequent valid targe=
ts
to be skipped?

Because the invalid target is never processed, t will never equal
quota->charge_target_from again.

Does this mean the pointer is never cleared, freezing scheme application for
all targets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908134739.9691=
9-1-sj@kernel.org?part=3D1
