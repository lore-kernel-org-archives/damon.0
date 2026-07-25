Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8422E7BD6
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785016670; cv=none; b=n4Ts9wDTL6w3TB9UlQHtgJrCKc0ypJVtwtrNLoi9tHNkp+VP/ewY5F09dYvlQRxLtFrm1Y9Eo2cAqLusisJxs+yZUOGkLwzZwKb/4ROnivJXLuymw3IajPTmGCLTtCGrQm5spUreCqJYUaKVv0u1RdLYL+YYbCTWYmN/pYobG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785016670; c=relaxed/simple;
	bh=c3EGDEf+TcyOo9Z4/sq/TwmfJ/UvKk5MMYtP4jQjqhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8OW4T3TjJCEIM9UBkQKL6rP6lQ3SvocOahGfMvC+Q4/3bEs+yhxIQqp3KLvgfTYkyshjz3NneqKQYckShq4Kjai6znHs/nzdknS5eYpicuXlrzX6GBv0XN9z8tWS4ytEf+GHNsHJmVTiF6Tkpget9VrOWmzT2yhbPoGlpIQPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2GO7Lqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2GO7Lqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4B71F000E9;
	Sat, 25 Jul 2026 21:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785016668;
	bh=ibmX9By0vVKgS4Fcknu9RfvZg6Oe/SuR0W+0uY2cd7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m2GO7Lqzv+qt8BIZWhXUcYRy0CC0BGpCrfLdaOasT3XH75fxl22Mud+iPbV8Z6LYA
	 UIO6983pENj6VKFpvY9qziCqMVmDKL9cH6Ti4ExJMZfVNPwcgsbmoBPf4EglxtEJGG
	 yeZnPCkttDc5+hENm5jGubBS/ZkPXAavnGCs/4vpWBeBvjMz2xF5JY/R3ke/XrbobY
	 4is3g4IQ8iSqJpDkXt6QRplFS6hH2+/abG9XLn7DY54oa6lF0dGDBOSaX07T7F8G+q
	 MhnQVgomU9hAfxktYx6kySHLHoIKePVJ1gO7Yp8SqqSDjfn/FJJpMznN+/+RkrmBVW
	 TarbCoF6r4jsQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 09/17] mm/damon/sysfs: implement preps directory
Date: Sat, 25 Jul 2026 14:57:40 -0700
Message-ID: <20260725215741.135157-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725211338.D65B91F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:13:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The `damon_sysfs_preps_ktype` static constant is defined but never referenced or attached to the sysfs hierarchy, resulting in an unused variable.
> --
> 
> --- Patch [9]: [RFC PATCH 09/17] mm/damon/sysfs: implement preps directory ---
> commit b804c7747bd623e2ca58a340a5342097faad4841
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: implement preps directory
> 
> This commit implements a sysfs directory and a file for setting DAMON probe
> preps. It implements only the preparatory data structures and functions without
> generating the directories at the moment.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 50ff1c172d746..6910a0f31697a 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> 
> [ ... ]
> 
> > +static struct attribute *damon_sysfs_preps_attrs[] = {
> > +	&damon_sysfs_preps_nr_attr.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(damon_sysfs_preps);
> > +
> > +static const struct kobj_type damon_sysfs_preps_ktype = {
> > +	.release = damon_sysfs_preps_release,
> > +	.sysfs_ops = &kobj_sysfs_ops,
> > +	.default_groups = damon_sysfs_preps_groups,
> > +};
> 
> [Severity: Low]
> This isn't a bug, but since damon_sysfs_preps_ktype is defined here without
> being referenced or attached to the sysfs hierarchy, will this cause unused
> variable compiler warnings?

Good catch.  W=1 build shows the warning.  I will fix this in the next version.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725210225.129944-1-sj@kernel.org?part=9


Thanks,
SJ
