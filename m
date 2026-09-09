Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113735C6AB
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932101; cv=none; b=mKA0v0Tp8cBwf7FLqSAOXjv+Fdn7IoYrol/1VBgbqD4hLS/GoEbsc+fJbC435RUUrIU9md8a5weBMgLXmtnOv+y2cnJ6oGMHXqwts+snBLKtnzNnFpI+t0AVulfPkXZRET8TYLjrA6srdfViTycfcOj/QR5xlAc8Ce+ZM8jHsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932101; c=relaxed/simple;
	bh=KK/KiZ6/G50wRTrV8CdRcUB3Zi8s04zrzuQ8Xm37WnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PTwA3vhCIP+jxwzO3abtCbwqzRn4MaaA3/uYksvN0BBdTMQq1P5ZDPVPVEDlhHF7nSO509YPU6oyF827GIcvaA1JwzZ/dhqqfnkCPCSsTylREO9TSkCjyeXrdDDALHVmUimBy/YMU8aOBviI1a+iAiOOJ+qlSjocGsNRQeJ0VzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4D7PCZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4D7PCZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D211F00A3D;
	Wed,  9 Sep 2026 05:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932100;
	bh=r3um1ByCId5C5HLhCzFDaGvR1AKDgYsTbmo8z9lxuus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J4D7PCZq6tIakNRTHSYwngZX02Sa4a/hX3e3LEhE0M8kfTHatQ6HMGzCKRZs0CxPE
	 xlEiLJLSEigOhsO3aqeSMb1uXQKez0RLSf4wj6VNB4gDBUBSvpIzn/poIKBZGINWLN
	 054jJxs92yNvUK2QkBDixIQz4/yqX9QQtM+xHC8O6yfdc1oeQHrfbg4dMRlLosnSGQ
	 /tzP4dK3wLcuLX6BuXQV2KOogWQPzutZk03x4YlYwX2MSpJHfwu/rU2By9sabitj05
	 NWGHVv/JLL0UBkTWAdS0I7bS5AvLSuAcFmKwL0K/0jBAKsbp+1reEUIY7DQGZzDz8h
	 znG7jCpZftHfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.2.y] mm/damon/paddr: drop last same folio access check
 reuse optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909053151.242944-1-sj@kernel.org>
References: <2026090851-hulk-tutor-8154@gregkh>
 <20260909053151.242944-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:34:59 +0000
Message-Id: <20260909053500.38D211F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> It can race when multiple kdamonds are being used.  The problem from the
> race is doubtful, but the gain from the optimization is also doubtful.
> Simply drop the optimization in favor of code simplicity.
>=20
> The user impact is doubtfully trivial.  After all, this kind of
> interference can happen only by intentional user setup.  Even if it
> happens, it will be rare, and the consequence is degradation of the
> best-effort monitoring results.  No critical consequences like kernel
> panic or memory corruption happen.
>=20
> The race was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260715031002.108504-5-sj@kernel.org
> Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]
> Fixes: a28397beb55b ("mm/damon: implement primitives for physical address=
 space monitoring")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.16.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit f23f0aa62b2f32c2b12f95959fc4603ef81678b2)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909053151.2429=
44-1-sj@kernel.org?part=3D1

