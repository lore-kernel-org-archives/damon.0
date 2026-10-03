Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB139DBF7
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050177; cv=none; b=KKl1OcSKvGM4bubLfq6RewbQI0xgXGjjdqQDSJ8D7K9TlsZNW3gVSBqG+eFwyAD1F9/fCIZ4KOoV4uah5WVGi+P4+piZRNoZ9xVFBl9wME/C8yVvaVOHqhK85z2Qyu5rPhbE76KCxrRGSNUvfYZNiCyyGC+uHhvLevZfSC8puNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050177; c=relaxed/simple;
	bh=Bsv3AIJg/DUDMMpomr94zdZlmQ9adnaUpddZF+9Y+eQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UWQYhqCmP/AksB2A6RPmVazVR3nN0f/eR08PGYXXqHNWw5NFMnoDoAJyemuUex8LxyciuD1YBX+q4L5RvcIkr5uerwiBzXCPzk2rpzuiq+C72LFa0v76jxXP2Djw0t/wFC6azc4qCcoAcaUYRw8YI5XzhOeSTX6NLmHKPiMTL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1c1Mowh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1c1Mowh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156391F0089C;
	Sat,  3 Oct 2026 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050176;
	bh=zYuYDl8UU9uQD3fLCeB6P/hewyM6u/IsD6vKzJMsUD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1c1Mowhs1vqgA32z21MYXkccEt6yja9p4Dcsn1q+unOoZD2zC6TCMSyF4l47kWL4
	 XDJclgJzpm3wuij7j3tS15u3J9OC+xvR3y00rDKKSlzJDkvD2rFE+CdwUDsZi1zlP3
	 i9I2k8YwTbKCTi6pQf5qAzgDAe2ZuF5plT8ZBUNA7dbCp/5vMCvGNNb4Hasby9Ft7Z
	 sEBiC+hOM8Mcyzp2RB/4U45J5bWQh0fdfXNyW8cZZlHJOgzubRBNPk2B4sKlaqT4K0
	 xLkRRqN+HIAqqVY1ezV0t4HtAF0q8UPYrnU0e/lNXtkRXygUNRpgpBRP60fmpmMMmk
	 o6Ubh5FwH3/sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/core: don't skip damos_adjust_quota()
 while esz is not zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003155119.28683-1-sj@kernel.org>
References: <2026100319-silent-lark-6245@gregkh>
 <20261003155119.28683-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:15 +0000
Message-Id: <20261003175616.156391F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMOS could unexpectedly stop working when a user disables quota using the
> online parameters commit feature.  Fix it by correcting a wrong quota
> unset check in damos_adjust_quota().
>=20
> DAMON users could disable all quotas by unsetting time and size quotas,
> and removing all quota goals.  The intention of disabling quotas would be
> making DAMOS run at full speed.  When such quota disabled setup is
> detected, damos_adjust_quota() skips all its work.  The skipped works
> include effective size quota (damos_quota->esz) updates and charged quota
> amount (damos_quota->charged_sz) resets.  The intention is to avoid doing
> unnecessary work when quotas are disabled.
>=20
> However, users could do the setup while effective size quota is non-zero,
> by doing the disabling with the online DAMON parameters commit feature.
> In this case, because the effective size quota exists, DAMOS will keep
> [ ... ]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Cc: <stable@vger.kernel.org> # 5.19.x
> (cherry picked from commit 52ae167ce16609c7e6fffef588b3c2c26de2db19)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003155119.2868=
3-1-sj@kernel.org?part=3D1

