Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6732116F4
	for <damon@lists.linux.dev>; Sat, 16 May 2026 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893251; cv=none; b=C806pdwh5+MbotlgKIaQW6erz4mVlH0bgXVticuCDN1RuG1k5VBwiA7SI99nZd8Sq0xqe1+Q0inVTfU4QoEbWfrJC+VMtDqzQEhUk8zRXzll7bF25RNMz/OS3AyQATvxRsNeWXkAQTPqLyYH7odOg5/z/AdGcnvmfgiitHrmG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893251; c=relaxed/simple;
	bh=qqRB++de1tXCp7l7p+JtR5tv/9AccUTERL0s3iIq6PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbsBxXNRMDCpEtfy4c4sBsn32ilfqsxM7xcnvucbdmSqHmBVAvQIS4KmFxfbKrpY8vPU7y2tPiKW+j5zzVQWqDW9oRdx7vI37wMycrygkMa4cx7ZcqtBngiOPqwZrYoc8Whw+5Lph5aIgHvzNZwBjVxHItJElgNi0CLrces8pc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcTo3TZZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcTo3TZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADC9C2BCB7;
	Sat, 16 May 2026 01:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893251;
	bh=qqRB++de1tXCp7l7p+JtR5tv/9AccUTERL0s3iIq6PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcTo3TZZrkb/ut8nmSFOP1OckpBBE7S4AhlUAQTQhFMjbYEMLzYu3OWx9L/xKaEeM
	 RT49NDANddY4RUBBzIzNoKebJAa2ZtZchW9qKz9YILlf23kueqLlfitU1UUbods0n7
	 5S+q7AHre33fWiHwprnC9X4pUosjLJmx332MP5n/K+H9AET/6ZWx4fVlP42YhJKoel
	 JUT63AGEnQ8aLVo9NwXL+hYp7BKEEYHWE4sOp30azIs6YINMR47dl4X1WQsrPdxyue
	 +HyjKwgBjgSpEVmoZraPfmpU+ZoBbzYOeVpEOLwV9g8xRcPeXDqzPQiR1BLdssYhhc
	 d1Z9J2bb2cfbA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 10/28] mm/damon/sysfs: implement probe dir
Date: Fri, 15 May 2026 18:00:42 -0700
Message-ID: <20260516010043.145317-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515010815.C6358C2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:08:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The newly introduced kobj_type structure 'damon_sysfs_probe_ktype' is missing the 'static' keyword.
> --
> 
> commit 6edcbcf176b612eae059c59f709c455cff251235
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs: implement probe dir
> 
> This commit implements a sysfs directory to let users install individual
> data probes.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 5f3b253f50ebf..c028e4b1281e6 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> 
> [ ... ]
> 
> > +static struct attribute *damon_sysfs_probe_attrs[] = {
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(damon_sysfs_probe);
> > +
> > +const struct kobj_type damon_sysfs_probe_ktype = {
> 
> This isn't a bug, but should damon_sysfs_probe_ktype be marked as static?
> 
> It appears to only be used locally within this file, and omitting the
> static keyword will needlessly expose the symbol globally and might
> trigger warnings from static analysis tools.

Good finding.  I will add 'static' keyword in the next revision.


Thanks,
SJ

[...]
