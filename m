Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA912AE68
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927939; cv=none; b=HA1i1gVftZNQEgLujcpUXtW5yeVQZNvvhbrCFIB10RH0GbS1eJ0I0Fhjd9XQahV8yWUZr+Ch+jHt0SV2Ei4XKMAWlmoFn9tLWuf4b11jV3Rp/p8xA8AiunCvLmFMciV7TcYyM4Xngl5TTFdUofLCHGosoPtBLQPxRPik9VH8clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927939; c=relaxed/simple;
	bh=p0g92rfqjX9B5bwGxKXfVfOxN7YyWXBE3TqFRHSpiPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cIWDJyPncPfx/1iSneXWroC5s50FWWdMRRaBR23OdV95SZZO3hlMR72yWjSoiZFG0vJtKFvkm9G3OmWWRuQL9hdM3zgOKfbBNlko34vcWHbRSufzNdPT6qKOA8iqO5vE7sStsNrqtX1dS3jMag1ExbSUle600a6cEvUV1f1UtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPCOjFFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPCOjFFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC241F00A3A;
	Wed,  9 Sep 2026 04:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927937;
	bh=MEo2GTYZmxgWAwMHHMnoE9NLOwYGv3piWE+s2/hzzic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPCOjFFXwv7VQ92SuuplIqlMuTkyIHjIgDiGUXJlzMbKIAEH88L1V/7F1UgSIigQ+
	 7rdPQwBS7Zqf8iXhxZc4GeRIWE7j0hgPi/9RpK/2TFrjK8UyZmm01XvY+7UpgxZ9wu
	 JpOfCxs7BfHg2x8x72tjDqEtiq9zmw43PBLGQtkrxP2Gnhmm6wghXW4eUdcCV8oyet
	 7vwG5XSiRFfSDlZKnmO1kheppeoIVazCWRmcbfDcWyzJDf9HrlRdfgIEYdPv/uRiBG
	 zsHKQKk0vElMTAMUhYV/Wi4cdCqb2kwMEMvdA5CvLwVU2g4cbU/UC5cQFqX2k6tlGz
	 kyZjjAts47v4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/core: avoid infinite
 kdamond_merge_regions() internal loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909041502.181947-1-sj@kernel.org>
References: <2026090831-drinkable-maybe-5e01@gregkh>
 <20260909041502.181947-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:25:37 +0000
Message-Id: <20260909042537.ADC241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Patch series "mm/damon: unurgent fixes for infinite loop, NULL de-ref and
> races", v1.1.
>=20
> Sashiko found a few issues in DAMON that could cause infinite loop, NULL
> dereference and monitoring results degradation.  The first two sounds
> scary but the infinite loop happens only under unreasonable user setup.
> The NULL dereference is only in a unit test.  Monitoring results
> degradation is trivial since it is only best-effort, and those happens
> from only unlikely races.  Still those are bugs that better to fix if
> possible.  Fix those.
>=20
> This patch (of 6):
>=20
> Due to online parameter update like events, the number of DAMON regions
> could be higher than the user-set upper limit.  kdamond_merge_regions()
> [ ... ]
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.10.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 123e4619ab6c8ab1c4cb1d7a58311a2af13929cd)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909041502.1819=
47-1-sj@kernel.org?part=3D1

