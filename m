Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5F3CC7CE
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825374; cv=none; b=FderEl/kQ3r99uJy/EQoPpDmgMcuwueDMMhmjWfzl0RE3AlKfNiS4R6mqIdzIc+MkOzRd/tetNZoMRYDjpk7FLEtfVLHYoUJBy/WNdlkVh1dgf+1KOZaUSWgUFDjO/sPJRise02eTABfbqvlmy2frbVIsClLN/yUkuTHqPJA7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825374; c=relaxed/simple;
	bh=Wiqxk1fKCVXyj/QoBDnxUGz0ksdtwjNO9qZWWw9hR6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qclwg9sPJ4pzzdmbtQy62bU0kTO+HjV6B4j6toXWdRGrviOafAObMNbK7/FiVwqE1bk2u7F8Be92k9ontmA76igiHjQI9wG0vTBPaUZvrbs5NvNGuNNLcpYbg4klRXmukcw3pD0rjlQD6oDmfmdFBvDiw/4XYO4Jz2avzi/1gxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0B2UZeH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0B2UZeH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D9C1F000E9;
	Tue, 30 Jun 2026 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825372;
	bh=G9WbLYJTXrd0G1to45/qO2xuOe+Esjs0aDTrBCUYdC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B0B2UZeHx3jAKmQYm7pkRbvMVEM7RwhHDlEOwWddj1/V0Jy0SIZQrdsAP1wV57v7V
	 VxrwWrJ0QKuKKrGglur1xYgZvVXpUjlbUJ6UgamFRpDriO4fCmGfc20huPpUUKgYrl
	 LmLe/Q+S53TDcMjloyVvzpcR1nCuAZeYqdVSIU2MC/x7cmuLwGQeFAd9Cbv+my8zCx
	 cvNtroNvibexSICu+9jh0p07SiZKvWgBtv+zTYfVc5Amp5ing/IEH1LHwquEX4aAxz
	 9n1utjOYmcJjuo64cxhh/PdteQ0riyfBNrcSsYd1g1OjitVL8nu/tRDpSKJOVY9XGn
	 fFzBB6lU7vNsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/vaddr: remove redundant RCU lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Putko" <igorpetindev@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630130253.3843-1-igorpetindev@gmail.com>
References: <20260629165349.4260-1-igorpetindev@gmail.com>
 <20260630130253.3843-1-igorpetindev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:16:09 +0000
Message-Id: <20260630131611.D6D9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] VMA iteration on an external mm_struct is performed without checki=
ng check_stable_address_space(mm), which can lead to iterating a corrupted =
maple tree.
--

commit fdc4435ee0611e8373511ef284a90ecc98420eec
Author: Igor Putko <igorpetindev@gmail.com>

mm/damon/vaddr: remove redundant RCU lock

This commit removes rcu_read_lock() and rcu_read_unlock() from
__damon_va_three_regions() and adds them to its kunit test. It asserts that
mmap_read_lock() is sufficient to protect the maple tree during VMA iterati=
on.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index e73ec1ce016e5..882cc7cb09027 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c

[ ... ]

> @@ -82,7 +82,6 @@ static int __damon_va_three_regions(struct mm_struct *m=
m,
>  	 * If this is too slow, it can be optimised to examine the maple
>  	 * tree gaps.
>  	 */
> -	rcu_read_lock();
>  	for_each_vma(vmi, vma) {

[Severity: High]
This is a pre-existing issue, but while reviewing the VMA traversal here,
I noticed a potential problem with how the mmap_read_lock is used by the
callers of this function.

When traversing VMAs on an external mm_struct, does this code need to check
check_stable_address_space(mm) before iterating?=20

Looking at damon_va_three_regions() and damon_va_walk_page_range(), they
acquire mmap_read_lock(mm) and proceed directly to VMA traversal:

mm/damon/vaddr.c:damon_va_three_regions() {
	...
	mmap_read_lock(mm);
	rc =3D __damon_va_three_regions(mm, regions);
	mmap_read_unlock(mm);
	...
}

If the OOM reaper runs on the target process, it can mark the mm as unstable
and leave XA_ZERO_ENTRY markers in the maple tree. Iterating this corrupted
tree without first verifying check_stable_address_space(mm) can lead to
kernel crashes.

Could this be triggered under system memory pressure while DAMON is
monitoring?

>  		unsigned long gap;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630130253.3843=
-1-igorpetindev@gmail.com?part=3D1
