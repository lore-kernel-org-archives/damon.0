Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EAF3B1B3
	for <damon@lists.linux.dev>; Sat, 27 Jun 2026 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782590430; cv=none; b=MlOGSmyX1aQHaQNyROJZSRyDQa2PF/135qjGOgW9vV6tm5Iw7K2IjM4417HNRrZ8WeNS47V7QYvC8wgUeRGu15ylY9t+S5ox58/5w+Zd9kc8/wpIFJOdTI06IP2+OEXiqwqns3txYD2drce1DvZ3jZ4JTpL68Ir8MmYInIfvloQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782590430; c=relaxed/simple;
	bh=2aEENKqWHfzzxte6dVSVSPegxTIagedACwS2vrktVY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gT0x0ykaSBStnS9z0JqZyMnt/rQCO/CqjfufVsHzBme/TInbZUgIC4z1s6/uAfAucDFfPIi8mWqmryxo3FErCaGIFvTrpWNVYcXa7ktxAnTwlLle2C72pLIzFwqV9rgKACIqVTkdQYCttLj/o8otnlxKIp6mI+d1tZG2FAmZ5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev5EfNuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev5EfNuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75DF1F000E9;
	Sat, 27 Jun 2026 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782590429;
	bh=7gl1OHM5mM/JHH7Y6HfrThWg+UPfuwLcKVGy7nh2/vE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ev5EfNuNe6mMhyHxbTBrTg9WghDej0IRAlspexiCcyC6BG8gKrCMRq4nLIr9dl1a1
	 dRP3Ks/u4ANL37UesUlPKAjWFm/Z8nuQ9enyveoAhsKReC1SGXqZCOMetBjCDY9nL9
	 8Uh+g1j7TOx0BdPI9dt2ljvlybsB6yOnTUGFW+DZN0VENU7MIFbeCal8keuQEFVkiH
	 D/AkX1Snn8YblEPxaHku7O9lePeN4xLxdoUUJBxQkE9iTULoqlcL0VT/jEByYLeU9p
	 pYF6FTbqGqG7/mzJzd2Rw0wStG9X1E57eQVw+829lzbdRhm1HXCv6uCfgiFihIJoks
	 tegmYcMdFN6Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] MAINTAINERS: s/SeongJae/SJ/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260627195630.24519-1-sj@kernel.org>
References: <20260627195630.24519-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 20:00:28 +0000
Message-Id: <20260627200028.E75DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unintended Code Deletion / Copyright Removal
--

commit 7824bc7fc9af6bcdbf6c2338af2a70179e7f0325
Author: SJ Park <sj@kernel.org>

MAINTAINERS: s/SeongJae/SJ/

This commit changes instances of the author's name from "SeongJae" to the
preferred name "SJ" to avoid confusion.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6f7edb3590ef9..8bb28d5682dd8 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -1,8 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * DAMON api
> - *
> - * Author: SeongJae Park <sj@kernel.org>
>   */
> =20
>  #ifndef _DAMON_H_

[Severity: Medium]
Was it intentional to completely delete the Author attribution here instead=
 of=20
updating it to SJ Park?

[ ... ]

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 2e95e3bac774d..a9e187158067d 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * DAMON sysfs Interface
> - *
> - * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
>   */
> =20
>  #include <linux/pid.h>

[Severity: Medium]
Does this code intentionally drop the copyright notice rather than updating=
 the
name? The commit message only mentions substituting the name.

[ ... ]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 1cfb8c176b873..fcf7c7fadb5fe 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1,10 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Data Access Monitor Unit Tests
> - *
> - * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserv=
ed.
> - *
> - * Author: SeongJae Park <sj@kernel.org>
>   */
> =20
>  #ifdef CONFIG_DAMON_KUNIT_TEST

[Severity: Medium]
Is it intended to remove the Amazon.com copyright notice entirely along wit=
h the
Author line? It looks like this might have been an accidental deletion while
searching and replacing the name.

[ ... ]

> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> index 563fbc7e3f448..61f844336ffb5 100644
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
> @@ -1,10 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Data Access Monitor Unit Tests
> - *
> - * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserv=
ed.
> - *
> - * Author: SeongJae Park <sj@kernel.org>
>   */
> =20
>  #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST

[Severity: Medium]
Similar to core-kunit.h, is it correct to delete the Amazon copyright notice
here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627195630.2451=
9-1-sj@kernel.org?part=3D1
