Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771ED3CE48F
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244070; cv=none; b=rDcwc97E37Lt9+4XeV+O3V/IjKv4LiOGg1FOt8KKx8CV9VO+l6CKl1RoskMAjea+uqxIKw3vkGvOPVc8Xr9C617lIOBL9N1Dc/PeIX6TiX3Sf5gd/7s2hQkZQ71sQyi2sXYAyDjtlEdFjnaYAvDo4Vsglpo38J+cyPZzDMqjIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244070; c=relaxed/simple;
	bh=Q5tdv7Lj1v9/i75W3yEfMc/rm91u9J0EHcHVkqyfCBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lLaBlc5wUkWyc9hcQlEOduVJlEBzXJ5NgzrZoB8PVXZqJnDcGuH2M3lIBn8PvDg5kK5UZc7e4Feeot0OsCYgVKFhofmjfbMajN06bzLytgaAEP6dWQsEl05EIlbcjztA3Gn7xk04yBFkyx1wId84EO+Mc7hhzxaZZWsah9+Oa+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3M8jLFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3M8jLFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC371F00898;
	Sat, 12 Sep 2026 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244062;
	bh=aVtVLio6e6WFvNOp7uz/S8SWH0cEGE1kTyHvh8eiEA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3M8jLFG3iYMNn4Dn93CV2WrfgocdnhrKdv+/M4olulGKl8ryLwKyRItcTkiOtmrj
	 5fpqBxhdYeGHiwl/JoPDoXddsOY9I9sOk5To9M1VBe5UrPBkdagf83Di50rnP20+x7
	 L30vy70ZT1kbcnM/PT2KGr5F8TATi24AqZxxOcX4Uq/nsk1136xeGW+MTbOJJiU8K5
	 0uU+gOaOYACx1XOznMoNcnUGWghYWhmcMwmMsvsHmdgpgzY+3x9qOCLh4mMtA3Fv9x
	 ok7cW2E2Yh8Q+D/jXkIXaEvTGscZBhLPtvYgcrFvkletb9eWP5rdYo8ryWMGvh+nf0
	 18ljjISvz2iaQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/9] mm/damon/core: use abs_diff() in
 damon_feed_loop_next_input()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912200814.145612-3-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
 <20260912200814.145612-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:14:22 +0000
Message-Id: <20260912201422.AAC371F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_feed_loop_next_input() is open-coding absolute diff calculation
> instead of the dedicated helper, abs_diff(), for no good reason.  Use
> the dedicated helper.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912200814.1456=
12-1-sj@kernel.org?part=3D2

