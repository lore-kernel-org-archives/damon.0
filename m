Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2727260D
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776221861; cv=none; b=d+HEZ40nF7fuEGs0oaDLpR9QiiglgByPENHCrGyhyYRwjZ3NEz6FC8D80gZLs5K9wltCEqLBTlAcpMlibQtBKPG11LSamZOT2oS6NfrY/wFgjukYi56mHd+rl3toqxhW09XNK3MRt3RlrhOVh7jPqaBr5u5iEluH/ix2stbkJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776221861; c=relaxed/simple;
	bh=tgJ+9JbPnLtrLRxhYIf9KkYKIMtks66ucYGy15XiUxE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P7JS1k+bNxXQzxwqDRhUd9S3HkOyM7pKRfuiPhk3zdMD9QC5lESvo3xk980OE+WvZweRUBtylHtR0tFT3jJjTNAap+OJni4LZdnUbrLU9L575GDxHHXoOJUJN5/xUiyQKef/96+9p8qzr4cg2ulhzJNCr2CJJCiT/6W8Mx/F33Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElvXdDFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElvXdDFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0373C19425;
	Wed, 15 Apr 2026 02:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776221861;
	bh=tgJ+9JbPnLtrLRxhYIf9KkYKIMtks66ucYGy15XiUxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ElvXdDFJOMfvPZAZB4ErifbaUu2/IazXhtNWZdgpMRIRxKq1+XqcGR94qiExaIX6T
	 3d80YLOL2UN8ZxmYD3Xcng0XKgvkCHMIvKY4m+iiXsQemCsIczHt/cjOmr/DLirj0R
	 KXBhclx4KJUXASlpGaif6iplsTpUH0Aqp+ZktfliuR1B2MGvoqiQx3rasb14+0Dsoz
	 Mf+Yq2ol3lOU0npKEwca9Qb1ecMjYDuBFcOmjCuAmW/UWZwcHr5tN5Xp/v3AX0u7pl
	 IDzf2G8fG3jybwVSQ5OS+AcPtwQjyPjUx6kkBdLQfaMGUBRKgh8daaQ+c2nCwgS6UK
	 +Tb3ppY4jxSiw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/7] Docs/admin-guide/mm/damon/lru_sort: update for
 entire memory monitoring
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260415012048.76508-8-sj@kernel.org>
References: <20260415012048.76508-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 02:57:40 +0000
Message-Id: <20260415025740.F0373C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [Low] Typo in documentation update for `monitor_region_start`: 'phyiscal'=
 instead of 'physical'.
--

commit 86d0c933a3a562746e2eb8114113949d40da7811
Author: SeongJae Park <sj@kernel.org>

Docs/admin-guide/mm/damon/lru_sort: update for entire memory monitoring

Update DAMON_LRU_SORT usage document for the changed default monitoring
target region selection.

> diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentat=
ion/admin-guide/mm/damon/lru_sort.rst
> index 14cc6b2db8973..012accf375b33 100644
> --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
> +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> @@ -246,7 +246,8 @@ monitor_region_start
>  Start of target memory region in physical address.
> =20
>  The start physical address of memory region that DAMON_LRU_SORT will do =
work
> -against.  By default, biggest System RAM is used as the region.
> +against.  By default, the system's entire phyiscal memory is used as the

This isn't a bug, but there is a typo (phyiscal instead of physical) here.

> +region.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415012048.7650=
8-1-sj@kernel.org?part=3D7
