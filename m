Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7525CC57
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413923; cv=none; b=VYuIyQ+7QyBIxNKCVwCBe0Z1E132KXpqFecBHX8nqiPBH+zOCnnjIGR5XgdL3MD7LQkMAockptXmMLfXiwBnkVPBciE6a+g9CTgbTiYxpAoubcpO8QWnkI4Qx3JfSWE5AODk2V/oNBMx9ukrFmwoN5ATGWl+RZ0/UUrzPF3t06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413923; c=relaxed/simple;
	bh=wNseQiM9tlvbOQroy+x7VKbdHCx/NBNJrN6id1N5xtw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i0r1bDUOer0qlcZg6lukVbyaCFpLdjfLGuWKzO7pljoxFm+a+FzynT2YjA+GnYk8QkLuI3zxnkVSPzdR7TX16AIOq4lp0u87rcp62QAHmMk/3ytaR353IbTagK0twXDgIvx6TUmjbdMNWQyVTwFY0ZLOltKJ0m+4F4+OiuyiRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHrE7Dj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHrE7Dj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EDF1F000E9;
	Tue,  7 Jul 2026 08:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783413918;
	bh=6D4ptioeZhqTgHWC58mswR/lZDNnNC0F/DK7wnMzv9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QHrE7Dj794KnMruHT/bcvtu8ximjwFH3FrmZnJx86UHoHjrgYL+gzwCgFPiGB3qeZ
	 menh6e5yo9vzPwdv/XyZT0bTy04z3X7DErjB3XahOK0yn3PZTHF6h3qE27eCdbwQM2
	 QyPOTh7er1Vy9AFJRiUDcm3/tBWSAnU/qTe6l8tDSVied2AfUmVixEcPWEIUwqqMok
	 GtGazoFJBNoJX5tDMPmBdvQUkihd1x9uqPOBs6+WAcD/MyLKrNSW1zXLVQbqpSjp7l
	 hKcecS7B7Kv+a9piNJUa4iqX6I6lKHlnuLv4/bkDAqT9wRUgb/Ug+WKWdm4sLVV+OQ
	 1APrW2dPvjVyA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/13] mm: handle rmap_base changes for
 ANON_VMA_FRACTAL
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707063308.29176-8-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <20260707063308.29176-8-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:45:17 +0000
Message-Id: <20260707084518.72EDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Self-deadlock in VMA modification paths due to recursive acquisiti=
on of the anon_vma rw_semaphore, followed by unbalanced unlock leading to s=
emaphore corruption.
--

--- Patch [7]: [RFC PATCH v2 07/13] mm: handle rmap_base changes for ANON_V=
MA_FRACTAL ---
commit 4ece2a0d48ed77392c6b5765afc8e465e5eeb821
Author: tao <tao.wangtao@honor.com>

mm: handle rmap_base changes for ANON_VMA_FRACTAL

This patch introduces vma_pre_update_rmap_base() and
vma_post_update_rmap_base() to track rmap_base changes during VMA merges
and shrinks. It calls these helpers before vma_prepare() and after
vma_complete() in paths where the rmap_base may change.

> diff --git a/mm/vma.c b/mm/vma.c
> index 9eea2850818a8..d2996369e30d6 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
[ ... ]
> @@ -748,12 +749,16 @@ static int commit_merge(struct vma_merge_struct *vm=
g)
>  	/*
>  	 * If vmg->give_up_on_oom is set, we're safe, because we don't actually
>  	 * manipulate any VMAs until we succeed at preallocation.
>  	 */
>  	if (vma_iter_prealloc(vmg->vmi, vma))
>  		return -ENOMEM;
> =20
> +	rbase_diff =3D rmap_base(vmg->start, vmg->pgoff) - vma_rmap_base(vma);
> +	if (rbase_diff && vma_pre_update_rmap_base(vma, rbase_diff)) {
> +		vma_iter_free(vmg->vmi);
> +		return -ENOMEM;
> +	}
> +
>  	vma_prepare(&vp);

[Severity: High]
Will this sequence cause a self-deadlock on the anon_vma rw_semaphore?

Looking at vma_pre_update_rmap_base(), it acquires the write lock on the
semaphore via down_write(anon_node_rmap_sem(anon_nod)).=20

Immediately after that, vma_prepare() is called here. Since vma_prepare()
unconditionally calls anon_vma_lock_write() which attempts to acquire the
exact same rw_semaphore, won't the second down_write() block indefinitely
because Linux rw_semaphores are not recursive for writers?

The exact same pattern is also present in vma_shrink().

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 900a9d9e5e6a3..2a31f0441c114 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
[ ... ]
> +void vma_post_update_rmap_base(struct vm_area_struct *vma, unsigned long=
 diff)
> +{
> +	struct anon_node *anon_nod =3D vma_anon_node(vma);
> +	struct rw_semaphore *rmap_sem;
> +	struct anon_node *release_node =3D NULL;
> +
> +	vma_assert_write_locked(vma);
> +	if (!anon_nod || !diff)
> +		return;
> +
> +	rmap_sem =3D anon_node_rmap_sem(anon_nod);
> +	rwsem_assert_held_write(rmap_sem);
> +	anon_node_untrack_rmap_locked(anon_nod, vma,
> +		vma_rmap_base(vma) - diff, &release_node);
> +	up_write(rmap_sem);

[Severity: High]
Does this up_write() corrupt the semaphore state?

This function is called in commit_merge() and vma_shrink() right after
vma_complete(). Because vma_complete() releases the locks previously
acquired by vma_prepare(), the rw_semaphore has already been unlocked by the
time we reach this code.

Will calling up_write() on an already-unlocked semaphore cause kernel
instability or further lock corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707063308.2917=
6-1-tao.wangtao@honor.com?part=3D7
