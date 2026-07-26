Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6613783A1
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785094877; cv=none; b=KxlbVTishqJY3p/9OCmk7K9332wWUJDFy/8vy4Bp/Vg8my2ZTFmKkjNEmS6BVd7rkOXQhEGkaipD8cNb7QXhONEaswoiANRZquJW0Ur/x1v8eL8AmWE+4Im+H3hQ0wkvxZ/CrBM6NVSBZuoV5pItO6nk0hqXzVMvgVbtOCfHwxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785094877; c=relaxed/simple;
	bh=2miZb36A/6k5PLlfhSLfV/AIlRM3r5QT0ASqYKxKA/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c44liIdS5IhWi0fa2vQr60xykz3XskcPxY5vR8ayWrK0ofsE0Mrvlsy+qSozQWiTF4GVLb+MKWwkt1SEtbUV8aXx8IFls586HfAn0JtBx/Lq5zO1eoWXR24ZkSeZ1oxXgKrnoMUTfel1Eg1Vt0qNreNArleC9i2Y2ElKC4z5PYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXDJnpjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXDJnpjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DDA1F000E9;
	Sun, 26 Jul 2026 19:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785094875;
	bh=GNpCZNk80g6QHKEuWDA4JDVaPxK7JSDETfUmgpEowOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXDJnpjEC8Q83knYBKk408nquYs23TOrsJyh36BAiFOdIMhZtNih4+d9dZBMoSK0c
	 /Qz6OsbyPrZy2XsHoxiSWLnm7+Pn5/MAO+brzsQcQBW9mAB2Ltf0+vCmbGPl2OSESw
	 V8Aprk5SsukrHZcizNOLpCB1TfFF1wNETeWEc4rhH1AwDr886Be5P6nZJ0FShrAZuf
	 ncokt99yWtef+EDkDMcQdlA64MfKBB+8FJRFIpphubFVBg9BEhP3oxme5kXfxK7fBn
	 CKijZ90Yq5Eevlxd1rkovV7xzUjrtKNBxUBo7OKffE/rKAW15AbRZSl/gZnpSJI+zk
	 BT9woItOspb/Q==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 09/17] mm/damon/sysfs: implement preps directory
Date: Sun, 26 Jul 2026 12:41:06 -0700
Message-ID: <20260726194107.11045-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726185424.2152-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 11:54:32 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 26 Jul 2026 17:46:08 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] The kobj_type structure `damon_sysfs_preps_ktype` is missing the `static` keyword.
> > --
> > 
> > --- Patch [9]: [RFC PATCH v2 09/17] mm/damon/sysfs: implement preps directory ---
> > commit 8155aac7530c47520c4a221fb588dbd6e53e3875
> > Author: SJ Park <sj@kernel.org>
> > 
> > mm/damon/sysfs: implement preps directory
> >     
> > This commit implements a sysfs directory and a file for setting DAMON probe
> > preps. It introduces the preparatory data structures and functions without
> > actually generating the directories yet.
> > 
> > > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > > index 50ff1c172d746..bf65e87fcb521 100644
> > > --- a/mm/damon/sysfs.c
> > > +++ b/mm/damon/sysfs.c
> > 
> > [ ... ]
> > 
> > > @@ -750,6 +750,74 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
> > >  	.default_groups = damon_sysfs_intervals_groups,
> > >  };
> > >  
> > 
> > [ ... ]
> > 
> > > +static struct attribute *damon_sysfs_preps_attrs[] = {
> > > +	&damon_sysfs_preps_nr_attr.attr,
> > > +	NULL,
> > > +};
> > > +ATTRIBUTE_GROUPS(damon_sysfs_preps);
> > > +
> > > +const struct kobj_type damon_sysfs_preps_ktype = {
> > [Severity: Low]
> > Does this inadvertently expose damon_sysfs_preps_ktype to the global
> > namespace?
> > 
> > It looks like the static keyword is missing on the definition of
> > damon_sysfs_preps_ktype, which will cause it to be globally visible and may
> > trigger static analysis warnings.
> 
> This is an intended thing, for not causing build warning, while splitting
> change in reviewable size.

I will fix this.

> 
> > 
> > > +	.release = damon_sysfs_preps_release,
> > > +	.sysfs_ops = &kobj_sysfs_ops,
> > > +	.default_groups = damon_sysfs_preps_groups,
> > > +};
> > > +
> > >  /*
> > >   * filter directory
> > >   */
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260726173935.94046-1-sj@kernel.org?part=9
> 
> 
> Thanks,
> SJ
> 


Thanks,
SJ
