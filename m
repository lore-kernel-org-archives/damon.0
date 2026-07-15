Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382A3043DB
	for <damon@lists.linux.dev>; Wed, 15 Jul 2026 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123505; cv=none; b=lN5afBkvJwCpf7ULX5snOhLQa1aqUAGACx5cMaHq5ws1iZHbJJG2f5t/bCWXvnRWK2jluBLOAlHWPWoyE9R94aIPgwLwmaVAnu1mSIW+tHTWffuDhJnAM4CjhXchWqVZW0h++/mKlpB+ffgrqmCRTvg2PdpA71EP+Bqj2CTnmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123505; c=relaxed/simple;
	bh=eEzmv6ZUGeIzlJ0g7QuP1IxqISKojDERCkDOW6EpIFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXdJUM1Kh9ORVXegiA+s7ktQWqLkCH+Wk3x3zgtplVKHBTXNXyhwXYOpQTpe27VQS15gYXH1+tbtu0VVivZoJ8g18jg94kpq1Aj3P/eVQF5aXEyg/vZlTEefk5FafvwbKfLWlrrhVDHJn5mTpL813H3wPzR6jNZyg97UsVeDHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ+pCF2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ+pCF2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5861F000E9;
	Wed, 15 Jul 2026 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123503;
	bh=xl8MgsVuuidoFP+Yzxclzo/8OV5Ija/l9OIf9aYxkAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FZ+pCF2zq0zqhIxsmadNEWDVRHa1VKF2pgQNdZQs7w/42RvDgny2y3hSb7PvOxNvs
	 WMINqVtel/E72j1qXa5He/7sC9N/vp7z++JqOaMl/yO7JqhJ7tQ4XRL3YY1lWo5vwZ
	 KN98djOysR8AX0sDRgIXjZeVDd0QLIXpZdc61AY2F05Z6gCwtkgLTWg8D+BVDDPOmR
	 KPVeI4sJBGqDCPMDXlN1X6QmSi/TA9eDNdEMes0VNJIn/mgED0pS3nJYSXBY2y1LEM
	 v+snosRAoZhOUY84ANKl7G8JH2oIeTenrPTiU8HmwoH246pCXKJBd2pP2l3WAuuLdd
	 s4P+3teS8Aq6g==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Question on damon_sysfs_memcg_path_to_id() path resolution
Date: Wed, 15 Jul 2026 06:51:35 -0700
Message-ID: <20260715135135.83926-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260715063546.1427154-1-husong@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Jul 2026 14:35:46 +0800 Song Hu <husong@kylinos.cn> wrote:

> Hi SeongJae,
> 
> I've been reading the memcg path->id resolution used by DAMOS filters
> and quota goals, and I'd like to ask about a design choice before
> suggesting any change.

Thank you for asking this question!

> 
> damon_sysfs_memcg_path_to_id() (mm/damon/sysfs-common.c) resolves the
> user-written cgroup path by iterating all memcgs with
> mem_cgroup_iter() and comparing each one's cgroup_path() to the
> target.  It could instead call cgroup_get_from_path() directly, but
> the two don't resolve the path the same way:
> 
>   - current code: cgroup_path(memcg->css.cgroup) is just kernfs_path(),
>     i.e. the absolute path in the cgroup hierarchy, independent of the
>     caller's cgroup namespace;
> 
>   - cgroup_get_from_path(): resolves the path against
>     current_cgns_cgroup_dfl(), i.e. relative to the caller's cgroup
>     namespace.

Today I learned cgroup_get_from_path() :)

And it seems it will work for not only memcg but any cgroups?

> 
> So in a cgroup-namespaced (container) setup the two disagree: today
> the lookup is absolute; switching to cgroup_get_from_path() would make
> it namespace-relative.  On the host / init namespace they agree.

If my above guess is correct, it may also differently work if the user gives
non-memcg cgroup path.

> 
> I ask because the iteration has already needed one stable fix
> (d4e7b5c4cc35, a missing mem_cgroup_iter_break() that leaked a cgroup
> reference), and cgroup_get_from_path() is a matched get/put pair that
> would avoid that whole class of mistake -- but only if the namespace
> behavior change is acceptable.
> 
> Is the absolute-path behavior intentional?  If namespace-relative
> resolution is fine, I'm happy to send a patch (keeping the
> mem_cgroup_online() skip).  If not, I'll leave it as is.

It was not very intentional.  I just didn't think about container-inside DAMON
use case.

I find the current behavior might be tedious if the user runs DAMON inside
cgroups.  Finding the absolute cgroup path inside containers might be
challenging.  If that's the case, I'm up to change or extend the behaviors.

If this is only for making the code easier to maintain, I don't really feel
like it deserves the behavioral changes, to be honest.


Thanks,
SJ

[...]
