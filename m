Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE040D565
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782058063; cv=none; b=WoRwpBKXRZIvwCA3SwfiK8EoCkevDsdjvDZeF5mgy1K5CDCthQa990HQ7Tpyoa1d3WO5dRm5tmj3IOibUrS5RwwL/9lzowXSllU0Uv01CTTI/N/nwXF6jXZLoGIflT5iEBvGmqDkBTT9pl6urW0vnz+h0Fq2cbYA/rotOSp1SSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782058063; c=relaxed/simple;
	bh=xlCSjAa5TLF8opYYpCyT5bmo1isOOxu3Uqe01u/szlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HHsjXN7joXdLBrGyPzyQmkuOjE8DJ6LrRO/q0Nz8tKuP4F4HRj3x8AqiO1+BMT4XCppHuksaT5T5EC571uX+if56vzSsdVh4+v12u0nEP24yE5qylJWVt30j4+JPtIOvPuTZ3mOieWue2d/tr++zEN7li2Mb3Ztc+FLZF7E98L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBd+KeMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBd+KeMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB95C1F000E9;
	Sun, 21 Jun 2026 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782058061;
	bh=mzvnntem4HIgKN/erfuM4VUovMY3f9xBInurTVjiE2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VBd+KeMbwgs+33+7j79I/gOi4G46EsCqPHqX5Y3++flX7iFZnbI3kI/AoFS7Y2IZn
	 K6BRO7Ea6SI2msE47lN6PAuMnMtwnqIsGGV1Kv2p+hVFIRY9G8XDChpDz5YhjrprFn
	 L/Pne7H7AFSodgloJJXgf/Il5z+EUObkSI8j4qO6sRCpaYljVu5tUATh+RyUhbfh2v
	 cifU7A7xcgGlAHtrLS1GwudXNATokPIoGpV5GMMXNse6n5JnttumCNtcaauO9bHXwn
	 u/pPyP00UegnX47feg+lzRCuWOeqbYaXF+rcq17pifXL4ZXA6dtWPJsLJ9TuA00AWC
	 fj2cAbBNY0Tjg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 14/17] mm/damonn/paddr: remove attrs param from
 __damon_pa_check_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260621155715.87932-15-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
 <20260621155715.87932-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 16:07:41 +0000
Message-Id: <20260621160741.BB95C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race on static variables across multiple kdamond threads.
--

commit 7fa73a58c60db55b9517dcf532023a51c375ba61
Author: SeongJae Park <sj@kernel.org>

mm/damonn/paddr: remove attrs param from __damon_pa_check_access()

The function is not using the parameter.  Remove it.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index db48ad274b078..a301e831a3945 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -82,7 +82,7 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned =
long *folio_sz)
>  }
> =20
>  static void __damon_pa_check_access(struct damon_region *r,
> -		struct damon_attrs *attrs, unsigned long addr_unit)
> +		unsigned long addr_unit)
>  {
>  	static phys_addr_t last_addr;
>  	static unsigned long last_folio_sz =3D PAGE_SIZE;
>  	static bool last_accessed;

[Severity: High]
This is a pre-existing issue, but since we are modifying this function,
could these static variables cause data races when multiple independent
kdamond threads run concurrently?

DAMON allows users to create and run multiple contexts concurrently, each
running in its own independent kdamond thread. When multiple threads
perform physical address access checks, they will execute
__damon_pa_check_access() concurrently.

Since last_addr, last_folio_sz, and last_accessed are function-local
static variables without locks or synchronization, thread A could execute
damon_pa_young() and store its result in last_accessed. Concurrently,
thread B could overwrite last_accessed with its own result.

When thread A resumes to call damon_update_region_access_rate(), wouldn't
it read the overwritten value, incorrectly applying thread B's access
result to thread A's region?

Could this mix the core access metrics of different DAMON contexts,
leading to flawed memory management decisions like paging out hot pages?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621155715.8793=
2-1-sj@kernel.org?part=3D14
