Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131125C6EE
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 03:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925514; cv=none; b=CA1m41cCBBMA21ayEYrPsaS53x4xIffjADpAKXLGd3dQzmT9hCr9gkVxhX5V6roZ7/Xai4Pw+5fHWiLSuMaRZ72s16+oLflJIzhbnl5thy4PVyaDpOnzOMAaPvXPqRRNLOPvycQgWgEBTuUFw9hp4HyXgVurtqmis2Yf67pB81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925514; c=relaxed/simple;
	bh=/QcKdasEK07oZkQAV8bDKRTF8PaeM3hE3khVS1nTviA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sXXHmMOjXQUT7c01I20oeyAvjLda0sLGA/EqkysrcPRRLN9d5KWcjbfWs4QAjpb3vv6hWAnnqT5WfWE9ZmnHRATehtnBzeGDOFWjdqllyY68S5/FbG/aCfg7qF1zc6UmNJLHuMMjEpgXWkZ7b7zkPiWSGpphxGbXJ1O60VmbGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI1jmX5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI1jmX5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311211F00A3A;
	Wed,  9 Sep 2026 03:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925512;
	bh=ub+YHoLaeXVEhlZwZE5gDA6w8P9veuDZSpdehqXahjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CI1jmX5re0ZET39kxF76vl9EsCaipbrIH4y0lLzodb7iUfq/FfrwgBVay6BuLr1dH
	 qQ/04vdr97Vr2Ns1l18JK06T8InQ4iH4APR54eKxwrrSZzUjXsOzU4TEwwDdw6XrnQ
	 6px4IrWzaUMHIrLcUAW1YYsr8tnLhpSiKMNtLo+ijgD+jDR7yt/VSf8eacfYzG/gdB
	 wrKUspYCzFfdIcaoM45dNAi+hMWpQA0C8Irm9XFdazNjlY+au1rttMOlVUm3PiU5lD
	 t0uwv6mdMv7YngOrKjmhrBs11lGtdg4qcW8MzAyyjvuU/ejLdOn+VIRXGvGqFaH2fJ
	 qaCJ7YjX/BJtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/sysfs: read ops_id only once in
 damon_sysfs_apply_inputs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909032830.119383-1-sj@kernel.org>
References: <2026090858-arousal-getting-ee35@gregkh>
 <20260909032830.119383-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:45:11 +0000
Message-Id: <20260909034512.311211F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_sysfs_apply_inputs() reads ops_id twice.  It could race with
> ops_id_store().  As a result, the min_region_sz could wrongly be set up.
> Read it once.
>=20
> The user impact is trivial.  Sane users ain't update the parameter in
> parallel.  Even if it happens, the DAMON core layer handles the wrong
> min_region_sz (!is_power_of_2()).  Even if somehow the race ended up
> making a min_region_sz that is different from the user's intention but
> still valid, only monitoring itself runs differently than expected.  No
> critical consequences like kernel panic or memory corruption happen
>=20
> The issue was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260715031002.108504-7-sj@kernel.org
> Link: https://lore.kernel.org/20260703172417.95426-1-sj@kernel.org [1]
> Fixes: 8d009da32f13 ("mm/damon/sysfs: set damon_ctx->min_sz_region only f=
or paddr use case")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 5adaaa28be8a79ddd7e103b171f9d6e14e7fc26e)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909032830.1193=
83-1-sj@kernel.org?part=3D1

