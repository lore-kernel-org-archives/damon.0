Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B221773D
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364455; cv=none; b=eEkXkpoT5wWyIEfIHtGpNa5XHCE5ClsBQl1AUBCAWtLAPW2TKY3SJNOk5ga+7J+VOjrbVJsanyD+9uJaQ64WTUKErNBkg06fVWQos6b6fKH/Egc5luPrCXalICDFOIvNkLETG6dHoRquH8IllKsUHaLMCeaMO4rHaVFtQixTKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364455; c=relaxed/simple;
	bh=DRwXyE0CBiihWds+HMnXFHrXt+Jzg+RcAV6ApzD2blM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PijLDR1l9m9PCggscOiBstU8T7AJP0FeqOvTKdUgmmWnlP7K03pPv9Q1upkUIKtviLBVQcgKr7/iTtzoZY1b4TZu962r6pTTPXjR2oMavtDuTfDpQrDIVao44LTGcVwOy9W0WOUxDerS3St7HuubM23EjWkGgQPEDjW5Y8HbwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeeE8u2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeeE8u2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972291F000E9;
	Thu, 25 Jun 2026 05:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364453;
	bh=NxC9hg7SQssa79+lEMlIiyqHPX840U3RquPXBme30z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BeeE8u2RDlIF32mYBEX4G3zJ3WradkiWsYa0GJUE7vNIsG/8/S/tu5/zAUbaRIBkU
	 C5U3ENxrSL7vftiRQOCB/W+mSyX/46MDJKAwcY0VPVATlShAQ1+B0XvM8YZEg3cwog
	 ym8vPKdfo30Mkn4loMGbvbrqbdE5uMG0E4O1IDWsBqrC7S8y/V1S64j7o5YHgVrxOa
	 5Vc6JuUG/Rdof9xQpzvQihsGlXj/dT+JZqoW3aKk/SKTMJ/Sg+T7dYzbXuXGk90CyQ
	 MYhRKsn55mFy/AIDL8827rpvpdOXuP/RNaDmXhhlptdeWzr1IPRuiaCgWYICH8i8NB
	 +d678TkyOaPkA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 02/11] Docs/ABI/damon: document probe files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260625050756.91115-3-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
 <20260625050756.91115-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 05:14:13 +0000
Message-Id: <20260625051413.972291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect sysfs value 'memmcg' and typographical errors in DAMON=
 probe ABI documentation.
--

commit 0777dacf66fdc3cce9315b7348cc989aa1d048f8
Author: SeongJae Park <sj@kernel.org>

Docs/ABI/damon: document probe files

This commit updates the DAMON ABI documentation to include the new DAMON
probe sysfs files, defining directories for probes, filters, and attributes.

> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentat=
ion/ABI/testing/sysfs-kernel-mm-damon
> index b73e6bc28ea5f..2815f6bc05c18 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
[ ... ]
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_a=
ttrs/probes/<P>/filters/<F>/path
> +Date:		May 2026
> +Contact:	SeongJae Park <sj@kernel.org>
> +Description:	If 'memmcg' is written to the 'type' file, writing to and
> +		reading from this file sets and geets the path to the memory
> +		cgroup of the interest.

[Severity: Medium]
Is the expected type value documented correctly here? The documentation
instructs users to write 'memmcg' to the type file, but the underlying kern=
el
code strictly expects 'memcg'. If userspace follows this documentation, will
the kernel reject the input with an -EINVAL error?

Also, this isn't a bug, but there is a typo in this sentence where "geets"
is written instead of "gets".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625050756.9111=
5-1-sj@kernel.org?part=3D2
