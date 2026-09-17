Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462C2FE05C
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605837; cv=none; b=Z8lmmYhn+ZElkK3AKzogO0UAeVeP90TbaE9Tmft4yWwpBVbZ75dP4NSdhvYQIY6MhcX4Z3Vw4Aj0fDLgQzYmkeyAkPDnUlPnzadrh2skoewoidM7dj5xcNKZsWPaPSNMerwj0L/0MRDQSDV4JDZnHbgQH8ZWiELPAhrriTvLaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605837; c=relaxed/simple;
	bh=lTHa8Fwr4kO4H0/+fFSLECrhlua0YxPHIHMdSstEFWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B2TbWKulD4fpAcMgYqDB/ZBMumCZA/WEG7C8V/YrJSobryhE2326QfOJsG1tT6qheMCfsUJ+RFvrP+mCgBpgc+L/lgqiJHQsh0ZEMkm30Ie9CEGc8gdcuP1qB9Th5kF+e5KUyZW+fIRtAsZEmLlEVCnibmYWJfEr6BhUyR+x6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnlzEW3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnlzEW3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4CB1F000FF;
	Thu, 17 Sep 2026 00:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605835;
	bh=UXPApIvV01T9g5lKU6YjE2UFO35G2o+oI1RpbpPL0pU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lnlzEW3GUfqsDq/KtLQ1Jik73KqkQ5njZiKGAiYmU/bXxHASEeopJid4awm6V1DpP
	 gIw1vUeUyI2Wg9p0H8GKbUplhNuC8xnCinTV//nxI3uFxEiWerqjVAIi0tcK8ZkruK
	 RhzgyP1I1LqjY8G8kihmLKwdO5w/0aQhWC4YIlhtuS8MDhWOy2IjDewN666K/RiI0x
	 cSC2rl3wUdP33vcLQDUcRZLVlnF+Sx1ZYR+vUW+0aWF2FuJb4Wcjvwh6czxqiDXSO5
	 RGUgXajPJNHsjJSG/2pqOfVARbgGisGzukJy8KaaPSyzoR2lpzJ9+q4spZXCK72e/p
	 YsYipDhly9HoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] mm/damon/core: charge only the part of a region
 the filter left
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917003553.2465523-2-donggeunyoo.kernel@gmail.com>
References: <20260917003553.2465523-1-donggeunyoo.kernel@gmail.com>
 <20260917003553.2465523-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 00:43:55 +0000
Message-Id: <20260917004355.BE4CB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> An address range DAMOS filter that partially overlaps a monitoring
> region splits the region at the filter boundary, so the scheme action is
> applied to only one side of it.  damos_apply_scheme() reads the region
> size once on entry, before damos_core_filter_out() performs that split.
>=20
> The quota charge and the statistics update therefore account for the
> region as it was before the trim.  schemes/<S>/stats/sz_tried counts
> memory the filter excluded, which Documentation/mm/damon/design.rst says
> is not counted as tried, and with quotas/bytes set the excluded part is
> charged against the budget, throttling the scheme to a fraction of what
> was configured.
>=20
> Re-read the region size after the core filters have run.
>=20
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos f=
ilter")
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917003553.2465=
523-1-donggeunyoo.kernel@gmail.com?part=3D1

