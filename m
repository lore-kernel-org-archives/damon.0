Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A684337A85B
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934193; cv=none; b=EvErsP5t5fwBBYctOAkDqqkw6mNlyuZHqbpekSJPZtF5xPQZUWidF/FrWaeYOHG/0coiaXhOXr6ID49K7GgwT32KVvBeDA8m0WGJUdAC+sGGlJxqzokxW0Vqd4oNCryNIwSVf0oZTHgtZnQS13C16YJC25mghtJpzyVOJDUrpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934193; c=relaxed/simple;
	bh=UGQkYUazrpj031r8kqWKTOgJwQzwX6Cm3VPhRQ4htOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jTkyGe7EZ65c3u/4B2u+3nNL/mKdbbAQ6A7mVkk2xCSt00GyPTkkPUQU0rr8X54E/6npyH+vIrBwU7pcenyGDvfNBhOTx6D742MgPivwHgTwixqzXKyR7myA3iSS1k5HSxK4md57vYAZPJGBo2kTrdtucrBDz1PPNyXqjHdWXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTOBUFXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTOBUFXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DBF1F00A3A;
	Wed,  9 Sep 2026 06:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788934192;
	bh=qvx2j22l8GXu1OSJkFq6NGF85LOReDLubjLySpYO5Lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTOBUFXivCgRjcGo41r1Tz3QGtWRKNZB+qWeyB2laAV3/3glFH3JNUV4ljHYDMA++
	 omfqLQ+66uRRoj7UsitRvMEufOKm96EeWVAgbP5+7bAT6kqxwF55/vBcBCIyFpdjnJ
	 PhXk91gscKd0qp1hY1azaSsQ8KNXSrTZ4lEq9oDQwR9DNNosxLF6ECcJ2sqV3cYyut
	 smkoOMDnG3J9rbFG4MzMRQ6ilyE52PMeZyjgsLHFvZLPltneznLl+jYTLvGG/FPc4T
	 gfTATWrlrMKInf9a6kvztBOlGgLNiwzfFiuqvmK3Zw27BopEnY6ZIYTpFI7u/i2xSg
	 o/HyWuqnNLSQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/vaddr: drop last same folio access
 check optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909060130.269798-1-sj@kernel.org>
References: <2026090858-underwent-outlying-c364@gregkh>
 <20260909060130.269798-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:09:51 +0000
Message-Id: <20260909060952.20DBF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The optimization can race when multiple kdamonds are running.  Meanwhile,
> the impact of the optimization is quite doubtful.  Just remove it.
>=20
> The user impact of the issue should be quite trivial.  After all, the race
> can happen only when the user intentionally setup DAMON in the way.  Even
> if it happens, it would be rare and only degrade the best-effort
> monitoring results.  No critical consequences like kernel panic or memory
> corruption happen.
>=20
> The race possibility was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260715031002.108504-4-sj@kernel.org
> Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memo=
ry address spaces")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 831846078caa14b7d00b2ccca8b8fe522afe3204)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909060130.2697=
98-1-sj@kernel.org?part=3D1

