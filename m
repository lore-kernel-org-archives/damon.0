Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C73D564A
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092236; cv=none; b=e+PiFDssN0jAA/Am17KDjqzW9SkcdtNLy//POcdnGlj4KzwjHnh8TXedOv/RavNTXcM30SbtB3vz1k86EgSXeho6Lo6TVjWzUw0zgXmk7kHp1LtNE59xR1nZGUGTVi7R17oe+ewX0V+xZ0y/K0VSAXRRjBNlLy5hkFN++IF7naY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092236; c=relaxed/simple;
	bh=owzObLNHwbDy9uEtfgfnccvVDuUNMvm7COT6XpO73MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SD+6vKb3D+YggnsziC9CB3B+a79+yJ1DFq7WIDOx5yJ8+wGg7UEkEGhAoEvhFhGQ/bkQvlI/Rl2mBvFRjAmPXOunDMpwhqe10R2PDhQQZQ3QIeikRdpoLYQ+yvaUOnMrflkv8+IeeidYFZcRm4t4gbzsQ1tkJhFyASr3w/fDX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/EckVHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/EckVHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CC21F000E9;
	Sun, 26 Jul 2026 18:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785092235;
	bh=RnJJD7FPgRBXOThj/NRC9OgJ2ryOjjaTR+Amz7U2dek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/EckVHBz6UQD67HtyQDxZrqypdDWWsPtelMRYXhYf0aZ0PncOTl2tGecg10kNBEc
	 RnPtX/3+Q/qPzwUDFFx2o+GoF73CB7rcXnEeNi5J2b4YDDbW9ANtzL8azVLkGxDgpx
	 fg+cu00w1y/LrIqtInqkBCD7txm4D/uem63djvWabv6FX3ppJ8VRljri4Vd11oiSFw
	 eWcva7ilUBKgYHODe5T5uL4EOsitj74qd24nhEflLMXJxfWC67xRBBMz4uKlUeTqhb
	 XTUloG9GukyoEHSrtlIw2JZCU7Qen7n9jd2qiALkB8D0SqWZacfgpepKxVNM7P5v3B
	 PYt37j2xEg8kQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 11/17] mm/damon/sysfs: implement probe prep directory
Date: Sun, 26 Jul 2026 11:57:11 -0700
Message-ID: <20260726185713.2836-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726174744.66A211F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 17:47:43 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] Missing `static` qualifier for `damon_sysfs_prep_ktype`.
> - [Low] The `name` field in `struct damon_sysfs_prep_action_name` is declared as a non-const `char *` but initialized with read-only string literals.
> --
> 
> --- Patch [11]: [RFC PATCH v2 11/17] mm/damon/sysfs: implement probe prep directory ---
> commit ec46e0d8618f958d1edbf7e0edacd883d4e30bde
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: implement probe prep directory
> 
> This commit implements the DAMON sysfs directory and files for specifying each
> probe prep action. It introduces the preparatory data structures and functions,
> though the files are not yet created under sysfs.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 38affef08d0fb..a33423d997f59 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -750,6 +750,89 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
> 
> [ ... ]
> 
> > +struct damon_sysfs_prep_action_name {
> > +	enum damon_prep_action action;
> > +	char *name;
> 
> [Severity: Low]
> This isn't a bug, but should this field be a const char * instead of
> char *? The damon_sysfs_prep_action_names array initializes it with
> read-only string literals like "set_pgidle".

Good suggestion.  I will constify both fields.

> 
> > +};
> > +
> > +static const struct damon_sysfs_prep_action_name
> > +damon_sysfs_prep_action_names[] = {
> > +	{
> > +		.action = DAMON_PREP_SET_PGIDLE,
> > +		.name = "set_pgidle",
> > +	},
> > +};
> 
> [ ... ]
> 
> > +static struct attribute *damon_sysfs_prep_attrs[] = {
> > +	&damon_sysfs_prep_prep_action_attr.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(damon_sysfs_prep);
> > +
> > +const struct kobj_type damon_sysfs_prep_ktype = {
> 
> [Severity: Low]
> This isn't a bug, but is the static qualifier missing here? Without it,
> damon_sysfs_prep_ktype is exported globally which might trigger build
> warnings like -Wmissing-prototypes when compiling with W=1.

It didn't warn on my setup.  Let me think more...

> 
> > +	.release = damon_sysfs_prep_release,
> > +	.sysfs_ops = &kobj_sysfs_ops,
> > +	.default_groups = damon_sysfs_prep_groups,
> > +};
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260726173935.94046-1-sj@kernel.org?part=11


Thanks,
SJ
