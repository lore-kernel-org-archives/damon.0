Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3523246F4
	for <damon@lists.linux.dev>; Wed, 29 Apr 2026 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777491536; cv=none; b=WLjc06iQE20hcm2TyMSAYN38TlJtOTjFdgKQC80XRvmm9H3pDq+cTVHgmx0Cpf4AGYrdVLy+CekjyWXtQImYoKJrY0hjYUHe2ugoB3hjpW3PiiXtsiJdug18nIj3s90o/T02UBEEybyAv0XBxb/jCGk7VlChSzHuwAICtbCtBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777491536; c=relaxed/simple;
	bh=hY0tLXbmtWpq594Nm/sCMRDxkPxJDaVRo91K9cWf46E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VIAQl4R3PsXMGgSr6pf/MQp2B6ACorBSJtVpH8h6FHJ2+54BA1IcMJqAZtaYPEnhv3mUiApeHFEyP4r4abYTkmP3MvrIuIyfeGtM2yGlr+Wb8KHU54TFTlOZt8Mh9xnTP7l8RHQnDE1bbFM/401Qgql4QTLz6UykxMe54lQer00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dieJDvo/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dieJDvo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E65FC19425;
	Wed, 29 Apr 2026 19:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777491536;
	bh=hY0tLXbmtWpq594Nm/sCMRDxkPxJDaVRo91K9cWf46E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dieJDvo/qgcwJQv3qp3dgwrJJjTfC4JZK39/iLTHyUnRVr9N+rjivqU6botJk/poh
	 I3jVhq/t7t+yWbYfgRXRrTClUpj2d0mlPKD0RbFgr8l9IkGR+rD+3rQasJZiOQ6yV5
	 ZGir4rxkLrvZXN6TwGm1aoEgGKKwN/zuh1qaEP9T22RVT0kkyfaD2QtaAWQKASbNPT
	 XYXO6WLLkawv+5oKr55/y2Rz5YdL8Cc+oXome9xu/wEWxQfGDoRM77T/3vrWb7S2k5
	 m0LdPK7tzyHA5KMnKFFWHx0NZfk1t7l8OYGV+PVvZj91JnArLcvE72uH2cYylrEAaZ
	 CP0DwzNErFGrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Docs/ABI/damon: mark schemes/<S>/filters/
 deprecated
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260429150309.82282-3-sj@kernel.org>
References: <20260429150309.82282-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 19:38:54 +0000
Message-Id: <20260429193856.4E65FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `What:` entries for files under the deprecated `filters/` a=
nd newly added `ops_filters/` directories.
--

commit d4b50ba450c215da3baec9d7d831c83147cf209c
Author: SeongJae Park <sj@kernel.org>

Docs/ABI/damon: mark schemes/<S>/filters/ deprecated

This commit deprecates the filters/ directory in the DAMON sysfs interface
and updates the ABI documentation to use the new core_filters/ path. It also
adds documentation for the ops_filters/ and filters/ directories, noting
they work the same as core_filters/.

> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentat=
ion/ABI/testing/sysfs-kernel-mm-damon
> index 2424237ebb10..b61a34b9b185 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> @@ -377,15 +377,20 @@ Contact:	SeongJae Park <sj@kernel.org>
>  Description:	Writing to and reading from this file sets and gets the low
>  		watermark of the scheme in permil.
> =20
> -What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/=
filters/nr_filters
> -Date:		Dec 2022
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/=
core_filters
> +Date:		Feb 2025
> +Contact:	SeongJae Park <sj@kernel.org>
> +Description:	Directory for DAMON core layer-handled DAMOS filters.
> +
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/=
core_filters/nr_filters
> +Date:		Feb 2025
>  Contact:	SeongJae Park <sj@kernel.org>
>  Description:	Writing a number 'N' to this file creates the number of
>  		directories for setting filters of the scheme named '0' to
> -		'N-1' under the filters/ directory.
> +		'N-1' under the core_filters/ directory.

[ ... ]

>  What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/=
ops_filters
>  Date:		Feb 2025
>  Contact:	SeongJae Park <sj@kernel.org>
>  Description:	Directory for DAMON operations set layer-handled DAMOS filt=
ers.
>  		Files under this directory works same to those of
> -		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filte=
rs
> +		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_=
filters
>  		directory.
> =20
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/=
filters
> +Date:		Dec 2022
> +Contact:	SeongJae Park <sj@kernel.org>
> +Description:	Directory for DAMOS filters.  Files under this directory wo=
rks
> +		same to those of
> +		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/{core=
,ops}_filters
> +		directory.  This is deprecated.  Use the core_filters and
> +		ops_filters instead.

Will automated ABI parsing tools like scripts/get_abi.pl be able to find the
documentation for the individual files under the ops_filters/ and deprecated
filters/ directories?

Since the What: lines earlier in the patch were renamed from filters/ to
core_filters/, the old sysfs attributes and the new ops_filters/ attributes
are no longer explicitly listed. These tools rely strictly on explicit What:
entries and ignore textual cross-references.

Should multiple What: lines be stacked above the shared descriptions so that
the core_filters/, ops_filters/, and filters/ attributes are all correctly
parsed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429150309.8228=
2-1-sj@kernel.org?part=3D2
