Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B29492E27
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928242; cv=none; b=AKeSn5e4R9PzDgJH/YmhH+7xzMTnstHcYq5TdSQd5kMIA+VevyF2Fp4jw3nvAgoYV2MP5HL5vTrdsoVgU5nM6e+R2eH7GWNf1LTNw1MD5mUeq11M+7wZPl6le7me9rtrJYh0eBo8f3AvArArX0ixsxnxA6o33c99v7myXyf7LgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928242; c=relaxed/simple;
	bh=3lLXYQYyvmuBuRvTDs3RKnnsA5jyWCr5NUwn4wnAwPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IEwiQDR1hAIFXGB8K9wWolDJScg2BAxhjFwrkem/Ms2Juzlyp+68SZwoFYvT3o3cIGcoxFUr9+ZOZwLBJAQmAy3rkoG56Jb+h8yr78mXddfU6HVvIM/g2CIY9aJZUN4l9Zg+VSmxhMuKE4mFc3b5pA1JfQ18SngCiVKM5J8U3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgUkdAoY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgUkdAoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44701F00A3A;
	Wed,  9 Sep 2026 04:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788928241;
	bh=SzbZ3IfHI+ZrpVl/MyjLg2YNQRhBXUdDM8WGm1BJy00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AgUkdAoYV6tI8+xRGuC5L7YNnkssP6G8zlA/SdYYRRVuVBb/lwh63AzD6RPlLI/Bb
	 mi+ZSNTgd1B/oQeNy6nvy0r6QPSiivKgS9vnA48/Ml/P0DwTCEE3CHVrq55WTbUzc7
	 BfLaZc5aTqTPYQepABcKingFkakPdEgbrqK88MOwR9TM7MjyII6DiirMITFWrhSJcq
	 QXC0RPcwNmJEk1TNqiVQq0tV/rEh0D5ql7112jzFYR2MwkcIZrfncz7P1Ko2dQdH2+
	 6xvUYB0gkh2JhNFAQU32d7It+t+4XKJ2iQEHAyU1rxOHMYfnLSIMxXtXu0gmO36K4R
	 dTjc4v2xAD+FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/core: avoid infinite
 kdamond_merge_regions() internal loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909041900.189118-1-sj@kernel.org>
References: <2026090832-stood-aspire-6c82@gregkh>
 <20260909041900.189118-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:30:40 +0000
Message-Id: <20260909043040.D44701F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909041900.1891=
18-1-sj@kernel.org?part=3D1

