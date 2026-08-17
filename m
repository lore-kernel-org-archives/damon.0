Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DB282F24;
	Mon, 17 Aug 2026 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975664; cv=none; b=nu+gW0NhhOGpLyfNHl7uXArPYWPHKBqLUQejZaXiMmX65+rlyHCPG4bdQz6Jyauh3wgxARwBfaZ/cSzrBX0BQ4GPqnobb1/f3ZHKHDJ9w4hgck5B7dbAQhCnqqOswc/bdVpJ2yGsJ98XBBRT7SLFaOJHRYrRIuKmuaAXky788y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975664; c=relaxed/simple;
	bh=tPg9dr4pDhhAoqCjkmGklRbFhdHoJcRocHKnY4dx1jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXMvfeFRVNPGZp4K81Hbq7D9ypzOrogMkizETA6MytFpr5cybsRd5N3uesrWUSD+3wA7ZuqawME7lTcML0zcQBrZvt3k7hi+aSuQ8SrFn7CVPvnc9Yfh3MZNGiSyWN7DLKWmHThsYRXCnBCBDxlAWIniPebzNE+GvcF1M7oDItw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLOvm30R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLOvm30R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42471F00A3A;
	Mon, 17 Aug 2026 14:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975662;
	bh=BPV0snyvdnGubekf6I4pL7WA2SUpgj+H9hK78RZnmSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oLOvm30R9NwwazdLONwpTMCWBNqGUNUz8swvK7TmqtEVQGGFgzfnZaGl4uIxdWGKD
	 msxm/a/ZLLuzPqGGBFRrG2tprOsW7BqwGO/Xq5DrHPBqkV7dg4CHehvTnxNomSSwPk
	 iU9uC09K121NbhHFFb2XRsSzEzyR+cQQhFcBtqE92Y1Vu0081dh6MvvatBXbro/ERa
	 NHf153tjwpJAMfKB+FH4TEt557UyO4qksP8rvIKl1jozYXM8Y/8peT7wqpe74j8o5h
	 OcC9hhnwVXVpy/mbjev0rX3iw3wYiqeA9jA5EAtKb6REEJo5e3pKlwORmZLvKl+LNk
	 4JEHHyh0SUVVg==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon/core: introduce damon_set_target_pid()
Date: Mon, 17 Aug 2026 07:07:40 -0700
Message-ID: <20260817140740.78251-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817125319.888994-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026 20:53:19 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The logic that finds the struct pid for a given pid number and assigns
> it to a damon_target is duplicated in multiple places.  Including
> damon_sysfs_add_target() of mm/damon/sysfs.c and the start functions
> of the two sample modules, samples/damon/wsse.c and
> samples/damon/prcl.c.  Add a function that does the work, and replace
> the duplicated code in the places with calls to the function.

Looks good to me, thank you!

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term, I will ask mm.git maintainer (Andrew Morton) to pick
this.  Note that we are in the middle of the merge window.  The action would be
made only after the end of the window.  So, no action from your side is needed
for now.  If it seems I also forgot doing that or you cannot wait for my
action, please feel free to directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
