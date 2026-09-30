Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752994A8430
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770138; cv=none; b=hslarEQcffxYoMOGObjeobLX6cHlORDVTsussH4tKcnAy4RFdowrP3bvH6+NwAka6XRl/gSn5fWudC8HDg6tG6NHZmk87GK17aKnVindsb9EhRBrEogFr94ucJGr+sqhLTzZqebNy1/1tnB4MAO+zgE5C2ePPwcns8i0vbNAECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770138; c=relaxed/simple;
	bh=l71xR1kAVcXhjBsB22AVQ9OAkIbiaMn2+XsXIB/y72U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UpRoa7uDGRW75oCv+zhzaYeuphSZJcj9bdkgM1CqhxNUUzGZH4Gknmdi8w2tCWOTFXdGOUGcim/PV3JH09MCPL0BWvMRYl0zZonbboD6bPyV6ymVVsi+Pf4B6BTUH0YEYfVGcxkukoyTVJc0IF3LZNPWyJL2rbn2t/KbkQu7YZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYKNgS9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYKNgS9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA021F000FF;
	Wed, 30 Sep 2026 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790770137;
	bh=yPDt3mn2AAVvfK8hLqZrxTzPlbjvJN4k2dS+a8bHg+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYKNgS9m0U0PFmaM2weeWWRdojoN4TaEtDT0ZVh3n69RqYKSgOov6Rz4r+0ahIKgZ
	 L04Vw9/7adUYVPi2RUxSGxLINJ48AUUcNDCof7DHxuExPnPX1EqDdT57k6HDDkZ/YG
	 WvzVJ42R3+x0zJcaNvzEpGoRc8VWRzPOCOtEpXWrAsHcKmr/XvKJhRac19bP1hEd/Z
	 Vc+Iog4YTKHsXg7mWj1GpdwphH+W1PAAuMu64Obd3EMQoWteKtbgpzHPpprRd14qrw
	 EGp+oVT8mKPkC5mBQT9wdpbqhn94OaR4mjYDZ57QKvuz+meRcqax3j62MbE8KHE/k9
	 k8bntPtLu7SPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: fix age_in_sec overflow on 32-bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaeyeon Lee" <jaeyeon.lee.dev@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260930115812.138864-1-jaeyeon.lee.dev@gmail.com>
References: <20260930115812.138864-1-jaeyeon.lee.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 12:08:56 +0000
Message-Id: <20260930120856.EBA021F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_hot_score() calculates the age of a region by multiplying r->age
> and the aggregation interval.  On 32-bit architectures, unsigned long
> is 32 bits, so the multiplication overflows once the age exceeds about
> 4295 seconds.  Then old regions are scored as if they were young.
>=20
> Fix it by doing the calculation in 64-bit arithmetic using div_u64().
> Also make age_in_sec u64, so the result is not truncated back to 32
> bits.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260623011652.1354-1-sj@kernel.org
>=20
> Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritizatio=
n")
> Assisted-by: LLM
> Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930115812.1388=
64-1-jaeyeon.lee.dev@gmail.com?part=3D1

