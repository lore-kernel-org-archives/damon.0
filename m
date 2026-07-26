Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5733783A1
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785094938; cv=none; b=FE6QFL23Xk+oHQ42dpMjpd7MLUnjjaZr1lrdlegp44AFOcjKNOdIEIsQp/4SEj9L5q1zYMtMdzNiO8KiZUXA8telDaMZc44/Tbx+DjKr++0l8tzBRAPgXWco9oQYEMmJtlPexGG7cF9BLRoz4BA4PFXLamd6QqpHOxns1GDgMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785094938; c=relaxed/simple;
	bh=PrRzKjNKZ6E3BokBzaer+d2p+WgqMw2XdtkojDoB1H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZAKZYCNVwqziNv1BAMTi2NZbvg52aciOLwY2uSGXxgHqs5V4QNuoEN+k3IpNp4I03PR5CmkssjSRnzu1V+5/SJNDLpVhWll1tBniMTs++xfluxJz4K327g0BfnFK/Ibz8nOKV9f6iUz+dIMBWrD/FPDAYsHwRXoL+5q5BPVtqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcqo3tCt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcqo3tCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBF71F000E9;
	Sun, 26 Jul 2026 19:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785094936;
	bh=EVvW6CI8Jpdl9JSI1VOD6oWuMeAs5PASLVVcNI7Wnhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kcqo3tCtwnpEGhNSvn5rGlRR16fbo3pf08K71VMj94bY1lhSvVLG9nbJZgqybIOd4
	 TvTCF0Tnk8Wn4NaiaVzqeEhSiuZkcgV5kSTNqFlOOnXEeZ1jxBRkRoylkEIKeeVTql
	 Zm1KbFTHvgfE9mOJFqjWpxcc3o+MijNkgU59ya5/1ELYIwz0qyj8y+RM452MUXyal/
	 DksWp5wtgdQKoT/tazYsDEeRHMPqYgRLbwvrsjLrYPUaz2XCi7oXG8wE8sKVlzQvlC
	 xie51b0NzepFAjdg2ETnkHVqfpzh2cUxrPPX5gf7pTVzhi8IQkLLgUAhiv8+/l8r+9
	 St7cezTxiWfEw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 11/17] mm/damon/sysfs: implement probe prep directory
Date: Sun, 26 Jul 2026 12:42:09 -0700
Message-ID: <20260726194210.11175-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726185713.2836-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 11:57:15 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 26 Jul 2026 17:47:43 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [Low] Missing `static` qualifier for `damon_sysfs_prep_ktype`.
> > - [Low] The `name` field in `struct damon_sysfs_prep_action_name` is declared as a non-const `char *` but initialized with read-only string literals.
> > --
> > 
> > --- Patch [11]: [RFC PATCH v2 11/17] mm/damon/sysfs: implement probe prep directory ---
> > commit ec46e0d8618f958d1edbf7e0edacd883d4e30bde
> > Author: SJ Park <sj@kernel.org>
> > 
> > mm/damon/sysfs: implement probe prep directory
> > 
> > This commit implements the DAMON sysfs directory and files for specifying each
> > probe prep action. It introduces the preparatory data structures and functions,
> > though the files are not yet created under sysfs.
> > 
> > > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > > index 38affef08d0fb..a33423d997f59 100644
> > > --- a/mm/damon/sysfs.c
> > > +++ b/mm/damon/sysfs.c
> > > @@ -750,6 +750,89 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
> > 
> > [ ... ]
> > 
> > > +struct damon_sysfs_prep_action_name {
> > > +	enum damon_prep_action action;
> > > +	char *name;
> > 
> > [Severity: Low]
> > This isn't a bug, but should this field be a const char * instead of
> > char *? The damon_sysfs_prep_action_names array initializes it with
> > read-only string literals like "set_pgidle".
> 
> Good suggestion.  I will constify both fields.
> 
> > 
> > > +};
> > > +
> > > +static const struct damon_sysfs_prep_action_name
> > > +damon_sysfs_prep_action_names[] = {
> > > +	{
> > > +		.action = DAMON_PREP_SET_PGIDLE,
> > > +		.name = "set_pgidle",
> > > +	},
> > > +};
> > 
> > [ ... ]
> > 
> > > +static struct attribute *damon_sysfs_prep_attrs[] = {
> > > +	&damon_sysfs_prep_prep_action_attr.attr,
> > > +	NULL,
> > > +};
> > > +ATTRIBUTE_GROUPS(damon_sysfs_prep);
> > > +
> > > +const struct kobj_type damon_sysfs_prep_ktype = {
> > 
> > [Severity: Low]
> > This isn't a bug, but is the static qualifier missing here? Without it,
> > damon_sysfs_prep_ktype is exported globally which might trigger build
> > warnings like -Wmissing-prototypes when compiling with W=1.
> 
> It didn't warn on my setup.  Let me think more...

I still cannot make the warning on my setup.  But the theory makes sense.  I
will fix this by changing the patch sequence.

> 
> > 
> > > +	.release = damon_sysfs_prep_release,
> > > +	.sysfs_ops = &kobj_sysfs_ops,
> > > +	.default_groups = damon_sysfs_prep_groups,
> > > +};
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260726173935.94046-1-sj@kernel.org?part=11
> 
> 
> Thanks,
> SJ
> 


Thanks,
SJ
