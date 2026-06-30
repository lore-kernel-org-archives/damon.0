Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0528466F
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783753; cv=none; b=s+QPq9vk2HvwF9SfyTKnDgJOZJL6INtxYAevTAMGYdhgJRqsOINRWEE2UWGhHPlTjqwf77a6foTigF+7d6TDPbiSZIQMFktk9VUMDZR76CYRSpreei0JIZWupuSCXdHX2JJr8mRVttIA6ZiYBROp34ydMvLxq+xJXvrT+juyReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783753; c=relaxed/simple;
	bh=nCb6V7ROpSzETrtr6YL6pwqC7i1+OAD/MXV+SL2xYZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DL4jbFczQl17MmblHA0WyGI0rTAUT3ywKAAz/w+j0tDgDLFC2A3kxkmGxuzeAQDK/j7+EZkANRqlxCaBaFRdf6lhfUKVAq+Xym9m8KwoY3W/TYFm6G+uEjhOpTiJWVYBgy1ZIzwC2HEOAdgaIzKFbRlQsWY9keN0bmib0Zq4eCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXBMF9Da; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXBMF9Da"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10B81F000E9;
	Tue, 30 Jun 2026 01:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782783750;
	bh=CTnPcXEdLgFeRMJomjyePK00H+gFn8UoCy+bG9dPXlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cXBMF9Da+qjvQTBcKBIG8wJUMtdchtA8u8beGtpJ5+1Uk2w/j6L6XpB91XqxczSDT
	 06jwCPqKXshlFNJKQhhDDaIK0ZaG28HTWnNx8gF0kKIacwzSIZaPeF5XPX7DCVnYjz
	 4BOxxChboBqoHMy6eZz4qCVdBiBefWnJXf3BqKXSEkBb33WMx5tUSOjl+3qsgsNF7Z
	 RvhGrnbQ5jrZHmjpRWxYmVrwRxjysibuRC/bABBqO5/DlRW/pQ5ms3g04eO8tPGB2L
	 Sau72b4l+1YHTBke8s3kkEE/+MYtcCzmudnqAFtKXYvAvMJYMgeRk7iv4Iuhit+yMC
	 bPmCfbWydxQHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: s/SeongJae/SJ/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630013820.143366-1-sj@kernel.org>
References: <20260630013820.143366-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 01:42:30 +0000
Message-Id: <20260630014230.B10B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unjustified removal of third-party corporate copyright notices.
--

commit 01dda7537f36dfeb49164318c8fee42788b1510a
Author: SJ Park <sj@kernel.org>

MAINTAINERS: s/SeongJae/SJ/

This patch updates the author's preferred name across the DAMON subsystem,
including sysfs documentation, source files, and MAINTAINERS. It also remov=
es
copyright notes from these files, stating that they can be confusing.

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

[Severity: Medium]
Is it okay to remove third-party corporate copyright notices like this?

While the commit message mentions removing copyright notes because they can
be confusing, removing another entity's copyright (Amazon.com, Inc.)
without explicit sign-off or authorization might violate standard kernel
legal practices and risk copyright disputes.

Should these specific notices be retained unless there is explicit
authorization from the copyright holder?

> - *
> - * Author: SeongJae Park <sj@kernel.org>
>   */
> =20
>  #ifdef CONFIG_DAMON_KUNIT_TEST

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

[Severity: Medium]
Does the same third-party copyright removal concern apply to this file
as well?

> - *
> - * Author: SeongJae Park <sj@kernel.org>
>   */
> =20
>  #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630013820.1433=
66-1-sj@kernel.org?part=3D1
