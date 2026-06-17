Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086011E1E04
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658718; cv=none; b=VZLhdAje6R8jgp8r8Du/sZoDEDKuGosfPUy7BFrHr+Fc2SbFYaoVGRirBqAD6G7kQseGR1cIgWbbmhjMHdsQ21ofye9W/lbVvUfLKUPRtN9UjyQoDYJELEQ4bWMHpm8YmjwRHb3OIyReAFM4Q4vBnQ/uQF+5YDs+88Yrl/V1rcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658718; c=relaxed/simple;
	bh=HkbJ/Bq/cGBFn/3V9VMHTlUCh2fFHjrXmlsFdrLc89w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMJlscQx6aD4HZJqZvrXRj0mVfRoIql3kBJpXQaRZ8PzeTVWvjhnx+QUmTtBzVn5clh8DbNoQfw7HK0v+9j830YvLr/BTTv5M1ORrHPc9wf7lltw09GXC63FudVxp7G+vHfyGzbZxck3RFcvGMB/MfGHnsszJ32KpzmT0XTC/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwZ6KCOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwZ6KCOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FE91F000E9;
	Wed, 17 Jun 2026 01:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658716;
	bh=+aVI6aQiE4DBg2q8x1jsyHNi8iWCTavM7iz8PQ2kMoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nwZ6KCODJzbFn578WsVHFJyyjtI86i5k9i/7UXHGtJzdqmESF/IUJdZZe5p3eQeDt
	 WmGJHOz0yjJ7jxiZy83YZndUhOVV7r+AfiLzn7Z2H6uWz2eTcwB4yBbipldkTGMnSS
	 BGtTLXlk6NSZwBGKzCZFbklmjyhvX7QaycJdqhzAGAjDfKKaoIQ6vePBSRYGYZRsgQ
	 Xqfud2Lu60nwGxPpgvArcnNZJy1N+uGCme6jTpbklm83r6168Xy57KHGyoJ/bIrYM/
	 VQo06fzTFFpj6er0PgodQrCoJ/ZRZr9BhQG0T9H7VhrWAgsBRdDFLLfxMtA8oYCMp4
	 nyJ7jb0JM4kQg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 9/9] mm/damon/sysfs: kobject_del() probe dirs
Date: Tue, 16 Jun 2026 18:11:45 -0700
Message-ID: <20260617011146.97423-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616152411.AD0241F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:24:11 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] The patch adds `kobject_del()` to `damon_sysfs_probes_rm_dirs()` to fix sysfs name collisions caused by delayed kobject releases, but misses the exact same flaw on the error paths of `damon_sysfs_probes_add_dirs()` and multiple other array-building functions. This leaves the system vulnerable to `-EEXIST` failures upon retry after an error.
> --
> 
> commit 4a5efc2733f009261a15fd64a4d901ca19499bb5
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs: kobject_del() probe dirs
> 
> This commit fixes a directory creation failure caused by name conflicts
> when CONFIG_DEBUG_KOBJECT_RELEASE is enabled. It adds missing kobject_del()
> calls during the removal of probe directories.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 04725ff3d9f3c..04ca0a34e1206 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1139,6 +1139,7 @@ static void damon_sysfs_probes_rm_dirs(
> >  
> >  	for (i = 0; i < probes->nr; i++) {
> >  		damon_sysfs_probe_rm_dirs(probes_arr[i]);
> > +		kobject_del(&probes_arr[i]->kobj);
> 
> [Severity: Medium]
> This is a pre-existing issue, but it looks like the same lack of
> kobject_del() on error paths could cause name collisions upon retry.
> 
> For example, if damon_sysfs_probe_add_dirs() fails inside
> damon_sysfs_probes_add_dirs(), the error path drops the probe by calling
> kobject_put() without kobject_del():
> 
> mm/damon/sysfs.c:damon_sysfs_probes_add_dirs() {
>     ...
> 		err = damon_sysfs_probe_add_dirs(probe);
> 		if (err) {
> 			kobject_put(&probe->kobj);
> 			damon_sysfs_probes_rm_dirs(probes);
> 			return err;
> 		}
>     ...
> }
> 
> Under CONFIG_DEBUG_KOBJECT_RELEASE, if userspace immediately retries the
> operation after an error, won't kobject_init_and_add() fail with -EEXIST due
> to a name collision with the lingering directory?
> 
> Should we also add synchronous sysfs deletion via kobject_del() to these
> similar error paths?
> - mm/damon/sysfs.c:damon_sysfs_targets_add_dirs()
> - mm/damon/sysfs.c:damon_sysfs_contexts_add_dirs()
> - mm/damon/sysfs.c:damon_sysfs_kdamonds_add_dirs()
> - mm/damon/sysfs-schemes.c:damon_sysfs_schemes_add_dirs()

Yes.  Sashiko reported same issues in other replies to this thread and I will
fix these in the next revision.


Thanks,
SJ

[...]
