Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C23164D8
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013527; cv=none; b=BETm1AidyJxJeRJlCodmUEU7Sb4P9ua1bl3Wc8usFlBeUOaHMOkLE/e/zSS9NIUbcRSBFdfyrCpmlVeink6hMTuHzb4DYafSNMBy4BxeruhNU4rqUZUlLI0t+8DFs4PZo9oVTEVkGlDPHHf5KtHfG/Go5uTp9ndspU8RNpbYmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013527; c=relaxed/simple;
	bh=NgxyvT9PWM4N6T8BRkk7uVki1Ka9LL5qP7fFR2KmtKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cBHxL2UX8sFme+D4O6nJuuZc1RYR8hBd3YGGhcgqqTnis938lVVSKbB2CCHAhRpZowmw4FY9z3Q5cL/B7P49+NFM1MioJKoxNom3cBmXuAkPH1Sm0rla8O8Lahcp6A/kK2VJ64O/q3PD2NLpCPDhPCK/JB8Ija4cjtblMfLhTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+rU6vW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+rU6vW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4CD1F000E9;
	Sat, 25 Jul 2026 21:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013525;
	bh=VbEGvgMKlX6nb4xUHDzgnyOwhD6qMKvtLX/8veby7EQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m+rU6vW/WHMdDoUlbYU3aNquaQxxYS+HjHuJnZa9/96stpI+RE/RSR+NKBJUZCJD7
	 JUUXRd0NF8/u8KO7UO6b4z/dvsmtigULxJ0DXyauP9FM6hO+ynUhKwwh+OgixP7ym9
	 N36gk0QJ+hm4zjf45PiTeu/kHvGZynAFsXXYPE3It+PL2kykBJJBI78mUKjScfgBbH
	 R9N9uzrwDIKzqarv+3Kt51jXWZYm422QxiOwQJ0A3qOiaaKFkLBnguEUMIOqLFZlk6
	 gwOokGqGD0WtsoljvurZnPDVKtX2XRJpjhQtUMpIGC6pKWIhAOtYZbophxJB9gOXcw
	 N0hyeMwvC8kww==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/17] Docs/mm/damon/design: document pgidle_unset
 probe filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260725210225.129944-5-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
 <20260725210225.129944-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:05:25 +0000
Message-Id: <20260725210525.8D4CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typos and grammatically awkward phrasing in the newly added documen=
tation.
--

--- Patch [4]: [RFC PATCH 04/17] Docs/mm/damon/design: document pgidle_unse=
t probe filter type ---
commit 616f638e60cd5170d7a26046797874f2e31071a4
Author: SJ Park <sj@kernel.org>

Docs/mm/damon/design: document pgidle_unset probe filter type
   =20
This commit updates the DAMON design document to include the newly added
pgidle_unset probe filter type. It also formats the supported filter types
into a list for improved readability.

> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/d=
esign.rst
> index aed6cb1cf4831..d9f64e9ae2879 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -293,8 +293,14 @@ registration is made by specifying a probe per attri=
bute.  Each of the probe
>  specifies a rule to determine if a given memory region has the related
>  attribute.  The rule is constructed with multiple filters.  The filters =
work
>  same to :ref:`DAMOS filters <damon_design_damos_filters>` except the sup=
ported
> -filter types.  Currently only ``anon`` and ``memcg`` filter types are su=
pported
> -for data attributes monitoring.
> +filter types.  Currently below fitler types are supported.

[Severity: Low]
This isn't a bug, but there is a typo here ("fitler" instead of "filter").

> +
> +- ``anon``: Same to that for DAMOS filters.
> +- ``memcg``: Same to that for DAMOS filters.
> +- ``pgidle_unset``: Matches if the page for the memory is marked as not
> +  access-idle.
> +  Matches if the memory is not backed by pages that DAMON can idnetify

[Severity: Low]
This isn't a bug, but there is a typo here ("idnetify" instead of "identify=
").
Could this phrasing also be slightly adjusted for better flow? Something li=
ke
"pages for which DAMON can identify idleness" might read more naturally.

> +  idleness.
> =20
>  If such probes are registered, DAMON executes the probes for each region=
's
>  sampling memory when it does the access :ref:`sampling

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210225.1299=
44-1-sj@kernel.org?part=3D4
