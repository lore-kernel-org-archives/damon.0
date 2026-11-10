Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323553;
	b=WYVgO01gXwFmY581uKVXyWxf1Fa2SYXJ1T7/o7qRwVSu9m3eJAnlxzaxqFPHiKxuwBO/
	 V6bzc9zfK2+WAfAJm3ucvXy6HaZs9p+tarJKB7lZ+q6vLp+Aupsu08H23NnuxhfzxcDoD
	 goJxMavPG8gvmS/jTgM11Rhw7/x5OWTOQilLXq6Ktx4pizJo7nk8eqQ0nMywPnywRVxVq
	 RiZls0J5O38IbHAZUCFWQFS2n2oZdmaSSnt1Y4amIV04BPCWxUEqgxdkNdNBlAYCdE4dZ
	 48TujowM9/qrL5nE+EMXxjrutsrIl2iLZ3FaY4LavBHx4wqSPXJcdlqDyUTKCa4Z8Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323553;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=21xhY+7QDMq9MTzy+2R/vdkL7QSsqB0ry0tVF7Jan5Q=;
	b=42R0Fjmmy/LOevMxu0jIXnNvFhOWi865ruzQ5J00Ahz6/A8BGtrDbX4QqwEHNKCRswRf
	 sE0UIMOVmHxgb9wRK2N4wYUprlYVuzGz6puxloFQGdfrf0h3lg6+TyhHwnCeUPQ75mG3+
	 Krsmni1QCHyJl+mPZo6G22F3GclZtrkRAw12PejYmCKjRMLSLTvUagy0K2LH3AewZIXlD
	 Tt3IP1oywImbYFXlExoaGYfBrk3XOaCSw7ycktuVcWTLe8qtI8mmLh/N9FX1UXYQaLBZo
	 CFzkIa+1mC3rc1xGwcX2cWwsrPMndb/StUvMFQR8FyFxLbeYKYDewRbflH34e4tBayQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C0B8JMH6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5FF606A32A
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C0B8JMH6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00D41F008A1;
	Tue, 10 Nov 2026 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323552;
	bh=21xhY+7QDMq9MTzy+2R/vdkL7QSsqB0ry0tVF7Jan5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C0B8JMH6LqoeBsMDn6CniDrHmX1RgZfEDj1lIpH5wgbFi+7k0YK+aLf+UjFpQ4FVK
	 jnztcshwiWuw9FvTgIQ2wjKVEtS/7JsjBh+DKkv4PvReOHErKL+wx4zJ7ytfHUiNpm
	 hZ4lzqHljQfSbDXrrLhw/hrpc2892kX96wKgCT01g96MWefACur8BydPigKaLmMj+z
	 qAbjjFR2wWLFdkRB8fr5BrXFRuNmMoMS/l/FCGiYABinaCZwLya73o3kSI0pYww1eM
	 +Amr1INGtEm+bKyft+6ySIl5EsjGSy2UxsLFpNEwQCMLUOTBS/r7zwb66dpR8Z4PuB
	 gCCwqfwWBS/mw==
Message-ID: <sashiko-outbox-207239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/core: move static variable
 last_nr_regions to damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110150641.148941-1-sj@kernel.org>
References: <20261109201220-failed-6.6-26ae50a0901a@kernel.org>
 <20261110150641.148941-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 15:12:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> kdamond_split_regions() uses a static variable last_nr_regions, to infer
> if the region boundaries are too stable.  If it looks too stable, it
> does a more aggressive region split because it might be a fake stability
> coming from non-aggressive split.  Because the variable is static, the
> inference can be racy and wrong when multiple kdamonds are running in
> parallel.
>=20
> The user impact is not critical.  No crash, no leak.  DAMON's
> best-effort monitoring accuracy can be degraded when multiple kdamonds
> are used in parallel and the workload has certain access patterns. Still
> it is a bug that is better to fix.
>=20
> Move the variable into the damon_ctx struct to fix the problem.
>=20
> Link: https://lore.kernel.org/20261025164808.152048-3-sj@kernel.org
> Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a4=
7f2
> Cc: Fernand Sieber <sieberf@amazon.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: <stable@vger.kernel.org> # 5.15.x
> (cherry picked from commit 26ae50a0901a44f7d50053f87dc38abd9f9a269c)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110150641.1489=
41-1-sj@kernel.org?part=3D1

