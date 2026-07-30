Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6949620
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369993; cv=none; b=k2E2nZLWcuO9Ont5Hyqa7CB0nha84WZXlO8xoC4bQ6VWGaLn6fDN7r+/pc6kZgHsvYH/dOqrP7UReRjfzkVQaIHLjxfJ+eAITjZl21lpGvLmf0ObfaYUMsh0zZc8Tty2aBIDPwRjRlZw7u7jq2NJFct2jBxVQwiU8ozzIMCr02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369993; c=relaxed/simple;
	bh=5QCpc+TQOXVW48lee2EbkKwv0lEGHq9nS4xqj4EJ0No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kX6R6Ocy8EhsS2hQWZU0Mmt/8RCDa+I3rTG9Ak1BS6pqGX7Ivg97WobCTbQY3oh5+vUZTmpWr1qa6kipaPpCI0aca71S/5OMgh0Rx4J0eCgFoULmwna8LIMw9yhL6BTp/sg1h1zRF6Famehm/OLle0zlJSz5m5lze+y/kYiATmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG0oshTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG0oshTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34481F000E9;
	Thu, 30 Jul 2026 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369991;
	bh=FP4KjuQcuEWOskcpzcVQrDt84FKposokOCqJ3EXNPYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gG0oshTaZoVQnM8VuZWGIlvVrIn5FiCV2rOVgLF4/5P0eliiWB165sCMcKHVCGEqH
	 yxYpkdkiyPVjUxafNLjAYVz7poHxnc16dWvE7fga2Ay3c48xCNztlaHGqNWCgOfFSX
	 /ufaxvXdqlP+ecadQTt9U5i3gxcSRcMB/nWLWTFrI+ZJL3E6snN5o9sDGEB98JPJdx
	 xyA0tBvLGgFAgHu3BfeZcU5xKBGfO4s9/fv49aUKPBDI6MhcvaswO869XLeaHXKPno
	 Pzwm+PWiXSJyBQwF/IpXdogrDMN6xa4XF08C5LC21hVGKzIwyhYMOMsP2MZpx0WAJY
	 6xJFvpP72F/JA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/6] selftests/damon/_damon_sysfs: implement DamonProbes
Date: Wed, 29 Jul 2026 17:06:23 -0700
Message-ID: <20260730000625.100004-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729150439.93E021F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 15:04:39 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The error result of `write_file()` for setting the probe weight is silently discarded.
> --
> 
> --- Patch [3]: [RFC PATCH 3/6] selftests/damon/_damon_sysfs: implement DamonProbes ---
> commit 12ef2c079bfc3ec5e9f25fc085e18c6bca931488
> Author: SJ Park <sj@kernel.org>
> 
> selftests/damon/_damon_sysfs: implement DamonProbes
> 
> Extend _damon_sysfs.py to support staging and committing DAMON probes.
> It will be used for setting DAMON probes via sysfs changes for testing
> purposes.
> 
> > diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
> > --- a/tools/testing/selftests/damon/_damon_sysfs.py
> > +++ b/tools/testing/selftests/damon/_damon_sysfs.py
> 
> [ ... ]
> 
> > +class DamonProbe:
> > +    weight = None
> > +    filters = None
> > +    probes = None
> > +    idx = None
> > +
> > +    def __init__(self, weight=0, filters=None):
> > +        self.weight = weight
> > +        if filters is None:
> > +            filters = DamonFilters()
> > +        self.filters = filters
> > +        self.filters.probe = self
> > +
> > +    def sysfs_dir(self):
> > +        return os.path.join(self.probes.sysfs_dir(), '%d' % self.idx)
> > +
> > +    def stage(self):
> > +        err = write_file(
> > +                os.path.join(self.sysfs_dir(), 'weight'), '%d' % self.weight)
> > +        return self.filters.stage()
> 
> [Severity: Medium]
> Is err intentionally ignored here? If write_file() fails to write the weight
> to sysfs, it returns an error string. Returning self.filters.stage() directly
> without checking err will swallow the error and might cause tests to proceed
> with incorrect assumptions about the probe configuration.
> 
> Should this check err before returning, similar to how it is handled in other
> stage() methods?

Good catch, I will fix.
'
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729144738.90895-1-sj@kernel.org?part=3
> 


Thanks,
SJ
