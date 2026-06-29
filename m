Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0EC40D59F
	for <damon@lists.linux.dev>; Mon, 29 Jun 2026 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752789; cv=none; b=kmKYJBcaMA4bdGbHUEkkdywMScf2OognTfZB8X+e0HzTcbJkbnMUmL4jtu9MJxyLcM+inJBHDFUyKrQLAqqJ47fptG+3VoG7BoGsd/1Nm1FIZEMJMLrrd83HS/H29d8j5qRAqkI8q19KAYqVnkr5zAkPWO6yIABuidBH0WyHbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752789; c=relaxed/simple;
	bh=ton+P15C+ajTWOJU2DX+Bli767W2yeJE9Lv8cPGKqZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W5c2y/b0pCnvTudNxFeYBSLxxoh63u5a97k0IA7nhrgMs2/bXwCbmB2OWVQedqYvkSfaMJ02qKcdyJXyfvg4cdPAr6WjlNSkMe9dz/1IOXkKxJWL4Lkt2RJI6mi6blufnwYnJ2wMqwMYwxfPwKsBAVNgq4yq2VF4Vwscn54lfc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK2mA5l2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK2mA5l2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06481F000E9;
	Mon, 29 Jun 2026 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782752787;
	bh=1spwD84lpG0O8Fa0LK6GLQgVFO1af2DylfjfCUZzCqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VK2mA5l2E5zBHeTjYwEVBfOXDvIZgXMDsDtdn2Aq1VcgVJnIkccgLKN60AHW5z/+n
	 uHArf4qJbRv0wWOKbLw97LjmEXjiQRSdQGi7D3G0N9IFyhUj8SbuAh5yK5x1PusXxH
	 zAslRkA6vAa8qNli6YZ0ixVOx4pd/mcsT6OrEwsr1iLlTMPViD035anIJMSm/vaF01
	 0NR6myznre7mvujUk7TIV7Y9t/7iLUZXa+TpJTsg12k5TH/KyyL4SOFS+3fLnVhu5X
	 TmqZr8E/BNJY3ijNpQzArHCmV2RLo3eiRqr6zW63QRypDOl2EyYJ1tYLffyfgTgT74
	 wWvjdCnsXEJ/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: remove redundant RCU lock
Reply-To: sashiko-reviews@lists.linux.dev
To: IgorpetinDev <igorpetindev@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260629165349.4260-1-igorpetindev@gmail.com>
References: <20260629165349.4260-1-igorpetindev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 17:06:27 +0000
Message-Id: <20260629170627.B06481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The removal of `rcu_read_lock()` breaks the KUnit test `damon_te=
st_three_regions_in_vmas()`, causing a lockdep splat.

Pre-existing issues:
- [High] VMA tree iteration on an external mm_struct is performed without c=
hecking if the address space is stable, risking a crash on unstable MMs.
--

commit e3efcd87bda8a6d5dd6bcc064e6f5876f9980a31
Author: IgorpetinDev <igorpetindev@gmail.com>

mm/damon/vaddr: remove redundant RCU lock

This patch removes the rcu_read_lock() and rcu_read_unlock() calls from
__damon_va_three_regions(), assuming that the mmap_read_lock is always
held by the caller.

> __damon_va_three_regions() is called only by damon_va_three_regions(),
> which already holds mmap_read_lock(). Since mmap_read_lock() is held,

[Severity: High]
This is a pre-existing issue, but when damon_va_three_regions() acquires the
mmap_read_lock on an external task's mm_struct, is it safe to begin
traversing the VMA tree without first verifying address space stability?

If the target process is concurrently undergoing an OOM kill or failed a
dup_mmap(), the mm_struct could be flagged MMF_UNSTABLE and the maple tree
could contain XA_ZERO_ENTRY markers. Should damon_va_three_regions() call
check_stable_address_space() before __damon_va_three_regions() traverses
the tree, to prevent a potential kernel panic from dereferencing invalid
markers?

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index e73ec1ce016e5..882cc7cb09027 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -82,7 +82,6 @@ static int __damon_va_three_regions(struct mm_struct *m=
m,
>  	 * If this is too slow, it can be optimised to examine the maple
>  	 * tree gaps.
>  	 */
> -	rcu_read_lock();
>  	for_each_vma(vmi, vma) {

[Severity: Medium]
Will the removal of this lock break the KUnit test
damon_test_three_regions_in_vmas() located in mm/damon/tests/vaddr-kunit.h?

The test framework calls __damon_va_three_regions() directly using a dummy
mm_struct and a maple tree initialized without the MT_FLAGS_LOCK_EXTERN fla=
g.
Since the test environment doesn't hold the internal maple tree lock or an
external mmap_lock, won't removing this rcu_read_lock() cause a lockdep
warning (suspicious rcu_dereference_check usage) when for_each_vma()
attempts to traverse the tree?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629165349.4260=
-1-igorpetindev@gmail.com?part=3D1
