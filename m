Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B812147F9
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092326; cv=none; b=N4uFVTnOYxN869CG71YO6lfck1+p9f/Pn72Jsu+lBrb18lpKQe65RsH31oCh76QIziVAqCqAy4KL8/b/UgGvaFJlQpNo0Kn1UQEmzOEbGsQr1bPsqtMBcUrrKaR9E7iG455FaAr5GWvsUbHBP/xQwYz4AY05+MzB2ma9hPStzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092326; c=relaxed/simple;
	bh=pKQisNLeP+SMmILj8GX0bYPmIB+6v+S3rZ73hFGCFjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGhYY4yKkQlcEKBot4444QNWaDpMIj2DUw5O4xENKyjjqP1y5U6Sha9rNnCVkrJVQegFO7GHuIx6P0T0XjPvA+B7RtvRb3rzLCPuMfwUB1dwFTY5kgO/fvCYlwzxxJ6rhKsmhMeYspxC9azwwdazu1aIv96wF58fg5caj04Pw+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAo9Tglk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAo9Tglk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD181F000E9;
	Sun, 26 Jul 2026 18:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785092325;
	bh=SIj+juQdyhAMc1fBFRlPbTA0/H/B4nYLNtvQvmIe7+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAo9Tglkrd0NqCkiXOtwntyH8nHFMbudursXS91NMl8Z8/7N2Qc19JdaXdYyOXV+u
	 4LsofGA6jV4uAGqK+fK8HNlXd7APJNojk/5zRV0psaVWGWfMT8gdaejwmLAgWm0Qfc
	 KZoapMA5aNkahfyJCQ3H8bZh+0ZH9k2wrRY0hJwcTXxwapzglWEGtypE5m33gQCT3h
	 KFKOGoyjuXgQm/3oYmLni/y5NXK94uHy7loe/otrpZGtHXZakLAnRBvpyUt4jxNiEd
	 QPPjwNlepMObsZqVdsdYsdctgZgAIosK86fcL2BmdAAiGdw5HCaEe8BeglPiFKtVcZ
	 95ci6VT8pxesQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 16/17] Docs/admin-guide/mm/damon/usage: document probe preps sysfs files
Date: Sun, 26 Jul 2026 11:58:40 -0700
Message-ID: <20260726185842.2990-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726174547.DAAD01F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 17:45:47 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] Typo in documentation: 'names' used instead of 'named'.
> - [Low] Subject-verb agreement error in updated documentation sentence.
> --
> 
> --- Patch [16]: [RFC PATCH v2 16/17] Docs/admin-guide/mm/damon/usage: document probe preps sysfs files ---
> commit a784c34ebf2a666ab86343b9b4f5290f8391e1b3
> Author: SJ Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/usage: document probe preps sysfs files
> 
> Update DAMON usage document for the newly added DAMON probe preps sysfs files.
> 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index da5f9afd08aef..e4fdec3fa5059 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> 
> [ ... ]
> 
> > @@ -283,9 +286,18 @@ In the beginning, this directory has only one file, ``nr_probes``.  Writing a
> >  number (``N``) to the file creates the number of child directories named ``0``
> >  to ``N-1``.  Each directory represents each monitoring probe.
> >  
> > -In each probe directory, one directory, ``filters`` exists.  The directory
> > -contains files for installing filters for the probe, that is used to determine
> > -the data attribute for the probe.
> > +In each probe directory, two directories, ``preps`` and ``filters`` exist.  The
> > +directories contain files for installing probing preparation actions and
> > +filters for the probe, that is used to determine the data attribute for the
>                               ^^^^^^^
> 
> [Severity: Low]
> This isn't a bug, but since the sentence refers to plural subjects
> ("preparation actions and filters" or "files"), should "that is used" be 
> updated to "that are used"?

Good finding, will fix.

> 
> > +probe.
> > +
> > +In the beginning, ``preps`` directory has only one file, ``nr_preps``.
> > +Writing a number (``N``) to the file creates the number of child directories
> > +names ``0`` to ``N-1``.  Each directory represents each preparation action.
>    ^^^^^
> 
> [Severity: Low]
> This isn't a bug, but there appears to be a typo. Should "names" be "named"
> to match the intended meaning ("child directories named 0 to N-1")?

Good finding, will fix.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260726173935.94046-1-sj@kernel.org?part=16


Thanks,
SJ
