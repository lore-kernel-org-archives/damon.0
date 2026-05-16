Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D361F30A4
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778968505; cv=none; b=JAWwIeYZ+oVhDftUCqPFZvJrWjkPbTJ3Hgh41DmRMg2rUkVCTHtvDfd9fRX68Kge7OES8C7995H1U5TdLnqMcKgpx1wFFumd5ENKLbTo17VoV0zvmJplBHAnKlGF17WANnT5rpMlk3RWZl31gk3/odsrQc8zveXZFDecXdW/Tkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778968505; c=relaxed/simple;
	bh=cOVaGgFyESaohw5r3oMbDRaLCKQsMFA+6tcvy/zDbuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekFKMYW95JUKzT8FWAUcpHSibKsI//GmeRZS4c1mxfdULXQxFQmP0rmBbPGLUdQ1gzmv6iIBVru+AU4t4Er3XPx+PTsptZ7voFk4Hmn1VNPxtn7RhYYy4bubI84NPaii1CLsYioJZZlDFBXfxiXW0jsERkXA9mNUoPfK+x9p8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRId6mB2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRId6mB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6522FC19425;
	Sat, 16 May 2026 21:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778968505;
	bh=cOVaGgFyESaohw5r3oMbDRaLCKQsMFA+6tcvy/zDbuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRId6mB2bF8mHxRcjPprc+7D8fTbThsvBEJ+ug/seOF7His4EZYDigxVFv7QrU+/C
	 xcS8AOKC9Vs9K/aZBBmTHdf0/lzj43EBxlvUphrnTEzSm5moHf3Zt98pC5BwLZhnTa
	 0aJtgEZbp4bercTZEOYODIK5VPNutLT1JnCvJ60U3lVrCRyj8D/v8YIv/8kfFfCXKk
	 IF8+KJNZbM296oIEUx9g4zWVHE/CH2vNOTP6gMeUv7n1hoEV89cC4/+5XoHXfMq1hO
	 JLsOSV15DzgC7h2dDxAbUIDC9mHizO177htp0FRme1gebBt5zF4zExwDMqYWK65ZaH
	 GOpSmi4M3KyAw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 25/28] mm/damon/sysfs-schemes: move memcg_path_to_id() to sysfs-common
Date: Sat, 16 May 2026 14:54:50 -0700
Message-ID: <20260516215452.3500-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516191605.83FEAC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 19:16:05 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit silently fixes a memcg reference leak by adding a call to `mem_cgroup_iter_break()` without documenting it in the commit message.
> --
> 
> commit 1ef74f20c7bcc208023c4d45c1ced02bf234a75c
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: move memcg_path_to_id() to sysfs-common
> 
> This commit moves the static function damon_sysfs_memcg_path_to_id()
> from sysfs-schemes.c to sysfs-common.c and makes it non-static so it can
> be reused in subsequent commits.
> 
> > The next commit will need to find the memcg id from the user-passed path
> > to the memory cgroup, from sysfs.c.  memcg_path_to_id() is doing that,
> > but defined in sysfs-schemes.c as a static function.  Move the function
> > to sysfs-common.c and mark it as non-static, so that the next commit can
> > reuse the function.
> 
> The commit message states that the patch only moves the function and changes
> its linkage. However, a functional change was included in the moved code.
> 
> [ ... ]
> > diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
> > index 83e24a9b5a0db..bdc6ae2639e4f 100644
> > --- a/mm/damon/sysfs-common.c
> > +++ b/mm/damon/sysfs-common.c
> [ ... ]
> > @@ -104,3 +104,44 @@ const struct kobj_type damon_sysfs_ul_range_ktype = {
> >  	.default_groups = damon_sysfs_ul_range_groups,
> >  };
> >  
> > +
> > +static bool damon_sysfs_memcg_path_eq(struct mem_cgroup *memcg,
> > +		char *memcg_path_buf, char *path)
> > +{
> > +#ifdef CONFIG_MEMCG
> > +	cgroup_path(memcg->css.cgroup, memcg_path_buf, PATH_MAX);
> > +	if (sysfs_streq(memcg_path_buf, path))
> > +		return true;
> > +#endif /* CONFIG_MEMCG */
> > +	return false;
> > +}
> > +
> > +int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id)
> > +{
> > +	struct mem_cgroup *memcg;
> > +	char *path;
> > +	bool found = false;
> > +
> > +	if (!memcg_path)
> > +		return -EINVAL;
> > +
> > +	path = kmalloc_array(PATH_MAX, sizeof(*path), GFP_KERNEL);
> > +	if (!path)
> > +		return -ENOMEM;
> > +
> > +	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
> > +			memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
> > +		/* skip offlined memcg */
> > +		if (!mem_cgroup_online(memcg))
> > +			continue;
> > +		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
> > +			*id = mem_cgroup_id(memcg);
> > +			found = true;
> > +			mem_cgroup_iter_break(NULL, memcg);
> 
> Is it intentional to include this memcg reference leak fix here?
> 
> It looks like the original code was missing this call to
> mem_cgroup_iter_break() before breaking out of the loop.
> 
> Should this bug fix be split into a separate patch, or documented in the
> commit message so that stable maintainers can backport it if necessary?

Intentional thing, that made to ensure Sashiko can [1] review this.  The final
version of this patch will not have that.

> 
> > +			break;
> > +		}
> > +	}
> > +
> > +	kfree(path);
> > +	return found ? 0 : -EINVAL;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260516183712.81393-1-sj@kernel.org?part=25

[1] https://lore.kernel.org/20260516015001.147547-1-sj@kernel.org


Thanks,
SJ
