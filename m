Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E217335BA
	for <damon@lists.linux.dev>; Thu, 23 Apr 2026 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776904913; cv=none; b=EqIL/C9O6twMHw7ElahbEheb/mkRojAgnUXlVtjI8+z7wov1aGI6iKhFaX7lA0ujpgegSdgvpT4xXqcjOUiwjPeXkPltLg2EVG6tQhzr5im7orJKtyV7lqItL9dvNVAYLOV7VByHVJVpgQvHFcYCFkUXrXMBM8dogT6cLeWnbQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776904913; c=relaxed/simple;
	bh=Cr0zgqEE3dvJ2Dgn4X1h+mdXhaqvyV7JqlmP6a5HcO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/+1AqZQDiBlrkMusqTVTyEGkEucGOJw/+j+sF7beFM5u3gGvYiL8K8Q7smrDrt7CFTDXWaGqOPGNJbUqTaop1musXp+3p8bDtaXqwB47v/plrj+IuuXzFi5s1wh4VmiIBF2K6IO5+jfCmBAy10PuPcmhuI9N40WAE89P6td9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQniFBAY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQniFBAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5906C19425;
	Thu, 23 Apr 2026 00:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776904913;
	bh=Cr0zgqEE3dvJ2Dgn4X1h+mdXhaqvyV7JqlmP6a5HcO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQniFBAYyE2jkGdQUcRUTsT6oYKBbJniu2pL2d+Nr2OGzDhpPaxGzg1XYvWjiO7RB
	 mNLxWoeae/kJ3xFefde8UWBv1KXZLke1GzdbnAsTCyT26BTaWPQXkgEx9ScVk9fHAp
	 VHifopNMZhylyJGMPgJ3cOUXWh6m5MeDj0HxcebIeWkk1NTxekF0SxrrRayWe7sI5R
	 BngGEMlX7stkjh/AzNddPQdNGy2qaT8sBVyHYP/kwsxNfYzpSp4Cx7HLqybTkBpTNo
	 pBBnyZFVcK/s1ZJfL+Y16DmOut2wlDjdPelbwPFPu/oyOhB/OgxoWe0ylO8/CUSj83
	 OkOfQdEQSAt4A==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/2] mm/damon/sysfs-schemes: protect memcg_path kfree() with damon_sysfs_lock
Date: Wed, 22 Apr 2026 17:41:47 -0700
Message-ID: <20260423004148.74722-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422203017.48F3EC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 22 Apr 2026 20:30:16 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [High] Breaking from `mem_cgroup_iter()` without calling `mem_cgroup_iter_break()` leaks a cgroup reference in `damon_sysfs_memcg_path_to_id()`.

Nice finding, but not this patch's fault.  I will separately work on this.

> --
> 
> commit f19bff910905231adad168cfffc97ed67cb1fde3
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: protect memcg_path kfree() with damon_sysfs_lock
> 
> This commit fixes a use-after-free vulnerability by using damon_sysfs_lock
> to protect concurrent user-direct reads and writes to the memcg_path sysfs
> file. The locking prevents readers from accessing the memory path buffer
> while it is being deallocated by a write operation.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 5186966dafb35..8d32a20531d49 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> 
> [ ... ]
> 
> > @@ -550,8 +555,13 @@ static ssize_t memcg_path_store(struct kobject *kobj,
> >  		return -ENOMEM;
> >  
> >  	strscpy(path, buf, count + 1);
> > +	if (!mutex_trylock(&damon_sysfs_lock)) {
> > +		kfree(path);
> > +		return -EBUSY;
> > +	}
> >  	kfree(filter->memcg_path);
> >  	filter->memcg_path = path;
> > +	mutex_unlock(&damon_sysfs_lock);
> >  	return count;
> >  }
> 
> This isn't a bug introduced by this patch, but I noticed a pre-existing
> issue in this file.
> 
> Does damon_sysfs_memcg_path_to_id() leak a cgroup reference when breaking
> early from the hierarchy walk?
> 
> mm/damon/sysfs-schemes.c:damon_sysfs_memcg_path_to_id() {
> 	...
> 	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
> 			memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
> 		/* skip offlined memcg */
> 		if (!mem_cgroup_online(memcg))
> 			continue;
> 		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
> 			*id = mem_cgroup_id(memcg);
> 			found = true;
> 			break;
> 		}
> 	}
> 	...
> }
> 
> According to the API contract, if a hierarchy walk is aborted prematurely
> before a round-trip is complete, the caller must use
> mem_cgroup_iter_break(NULL, memcg) to drop the reference to the last visited
> cgroup.
> 
> Because this is missing, could every successful resolution of a memcg path
> permanently leak a css reference?
> 
> In environments where DAMON configurations are frequently updated (like
> dynamically profiling containers), this could lead to a buildup of "zombie"
> cgroups that cannot be destroyed, eventually pinning substantial kernel
> memory and causing system-wide memory exhaustion.

Nice finding.  As Sashiko also mentions, not this patch's fault, though.  I
will separately work on this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260422143503.71357-1-sj@kernel.org?part=1
> 


Thanks,
SJ
