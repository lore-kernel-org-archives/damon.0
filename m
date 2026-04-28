Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94718EFD1
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 03:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777347707; cv=none; b=CxL6CcPMDpGUCmcYh+FAzDOMvQ9iGYTumiZhqMPhTd2381ksrt77frYJ7YK5UEsttGdmo/hmAiY/PzIkaedn9uKbVTw1C1ivVmlBDxwPIrX4RibxmmoQP8mOq/ib+2GFTgv4+0XoCUwqLQjTG0YIRUSm3owrtGTaeVmTpI6p8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777347707; c=relaxed/simple;
	bh=Dij4XgmfDRy06awHHr6amKWqxdctBDKG7Rrl3QcK/vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpc1g8b9OIonFtZrvzYSXgElrWqEEpPPJOofXRTeSALJh3m0M/FItSyAeY9b1X1jNz41+5DY81EzTc5fsGwG/mX7XqqpZtwg8FnTwj7v5ZccTI0NCoLICKW0YA4yBCarag3ZhEB26E07m+ldk2eFTXsN3Wdne6GImDZgYePDsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD+nwwDT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD+nwwDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE33C2BCAF;
	Tue, 28 Apr 2026 03:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777347706;
	bh=Dij4XgmfDRy06awHHr6amKWqxdctBDKG7Rrl3QcK/vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tD+nwwDTiN882DwirJQMoQLfa9yQipZbklRirl8zqDKeEMMrn/ZiRk9phY4ZCwldv
	 IKH1x1aQvoxZI9713CxIwa0ck9ObUr4j6Mj1NBMLT4YSVXOWl/Le7gl19WQkJ2wgtA
	 aSOqDLcPr4DeQKuUaVxgiqUkjDGuqsDJ279iqGLfm+6V9FL60qqIrzHKtZ7eEsJxfU
	 1D6ef59iXGCOJzD5PF8Tr1F2wh1uafTqRuuXz63qxiRrcGPxbnm09jArgU9r9zi9ab
	 Tk9r52yXCnC0xCsJBeORBDxHGm4uGw9cQAvwWwLUoXxCMB8nChoDYeF3eVHTAawCwA
	 0GcYQj92LLgEw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 04/11] mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
Date: Mon, 27 Apr 2026 20:41:38 -0700
Message-ID: <20260428034139.115984-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428015436.8D935C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Apr 2026 01:54:35 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [Medium] The sysfs store functions for `fail_charge_num` and `fail_charge_denom` do not validate or bound the ratio, leading to potential integer overflow in the core quota tracking logic.

No blocker.  Please read below for more details.

> --
> 
> commit 43a135a4abb7954bcb255ae58b1aa323b2447477
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
> 
> This commit implements the user-space ABI for the DAMOS action failed region
> quota-charge ratio setup. It adds sysfs files for fail_charge_num and
> fail_charge_denom to allow reading and setting the numerator and
> denominator of the failed regions charge ratio.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 04746cbb3327..dee1f5788bea 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> [ ... ]
> > +static ssize_t fail_charge_num_store(struct kobject *kobj,
> > +		struct kobj_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct damon_sysfs_quotas *quotas = container_of(kobj,
> > +			struct damon_sysfs_quotas, kobj);
> > +	int err = kstrtouint(buf, 0, &quotas->fail_charge_num);
> > +
> > +	if (err)
> > +		return -EINVAL;
> > +	return count;
> > +}
> 
> Can this unbounded input lead to an integer overflow in the core quota
> tracking logic?
> 
> The values read via kstrtouint() are unconstrained up to UINT_MAX. Later, in
> damos_charge_quota(), these values are passed to:
> 
> mult_frac(sz_region - sz_applied, quota->fail_charge_num,
>           quota->fail_charge_denom)
> 
> If the region size in bytes is large (for example, a single DAMON region of
> 10 GB) and the numerator is set near UINT_MAX, their product could exceed
> ULONG_MAX. For instance, 10GB * UINT_MAX is roughly 40 * 10^18, which is
> larger than ULONG_MAX's 18.4 * 10^18.
> 
> Could this cause an overflow that wraps around to an anomalously small value,
> effectively bypassing the administrator's configured quota limits?

Yes, and the real world use case ain't set such extreme input.  Even if the
overflow happens, the impact is minor.

> 
> > +
> > +static ssize_t fail_charge_denom_show(struct kobject *kobj,
> > +		struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct damon_sysfs_quotas *quotas = container_of(kobj,
> > +			struct damon_sysfs_quotas, kobj);
> > +
> > +	return sysfs_emit(buf, "%u\n", quotas->fail_charge_denom);
> > +}
> > +
> > +static ssize_t fail_charge_denom_store(struct kobject *kobj,
> > +		struct kobj_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct damon_sysfs_quotas *quotas = container_of(kobj,
> > +			struct damon_sysfs_quotas, kobj);
> > +	int err = kstrtouint(buf, 0, &quotas->fail_charge_denom);
> > +
> > +	if (err)
> > +		return -EINVAL;
> > +	return count;
> > +}
> 
> Does the fail_charge_denom input also require bounding to prevent the same
> overflow issues when passed into the quota tracking logic?

My opinion is same to the above one.


Thanks,
SJ

[...]
