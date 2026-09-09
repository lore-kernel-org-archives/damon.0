Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8336E21D5B0
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928096; cv=none; b=dCIyKyFLaJpPKFKWZ+rY0HWNBAilO7ZYE1a8P1l2Zp8T+rTXsKMMGg1zfeKkW/8uYnHvDp2tu3nGd7qXdTa97JU5Uy2xnqM075CRe8LDCwopqEVeLSRKG20iRWPtyfcxdgSRdUsJqu4181zkQr120oGFo8n+UPv6I0iAKfyGCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928096; c=relaxed/simple;
	bh=7T1SAuBHgNIRWcl5Uulvfq1raBM3pEs397vcvE/MBE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q86ZUOcmZhBiPfhqYBdu0LCxjv7wQNgt9hIHKR4DtgByGcvzzIhI/YtDZrB+V6tduiuo/IDrK9d4EU94ULFfPYubSmxWpFGCvCQMHo+kKEMDlNw5VNnDnroZLFqcJGE5WukSi2S6gSf0sDF2rywDXVMfhCF+0gt/jC0aY+lymNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbM4hNtv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbM4hNtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CE51F00A3A;
	Wed,  9 Sep 2026 04:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788928094;
	bh=+toJ6HxGlg2ELZrbKCfbodQdzibAubazOi2BfJSGnzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IbM4hNtvHXj4Jab+sRDhrkSF8WDJQ7Q1pu/N29p2tUOwVJmF9ygHIOf+Fia/E7BwA
	 nrssqRd1BJGVNO5rjrqP/IIpJXrGeioPYP9aKDA0XBQxFC1XMSvDdzwumz73g201X/
	 oyvMiPE0e81OlFnH3SByiB5x81CHmaOIjqVA1wsNn0voKDDBeZTNw3RHqORgsL1CvC
	 rbyslbQVs6PQ42v7s22e9P0i/DODJZva23VQYhEKbCc6QPSmNw3F4/8sBzEH6/S6Xu
	 Vcbw/JiV2/IQUwwaB9YinG+qqPHjBZqOroSO4kP/6wl9sDfCIitj35kXTv7rDCS71O
	 vRnqqeejF6EGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.2.y] mm/damon/core: avoid infinite
 kdamond_merge_regions() internal loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909041712.186196-1-sj@kernel.org>
References: <2026090831-desecrate-cheddar-be5a@gregkh>
 <20260909041712.186196-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:28:14 +0000
Message-Id: <20260909042814.B4CE51F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909041712.1861=
96-1-sj@kernel.org?part=3D1

