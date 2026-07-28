Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211FF472789
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268776; cv=none; b=EEe1b69lDjrI0otyTYcJpEK6+86HXDn4ncdCLCtvZ4m25VioXaCtRtdSN0EeW1E1IHQMvojRJ0gf80vS+Qle5sP8nKInJTef0uh9vAVYAkq+eawpp2vxxouBKPsnO0IkDh5Dsj/IPG2dY1OjUxuVbiv0uTyMEMItTMF682wXAVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268776; c=relaxed/simple;
	bh=oQbuKLdyZPMNKvDIQL5d47ec2a3yGAwGLRHTUgWGDsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ct/lsrDh2pncsNyZGUmF4voKoUpZ4NpQcN1m9ryzR3f4OrJlV8w+NVOvZCMVCxYjJIwuEyQcI/BbzVT+eqpjcH2Bz5YMwpy/psR7pCGjqMPxJI/pIa6s0xag8kaX8c+Ym33ErYWH3eZmhzKNmi9F3U7zYKjpX/Hed10tudx2PvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axM9+xj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axM9+xj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61511F000E9;
	Tue, 28 Jul 2026 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785268774;
	bh=wOF5aTu8HYcuEbsE+9z8mQIfwunq0bjoKn0gi7juhoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=axM9+xj7eiARdsQ4O/MFZx96SrFy4NoVMJgKddMuiIj/JQEEFZd530ElmRDbhRKun
	 ALLH2RWOYuE6PaamhnGyjrV+GkuBQwKZs0K5mBT1YLXnS6945ZSSRe2Q9sJ/rbYjSB
	 NreLkfNHxBWr2YlEobKA0hLNOaz7fPOlnDPTliJTb6piM+u3yQ4OUVTL/BXVpVsMPV
	 ejF7AKBbksr1YmIU28u+Ok8f+p6tF7411LdVBrEzrfzXCFZYKSwUSTTX/dGHQfMb4B
	 6zd2FOpEsB5aw6mpHL8uDrAZ50pvRC1hiKmwqE6vS35MkaazUYuGTBby+oCO5qk1+F
	 OewODgBkZtRDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] mm/mempolicy: skip zone device folios when queueing
 folios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728194714.3713735-5-gourry@gourry.net>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-5-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 19:59:34 +0000
Message-Id: <20260728195934.A61511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] queue_folios_pmd() blindly calls pmd_folio() on raw PFN PMDs, caus=
ing a kernel panic during mbind(MPOL_MF_STRICT) on VM_PFNMAP mappings.
--

--- Patch [4]: [PATCH 4/4] mm/mempolicy: skip zone device folios when queue=
ing folios ---
commit 638b94b8502c12252205f411cec0cf58a9fd9ce2
Author: Gregory Price <gourry@gourry.net>

mm/mempolicy: skip zone device folios when queueing folios

This commit adds explicit zone device checks to queue_folios_pmd() and
queue_folios_hugetlb() to mirror the behavior in queue_folios_pte_range().

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 5720f7f54d942..bd79e61a40d1a 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -668,6 +668,8 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_wa=
lk *walk)
>  	}
>  	if (!queue_folio_required(folio, qp))
>  		return;
> +	if (folio_is_zone_device(folio))
> +		return;

[Severity: High]
This is a pre-existing issue, but can this code path trigger a kernel panic
if it encounters a raw PFN PMD from a VM_PFNMAP mapping?

Looking at queue_pages_test_walk() in mm/mempolicy.c, it allows unmigratable
VMAs (like VM_PFNMAP) to be walked if MPOL_MF_STRICT is specified:

	if (!vma_migratable(vma) &&
	    !(flags & MPOL_MF_STRICT))
		return 1;

	if (flags & (MPOL_MF_STRICT | MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
		return 0;

During the walk, queue_folios_pmd() unconditionally calls pmd_folio(pmdval)
on present PMDs. Since VM_PFNMAP raw PFNs lack a valid struct page,
pmd_folio() would return a garbage pointer, leading to a crash when
queue_folio_required() or the newly added folio_is_zone_device() dereferenc=
es
it.

Should queue_folios_pmd() be using vm_normal_folio_pmd() or similar to filt=
er
out raw PFN mappings before attempting to extract the folio?

>  	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
>  	    !vma_migratable(walk->vma) ||
>  	    !migrate_folio_add(folio, qp->pagelist, qp->flags))

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728194714.3713=
735-1-gourry@gourry.net?part=3D4
