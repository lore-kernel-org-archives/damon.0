Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632E288D0
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 04:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214693; cv=none; b=qlHIrSNX5GvwEdtGog/KCClu2BhBH2PTXpfTy4x4Tu4bKa+kHOIYcRawTLsP3Kctl8mPH8Kj8xoWDemjTj2gjvuv9qETVDK+RTFAyJQpLjXQJEXy+wwcQIKTtX1w1WI03fmSPgHDCdgiTI0gKUMzdd54eHu5FQpdko6Ac2LQxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214693; c=relaxed/simple;
	bh=9f62dXr8nmSlvnNQabWZaPBDod+eC2oYXYuHsTNQV6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOTEUb3mDjuTa/G1OPdqHnwg3HL4zYuLHhdhrr8TWN99G6o7DvJj0uAsWt3ihqwsMKBsVsbu70Xr9Gqx7IYHl5ETgfK/g40WcjdTUG2MKlU9/VwOSIg0Mrbqwx/+eSDHNnuATg83ngNRWEgesaRq5+6xsoMAeOaUOF5ScCL3lmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ8IfAkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ8IfAkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A798D1F000E9;
	Tue, 28 Jul 2026 04:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785214691;
	bh=1K8vlbIblVHJ4MXrdbyfzKODpKg5q5BWU5n1ysP25sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJ8IfAkYrAeEXflpczo47ddAw0QL9iU64lqK8wRlXsN+OTsPDEttPsc/rEWcBEZdA
	 3LXHSUgVCtTTqBVdy4gKtAYPC4SyINP6LlGj07k2viNo8JIXO2NnnTWP4ofO+9wiRT
	 JERrztSP1ak7QnHFPI/RC5q9DwRuUnY05l7ysYm6sVv5NabQdN2XV6sPfjtA+E9q67
	 FPn50iGqviwCH7YTT6CXeBpk46Ss6F9KhzlfPocDTkDGM79v24e2mDZo7tnKUyN16T
	 luMIsfAEKP5Um4dremAR7jSDjHBqNyA8PH0LvQuQmk1qHeMV3JsVn2udAd9UvQTHKs
	 yfgRIIamG8qLQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 12/17] mm/damon/sysfs: implement prep_action file
Date: Mon, 27 Jul 2026 21:58:02 -0700
Message-ID: <20260728045802.189993-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728042346.5E3661F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 04:23:45 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `prep_action` configuration is completely ignored and never applied to the DAMON core.
> --
> 
> --- Patch [12]: [RFC PATCH v2.2 12/17] mm/damon/sysfs: implement prep_action file ---
> commit 5572380654e6a74889b64fc57510a982daf24d8e
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: implement prep_action file
> 
> Add a file named prep_action under the prep directory.  It represents
> the corresponding probe preparation action.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index afd39659d6b84..c0130843223d7 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -756,6 +756,7 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
> >  
> >  struct damon_sysfs_prep {
> >  	struct kobject kobj;
> > +	enum damon_prep_action action;
> >  };
> >  
> >  static struct damon_sysfs_prep *damon_sysfs_prep_alloc(void)
> 
> [ ... ]
> 
> > +static ssize_t prep_action_store(struct kobject *kobj,
> > +		struct kobj_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct damon_sysfs_prep *prep = container_of(kobj,
> > +			struct damon_sysfs_prep, kobj);
> > +	ssize_t ret = -EINVAL;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(damon_sysfs_prep_action_names); i++) {
> > +		const struct damon_sysfs_prep_action_name *action_name;
> > +
> > +		action_name = &damon_sysfs_prep_action_names[i];
> > +		if (sysfs_streq(buf, action_name->name)) {
> > +			prep->action = action_name->action;
> 
> [Severity: Medium]
> Are we missing the logic to apply this configuration to the DAMON core?
> 
> Looking at damon_sysfs_set_probe(), it commits sysfs configurations to a probe
> by calling damon_sysfs_set_filters(), but it appears to skip the preps
> directory entirely:
> 
> static int damon_sysfs_set_probe(struct damon_probe *probe,
> 		struct damon_sysfs_probe *sys_probe)
> {
> 	struct damon_sysfs_filters *sys_filters;
> 
> 	sys_filters = sys_probe->filters;
> 	if (!sys_filters)
> 		return 0;
> 	return damon_sysfs_set_filters(probe, sys_filters);
> }
> 
> Does this mean the prep_action configuration is never applied when a user
> commits the context?

A later patch of this series does that.

> 
> > +			ret = count;
> > +			break;
> > +		}
> > +	}
> > +	return ret;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260728041242.187380-1-sj@kernel.org?part=12


Thanks,
SJ
