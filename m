Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B9800
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382924; cv=none; b=sUmT2iZWOytvoYnOaxwR4d7BJSzYAXW9dGmz2Df8zBH3YccmNrxtsF2D28LMi6ngVriFZeISiBMQPJ17DsymsDkLSCL0rJCIGllQY9xfpKsXf9Kc5an7oloFj2/AcYaxRHRyu6TGx5U+IzQKXNWuQSNJiXBZEngL5G8YjPreZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382924; c=relaxed/simple;
	bh=w38Jo3HSf5Rf5c77KqCOI2paq65Ym6kQlQ7HSbfuvm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dv6ZZmOKwJ1W+aaKEOeJSy3Sua/QLNQD7jxn1T+0dFHCPsHJV49kRv1DE8px3IQqUTf0+JrL0Jt1V5puEAgxeqqOyCf15eOb0OiHe3r7ZeRmNB9XbAIp3kHhXPiMMzFtrThtgkB542ycpkKvsOK2/igQ8bC/iFr3RwLjKQ4eVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+ET8R9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+ET8R9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7780B1F000E9;
	Tue,  7 Jul 2026 00:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382923;
	bh=V6fhmUOY2yR9Ca+eTIKTWpmX/aKYMc3V7R4V6MpHgTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l+ET8R9BA8Ii/vRESAnvFo2rUjUIeK0xy5IsclmWU6eidGwITxSdrxm7LwrpjO92z
	 rFuMNbQfvwhnRFhkADv1z8X/Ul6OWamKK3sCRLPh5s5/oErBqgkm4bGsomggyf2qbK
	 EemE00xAb0Oqzj8k/F8QpF5KY4USn+S1gEJurR28ty4YLY7c74CbgXDPRUxS8JTzY+
	 /jQ9neaZ2g9V4f98/3kVamU+nT1HI/w+jcYmzp5C1RLXravSCeB9utluc/ZwWaH1cg
	 3heONdfTPxKXGc4m/HPZxSblDhLb0U2LBmJEHDXsymErWOBHyRqpIZer/XjL84osHv
	 StAmhnqOySyGQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 13/16] mm/damon/sysfs: implement probe/weight file
Date: Mon,  6 Jul 2026 17:08:39 -0700
Message-ID: <20260707000841.97795-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706151939.847A71F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 15:19:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unbounded `weight` from sysfs causes an integer overflow in `damon_probe_hits_wsum()`, which corrupts the core region scoring algorithm.
> - [High] Setting a large `weight` via sysfs trivially bypasses the `max_nr_regions` limit, leading to unbounded kernel memory usage and CPU starvation.
> --
> 
> commit 13d5322850c993787f439a6daf8065f8717e7f80
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: implement probe/weight file
> 
> This commit implements a new sysfs file, weight, under the probe directory.
> Users can set the probe weight and enable monitoring using it.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index b65651498e0d1..a8ef7903bf94f 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> 
> [ ... ]
> 
> > @@ -1100,12 +1101,35 @@ static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *probe)
> 
> [ ... ]
> 
> > +static ssize_t weight_store(struct kobject *kobj,
> > +		struct kobj_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct damon_sysfs_probe *probe = container_of(kobj,
> > +			struct damon_sysfs_probe, kobj);
> > +	int err = kstrtouint(buf, 0, &probe->weight);
> 
> [Severity: High]
> Does this allow an unbounded unsigned int weight to be set, potentially
> causing an integer overflow during calculation?
> 
> In damon_probe_hits_wsum(), the score is calculated by multiplying the
> hits and the weight:
> 
> mm/damon/core.c:damon_probe_hits_wsum() {
>     ...
>     sum += r->last_probe_hits[i++] * probe->weight;
>     ...
> }
> 
> Because weight is allowed to be up to UINT_MAX, and probe_hits can be up to
> 255, could this calculation wrap around? If it wraps around, regions with a
> higher number of probe hits might erroneously compute a lower weighted sum
> than colder regions, which seems like it would break the ability to
> accurately track memory.

A minor issue for unlikely user setup.  But I agree this is better to be fixed,
and the core layer parameters validation makes this easy to fix.  I will work
on fixing this, in the next version of this series, or separately.

> 
> 
> [Severity: High]
> Could a large weight bypass the max_nr_regions limit and lead to unbounded
> region growth?
> 
> In kdamond_merge_regions(), the merge loop condition checks against max_thres:
> 
> mm/damon/core.c:kdamond_merge_regions() {
>     ...
>     } while (nr_regions > c->attrs.max_nr_regions &&
>              threshold / 2 < max_thres);
>     ...
> }
> 
> The initial threshold scales with the unbounded weight. If a user configures a
> large weight, does threshold / 2 immediately exceed max_thres on the first
> loop iteration?
> 
> This would cause the loop to terminate prematurely, failing to iteratively
> increase the threshold to merge regions. Could this allow the number of
> regions to grow without bound and lead to severe CPU starvation?

Yes, but only for one aggregation interval.  I don't think this is an issue.

> 
> > +
> > +	return err ? err : count;
> > +}
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706141912.88445-1-sj@kernel.org?part=13


Thanks,
SJ

[...]
