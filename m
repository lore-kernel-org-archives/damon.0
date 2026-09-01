Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F01E0E14
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223574; cv=none; b=i9i1hMxQn0JpNcRw/bR8piDHMk7zl/OmwOC6yMZrqUra+amTxq6rD0o7lZbm5ATbDs4cOaGMK91dgN9mW4rkuLL+jwS0bkGbgtI8FKLbzh0g2ZDlxYdAptlC5LOkr2iA0L76IAzBiFVNrAQUa8MBYfbegFVOD0Q77/RJdsUwKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223574; c=relaxed/simple;
	bh=FhbSbnM2vJfDqaqqb1pfXGX9nauOAXE33ErPTBr47is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJ+Rt/wGqvRJsPgdFTHa4G9dJvC+7FZO4mQ0NE5EyupI5XThRsQYiQm1SlEo+4ktf4EasRKF2rtOb5h7RqxoDfAz6S4KfGTYx0NidG83pBbnLzdM3vFZYAowJ18qeRi6t+9iTtxGe55P2tiVVA1mxL943KwOUoowB/5rQxRJUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8/T3CSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8/T3CSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BF71F000E9;
	Tue,  1 Sep 2026 00:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223573;
	bh=ct8h1tVpXmvZuAbs0ShTaKlRAhQNyGVfetoTUx4+Y+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m8/T3CSJ/VFOLfaV8PDqQQIIRLNSqv1eCnxvC95b2qz1oVRTaqbbnREb76DO6ypj7
	 kC52ocJbjSY/nnc+EGoebcz9Msizy13H9DYEqDXSz0ErTOF0LlaKEYleeZieR+vjF5
	 +039e7/p1MTHQOxRxwcL8FXYQhgsMa2fdKF9RhiTYhZHSwN8mzqsFoi9f6YSyEgNQB
	 cZdoVzYDlICAgaYL5K7ui/zBH3BHhU6yd7A2ASIZhQ8Pdu8aBGkUSaKO28VuaKM0BG
	 11jdjFTkuJEHpCIqrGotkDw9+e0gIgmh1b2Tmv4I+6CoTO/bzlrwpW8RPZTk8hi8eP
	 T0yNCMqkDg9/w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v4 2/3] mm/damon/sysfs: support hugepage_mem_bp quota goal metric
Date: Mon, 31 Aug 2026 17:46:04 -0700
Message-ID: <20260901004606.89531-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831182209.6568A1F00A3D@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 18:22:08 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The new `hugepage_mem_bp` metric is missing from the sysfs selftests.
> --
> 
> commit a2c5ad81dadcc820e74efd9d73c1f576bbe76457
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon/sysfs: support hugepage_mem_bp quota goal metric
> 
> This commit introduces the new DAMOS_QUOTA_HUGEPAGE_MEM_BP autotune policy
> metric. It also exposes this metric to userspace through the sysfs-schemes
> interface by adding "hugepage_mem_bp" to the list of recognized metrics.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 32f495a96b17a..d9b81d7b5910e 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> 
> [ ... ]
> 
> > @@ -1269,6 +1269,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
> >  		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> >  		.name = "node_eligible_mem_bp",
> >  	},
> > +	{
> > +		.metric = DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> > +		.name = "hugepage_mem_bp",
> > +	},
> 
> [Severity: Medium]
> Should the new hugepage_mem_bp metric be added to the DAMON sysfs kselftest?
> 
> Looking at tools/testing/selftests/damon/sysfs.sh in test_goal(), it explicitly
> validates all supported metric strings by writing them to the sysfs node:
> 
>     ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
>     ensure_write_fail "$fpath" "foo" "invalid input"
> 
> Without adding hugepage_mem_bp to this selftest script, the new sysfs metric
> is left without automated test coverage.

I'm working on this, and this shouldn't be a blocker of this series.

> 
> >  };
> >  
> >  static ssize_t target_metric_show(struct kobject *kobj,
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260831144732.80910-1-sj@kernel.org?part=2


Thanks,
SJ
