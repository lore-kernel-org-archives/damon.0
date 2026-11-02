Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633871;
	b=XSsPNJsUVZPnrxifMQqofCig8EtPplFPZulSyjZLNhzvPg9D8MKEVBbk9UDJMJyXs8sW
	 KdzYlvsa22Aonfed+/pcrKyjXA431sBhfWByAZDmtnT+3PuAfPlj/r75IblSC8oPEk5az
	 q73wdlvtjiqG/XPCqRk9m/fzOQimy6ZHESJdkvcI7H8V/A+IN8JK8vL1bVRa1l5nMn44m
	 gr3zzPoOa6CJX5weG90Z+6F/4bj1b/PUJzCNA+y11sMNP34MmHMv+BUDh8/kQKA1ehcRN
	 kMhTzjIWHZKPY7LInspoUaNnmIADd6I3J4Mt6KgKfergvqeUD0yx6fUKB/7it8lNVKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633871;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IVbczXjXdilVu6Uo/xuuNSSXYQwfYCMDi7Qq9uq6wNQ=;
	b=Oq3SwhqNYuMCHfS/STm83QprpTxjqPUYseKJ9ct6erqR+bK4QtbIqbaMUwEQsfPXDzwA
	 A2Vf9rMkpdTywcWEpgAF2PAnrA0HRkkJt6TkzpkkLWVOQHKTKZ2j00/wzJgQG7Z9aBG6h
	 AmSEDx9HOjSIUoQsdqo7TQ89W8Z6DlS/q870ND70JgwHxfCqjaadT6YMlPcCSzGANm1aG
	 rJUfQ0xXi0hzXaDHrjRlUrVJafZPSkOOtIeELzlZUwPfni2T9na5u4qt3xU961rGIteHc
	 T6GyZljG0Zj6PxELP+vy7NhZ7AXZHabu+ldeZepSfnKUj9t0+TSAT3/lFPk9HsWEJxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/KMNSEF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858A606CEFA
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/KMNSEF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B116E1F00A20;
	Mon,  2 Nov 2026 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633870;
	bh=IVbczXjXdilVu6Uo/xuuNSSXYQwfYCMDi7Qq9uq6wNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/KMNSEFptawLSVt2IK9s5wdEgqHj7wBLA/mcQMA48PfUG8F29qsH5jM19NwDz8mP
	 bsAnt3bAwM03yaHDh9GQobGfl5UHlybSyM+rU/FPLtK6h+00qlCYTCU1g5lzcQ3pFA
	 1dq1bCmO+7rAZkcQk5aF81F9YhY3oOSuNMfa32SjkW4ygEQht5Hji7ZPRq97IRuyRK
	 GSV14cpqJJbnyyonSX4uxrbMG/KB5oPQqzfPxF3XK8E1tqlpiizirGlrC0QC37o6ZZ
	 B9NnrCqWLKQoVe7JvDFoEskE0llNrM7cj1aAXEKhyzF1bcT6iF3IWtNshJ2EtdGxpG
	 JlgHwRmG5xBZA==
Message-ID: <sashiko-outbox-193687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] Docs/admin-guide/mm/damon/reclaim: document how to
 disable watermarks
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102150757.93058-10-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
 <20261102150757.93058-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:37:50 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Jinjie Ruan <ruanjinjie@huawei.com>
>=20
> DAMON_RECLAIM runs its scheme only while the free memory rate is
> between `wmarks_low` and `wmarks_mid`.
>=20
> But some users want to reclaim cold pages even while the system has
> plenty of free memory, and it is not obvious that the existing
> watermarks parameters can already do that. So Document the setup.
>=20
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150757.9305=
8-1-sj@kernel.org?part=3D9

