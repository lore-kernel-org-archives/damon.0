Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F42255F2D
	for <damon@lists.linux.dev>; Tue, 21 Apr 2026 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747855; cv=none; b=qJqIZ4/pLSCCwNN2CuFK5Kn/uWcTm8WbyZ10x0bqhyC7WaJFBK2MrG8I6trDFHA6nd2362OUrdesmLze6vcBMaritcZnW7KvhkyGFwznxWfhuoL6O9UbW0UOsc+moomJOrgBcFJMTa19EaWvfVf91IvjYjRR5hDJGswbDTHlvv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747855; c=relaxed/simple;
	bh=EvDeg7VllXsDxvpIAJSDAbv7VLOPH9Q6ADOG94iGwNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tipoDSDR0ZJjwPGcunFdIYSr+xIKp8Nz5HTMToJx2lLOUhKoBWwHQxYIUi07YrxhTnXpIIOzeCI34xKj4DEhI0QY8g/12jcPR+fBRGRYJ9X08CuN/4igNFt2TxyEzRDrMoJHgauoOAo6pFX+G1J8mKvTCHdOJbTHISQfoxLoxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCJwdfUU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCJwdfUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B856C2BCB0;
	Tue, 21 Apr 2026 05:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776747854;
	bh=EvDeg7VllXsDxvpIAJSDAbv7VLOPH9Q6ADOG94iGwNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rCJwdfUUVPr540NxqdgN6XgHEKKp42M5MI6mGk6wlMS+j9lMMRh+zKjwUrRPGhtgY
	 XDrw+TSll0YYoRNln5xprw6nj4wQLHk4clZTm8ObOnWT5hfMht/AzKvIDY5kzqGURc
	 /PwvAvZDLxLrsGpc+DNFjHjHnQHaOVCOATjJrj+R+w695zxxA/XDGH0tITIbWDXirx
	 9wXGPgjK2jLe6Cs9sbX02o+Ol9HdANq2ZyOBsTIm1msMVbbvHzDLRTemQASbRfeg8G
	 DtG9XH2XfnyYMKG1OisVEoItTa2M85gGWjVdW/53aNNinivfqstHRSiAplFPf0vISW
	 Tm+Uc+1PUa9XA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] Docs/admin-guide/mm/damon/usage: mark scheme
 filters sysfs dir as deprecated
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260421044928.141388-2-sj@kernel.org>
References: <20260421044928.141388-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 05:04:13 +0000
Message-Id: <20260421050414.6B856C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [Low] Poor grammar and inappropriate terminology in the deprecation notic=
e.
--

commit bd6da1d76d24f1b76f6957dd9993c899af48df43
Author: SeongJae Park <sj@kernel.org>

Docs/admin-guide/mm/damon/usage: mark scheme filters sysfs dir as deprecated

This commit updates the DAMON usage documentation to formally mark the
sysfs 'filters/' directory as deprecated. It recommends users migrate
to the 'core_filters/' and 'ops_filters/' directories instead.

> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation=
/admin-guide/mm/damon/usage.rst
> index 534e1199cf091..4c222e956b100 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
[ ... ]
>  Use of ``filters`` directory can make expecting evaluation orders of giv=
en
> -filters with the files under directory bit confusing.  Users are hence
> -recommended to use ``core_filters`` and ``ops_filters`` directories.  The
> -``filters`` directory could be deprecated in future.
> +filters with the files under directory bit confusing.  For the reason,
> +``filters`` directory is deprecated.  It is still functioning, but it wi=
ll be
> +broken and eventually removed in near future.  Users should use
> +``core_filters`` and ``ops_filters`` directories instead.

This isn't a bug, but could the phrasing here be smoothed out a bit? There
are a few awkward phrases like "make expecting evaluation orders" and "with
the files under directory bit confusing".

Also, stating that a sysfs interface "will be broken" is generally avoided
in kernel documentation. The standard convention is to say that an interface
is "deprecated and scheduled for removal" to avoid implying that userspace
will be intentionally broken.

Would a rewrite like this work better?

"Using the ``filters`` directory can make the evaluation order of filters
confusing. For this reason, the ``filters`` directory is deprecated. It
continues to function for now, but is scheduled for removal in the near
future."

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421044928.1413=
88-1-sj@kernel.org?part=3D1
