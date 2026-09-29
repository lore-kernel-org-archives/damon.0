Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF553314C4
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704526; cv=none; b=S3IEK+RjDpw87MzGMb9tjcJyG7UY9gVe6I+UZOQKYhvLejMMp7v3ion1n3o+h+heT/BfsPZEFZORZUSlKJ9dm2Oi4T20QF4B925t9iCrJWLS9WjR9sWah+GJrxP46g2TjIj6BnQU7HfRXidmGfMvcbAQdcEvvrrhxasFnHfxhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704526; c=relaxed/simple;
	bh=cAsw5kaVnhVq5g08SBqyLdb9qZmM3aiFuRV+o0i5Mo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p/pDYV2gFFtamF8fSj7gHdqBnMTJvC5TdSn1V/nmJJChzbmNyl+ki3WHOyFS8zEXv3UUS+ui1VExlDQwmnyvWkvq+Lo584aQ1sx9dwHzJjFqfkM+5qm293+Kt12m1pZEp653hMAACwFt49b4Dqs64O6SfVA6V78Y6xTewwyiQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUjlBWeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUjlBWeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F5A1F000FF;
	Tue, 29 Sep 2026 17:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704525;
	bh=SStQp/ZH+U7FN0qmp3SydRfG9KkWm1DIOsiryDDvSOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUjlBWeYu3aI8swX19Y2ECszsHWP1bOTI9CYwx9TdIUHpoeC/C9WML0CZLfqvnv2B
	 ZoVdWwlT6M3mW+k7TCShtFUFKAjvJOtCfiKObC76aAbyAfe+gSk8/H9WhVuKGjDX58
	 1G7qkBls5x4egf0dh+LrZ37wP6DTwNK7L/4mmRZ0PUtDH9T4wlX1VmSIy7Oo2VQ7S9
	 hdWXcmEUdnabps+A5pp6DzdhmOxUsXIFjs8vOs3LfWkgIC4zxYewOFIxwqxbJWWilP
	 YtKOD+15eWdfv2MlsfiDfaq6GUnBwForgm3moMs9m3LzVMSC9BMPTbHirFKJmH43/J
	 qqiXh0DFh/MbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 2/2] mm/damon/core: fix unconditionally skip last
 region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260929174456.9251-2-sj@kernel.org>
References: <20260929174456.9251-1-sj@kernel.org>
 <20260929174456.9251-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:55:24 +0000
Message-Id: <20260929175525.71F5A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Liew Rui Yan <aethernet65535@gmail.com>
>=20
> Once quota set, the charge_{target,addr}_from unconditionally skips and
> resets at the last region of the tracked target, so the last region can be
> skipped even when it has not been processed.
>=20
> Example:
>=20
>     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
>     2. Quota is configured to process only 100 bytes per window.
>     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
>        addr}_from is saved at (Target, 100).
>     4. Window 2: The loop reaches R2.  Because R2 is
>        damon_last_region(t), the old code unconditionally returns true,
>        skipping R2 entirely and resetting the charge_{target,addr}_from.
> [ ... ]
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org> # v5.16.x
> (cherry picked from commit b3723b596b548c837a766aae3553c14a7b15af2b)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929174456.9251=
-1-sj@kernel.org?part=3D2

