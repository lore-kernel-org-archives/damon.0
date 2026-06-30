Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5B3F2115
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825374; cv=none; b=ClTSuEG1UdQHQMLEch41NZgPMlVlnUGKX8NsUNT+Wkn3ARFaZVsiIjk8GTSuvLinp7FK2xFj2SJKaSzUdP2lGldPwj8fc8bZRreyX2T9r0mLe0e8RV0ZdJTmFJ/2eLTYkBjf2hxSdbJYNBcVW9yYVWLUnCHUTEKeaDO9MOAr114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825374; c=relaxed/simple;
	bh=lTSMJfgN3nje/RLNQSXskY9bHa55+xIn6bevrzAzrPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NdRjiAxGLnPFuQscmsjUe/aGrQSFJcDw2hM4aDziv4WIh+029vNfrOPzHtB4GpThIhlRFHad0cXnOeyzgVTnp3cx5aWoI4tqc9VErwLOjlzhj0nuP6VCu6J67uL1HmSWrI13Ka/Q1SPlV8m98no88cThBQLsbB3ny1BB5TLk/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0lbYujb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0lbYujb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BDE1F00A3A;
	Tue, 30 Jun 2026 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825372;
	bh=I9Y+24OdldmUXFiBjopDTPyEx6Qwb3Qp7+kn83qmYbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R0lbYujb5upg5hU35Dha0lAb8uj5T0n+R7Kx5jZxJBYrvRZb/Qz5fgYLXHNPq4SIz
	 icZe++WqtOWNdV80RjikJoKyylAMgprqKFNTyNkjU03EU7O9QlcaNVYamCbVCW7fs1
	 +ERZ13TzP/t3Gl8FejJmUUYRof1lqCf29AkmghlSQ4Y70DPagSWfDiDazPf7p+hlSg
	 fgK5HGJ/v38sVSIks3tbhV20e4ZLGF0sk3NsSTP8DLFcZzcSJWAwdzMb0EAKSMwTCy
	 VTdfa1p3ceAAKfiP+m02CChhMTAXAKB1WOyP5icC3nkYkU+U2Iil4lVyA2RtFhPNbQ
	 BhnTReb0uynJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: remove redundant RCU lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Putko" <igorpetindev@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630130158.3826-1-igorpetindev@gmail.com>
References: <20260629165349.4260-1-igorpetindev@gmail.com>
 <20260630130158.3826-1-igorpetindev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:16:12 +0000
Message-Id: <20260630131612.76BDE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Removing `rcu_read_lock()` breaks the KUnit test `damon_test_thr=
ee_regions_in_vmas()`, causing a lockdep splat.

Pre-existing issues:
- [High] VMA iteration on an external mm_struct is performed without checki=
ng for address space stability.
--

commit d9d9a562dbd8520f8d06d146def9565fda08562d
Author: IgorpetinDev <igorpetindev@gmail.com>

mm/damon/vaddr: remove redundant RCU lock

This commit removes the rcu_read_lock() and rcu_read_unlock() calls from
__damon_va_three_regions(). The commit message states that since
mmap_read_lock() is already held by the caller, the maple tree and VMA list
are protected from concurrent changes, making the RCU locks redundant.

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
Will removing this rcu_read_lock() cause a lockdep splat in the KUnit tests?

Looking at damon_test_three_regions_in_vmas() in mm/damon/tests/vaddr-kunit=
.h,
it calls __damon_va_three_regions() directly on a mocked maple tree:

	__damon_va_three_regions(&mm, regions);

Because this KUnit test doesn't hold mmap_read_lock() or configure an exter=
nal
tree lock, removing the localized rcu_read_lock() here will cause for_each_=
vma()
to trigger RCU lockdep assertions for suspicious RCU usage.

[Severity: High]
This isn't a bug introduced by this patch, but does this function safely it=
erate
over an external mm_struct?

Looking at the caller damon_va_three_regions() in mm/damon/vaddr.c, it acqu=
ires
mmap_read_lock() on an external mm, but check_stable_address_space(mm) is n=
ever
called before iterating the VMAs.

If the target process fails dup_mmap() during fork or is processed by the O=
OM
reaper, its mm is flagged MMF_UNSTABLE and the maple tree slots may contain
XA_ZERO_ENTRY markers. Iterating over these markers without checking address
space stability can cause the iterator to return invalid VMA pointers, which
will cause a panic when dereferenced.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630130158.3826=
-1-igorpetindev@gmail.com?part=3D1
