Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08E348465
	for <damon@lists.linux.dev>; Wed, 16 Sep 2026 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789532487; cv=none; b=fd7VTYGsLMDWag9R5SCXLPsgZut8xM45XAGKxZFB5PMMVde1Zrc58/I755YTu7lwUuJZ/kcJ59is56llAJnukXL+dY6E2SWFSmaIjMAq3bY3BYBgPiQXMN6/JPtf5kr/hdNwlldln4Auwvr143oGec4RyJZ7HTTU9/LNnnGar2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789532487; c=relaxed/simple;
	bh=rVDSw5ybonElAtv/dtHtxYGnAyLDgPG0+IhVF7C1p1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YGPS5OzxZWcmWdppoFZ/8Pia+6rAxBi2Jqaali6UxdxebRuRLKgG3F4HMro6fe+tJZKOgV2YB8monm33BM+4pDPaKbFZpb4AMHCQwGAVtHFZdp6VcgHEoR5rnQEPdB3AWScqNN769N9VmjKUFH1WESXjsdD+Y56t0n0Lx70da+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axaIZ76K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axaIZ76K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D6E1F000FF;
	Wed, 16 Sep 2026 04:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789532486;
	bh=8dFyDIMa+oUuHeqX/jVk1JPRNB9hgjiyE3nZmtDUuBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=axaIZ76K4hbGmxHyQx8Ov+WAxOSPX83BWvswvEAvEibOF1Qb2VFyZP1le1ZXRriJU
	 P+vykagB5G15EqIf7z6wOotnAfFdCIyYwrABDT8QPJTAC9ihovxrD7gZ3S2qyYcf4Z
	 6DaEXFYyJwlNEDR3afCjagg8ccY7euYLyJaeH0fLRPYhmh9qgpDmGLFVoJfO1Ii3NS
	 iZ7axVz7xnICR7ULgg7ZIEsSgUBYfYJJs9o1Lu7BIRcc1C3XDemAL3bQEKdn6cOvtl
	 h9Z6wwTMp5yvkzwsM6gv45odFNb5yMQrk5vb2ziPY7wKPkD3iX9+VnnoQxTyJ2I/lb
	 7syRZjGhopzag==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2] mm/damon/core: don't skip damos_adjust_quota()
 while esz is not zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260916041409.106926-1-sj@kernel.org>
References: <20260916041409.106926-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 04:21:25 +0000
Message-Id: <20260916042126.37D6E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMOS could unexpectedly stop working when a user disables quota using
> the online parameters commit feature.  Fix it by correcting a wrong
> quota unset check in damos_adjust_quota().
>=20
> DAMON users could disable all quotas by unsetting time and size quotas,
> and removing all quota goals.  The intention of disabling quotas would
> be making DAMOS run at full speed.  When such quota disabled setup is
> detected, damos_adjust_quota() skips all its work.  The skipped works
> include effective size quota (damos_quota->esz) updates and charged
> quota amount (damos_quota->charged_sz) resets.  The intention is to
> avoid doing unnecessary work when quotas are disabled.
>=20
> However, users could do the setup while effective size quota is
> non-zero, by doing the disabling with the online DAMON parameters commit
> feature.  In this case, because the effective size quota exists, DAMOS
> [ ... ]
>=20
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916041409.1069=
26-1-sj@kernel.org?part=3D1

