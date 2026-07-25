Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB112E7BD6
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785016770; cv=none; b=aeBUiDFurfyPTxto+weAroMHJgrebsGHY7sfFe6sCLxdPa7dLe3x7aAf0Fwe+qsNkqraCZ/jHk7BctSFKpphRwvpjSioAV9BbqN3ioWjKXRttLZR7qpSP2Vdwh2xZtNMyZ+mnOuQlrkUOT3e9QQGZ+5XNID/CjuzEaNCiwn30DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785016770; c=relaxed/simple;
	bh=nyvT6/VILjRFYJMyWef2lsuB00lfKm/tYiOsEwzwgJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgZEZHstlDY0hRFW8eDKhR4RRp28gEe6LXzW+SZ0tMi9SU69KL9hUoIXIRKg2TP73MLarQQJLp6xngaXWr3OQlUCIjvSTPv4nAR1wbKYX0JA5BGGvhJuXZ2E5KlwRM889faky+CP/wSRWv4z0zBJQLhvpbRoxGJlPl/3glFcHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoVfOOyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoVfOOyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569D91F000E9;
	Sat, 25 Jul 2026 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785016769;
	bh=EvMHf3DUhvO1CdAvf1MzcJXFrQ/vMZ4CcqRmtGtUuGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZoVfOOyNAiDQrLAo+YL4q3PLZjalMUBRzaPSkNkTgYI6DwjSXt3CxmLMqh3KVuFng
	 3oFBwkUGBIxEDZVnTwRBS9QIV1Ko6Fpt96v+BPeDh9Dd7Gd//d3jUt/ADKdi0A5A+5
	 FhX1dy2AzA29yqE6SSvKYXYWA/Uedq9iudBYC2jLr4AfUXvCQhOsCj0rQshUOAtF4J
	 DXdJoiTdpv1HXS7eOniQHaxi7QDrRkIQwmJ6l+2eew865cciWVp1BFXwp6kQkEZ/Sv
	 CTh9xRkRAoDQt1b7EeaAUz/F5K4mJ3JqtrqsrlNc+9XYkvkl75QJJ5S30xNHkgxdoe
	 G/mrvK/d8Hk7Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 11/17] mm/damon/sysfs: implement probe prep directory
Date: Sat, 25 Jul 2026 14:59:21 -0700
Message-ID: <20260725215922.136622-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725211041.294C11F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:10:40 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The static constant `damon_sysfs_prep_ktype` is defined but not used anywhere in the file.
> --
> 
> --- Patch [11]: [RFC PATCH 11/17] mm/damon/sysfs: implement probe prep directory ---
> commit a150eac865fe6562090f70dc8b3909c07dadeb09
> Author: SJ Park <sj@kernel.org>
> 
>     mm/damon/sysfs: implement probe prep directory
>     
>     Implement DAMON sysfs directory and files for specifying each probe prep
>     action. Introduce only preparatory data structure and functions, without
>     wiring them up yet.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 38affef08d0fb..8f9a5df598c51 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> 
> [ ... ]
> 
> > +static struct attribute *damon_sysfs_prep_attrs[] = {
> > +	&damon_sysfs_prep_prep_action_attr.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(damon_sysfs_prep);
> > +
> > +static const struct kobj_type damon_sysfs_prep_ktype = {
> > +	.release = damon_sysfs_prep_release,
> > +	.sysfs_ops = &kobj_sysfs_ops,
> > +	.default_groups = damon_sysfs_prep_groups,
> > +};
> 
> [Severity: Low]
> Since this patch introduces preparatory data structures that are not yet
> wired up, the static constant damon_sysfs_prep_ktype is defined but not
> used anywhere in mm/damon/sysfs.c.
> 
> Could this trigger a -Wunused-const-variable warning when building the
> kernel with W=1?

Good catch.  I will fix in the next revision.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725210225.129944-1-sj@kernel.org?part=11


Thanks,
SJ
