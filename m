Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5E637C92C
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793336; cv=none; b=qU/arapr263T+eYJIBksjF7YauWHFSA++LJSV5Y22gDkmNu9SOzi5NOE/uwjaqIWVPTjGsowT4+YPYgHN8uRqKYMblmAbHqbrO6HnNJz18ykGGqarH8eJzDnN2xozrd0tp5bkTcER5GLpr9nRmCEtIh2RW+7mGD7HuBJ5IdKO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793336; c=relaxed/simple;
	bh=SKE8OP9nX0gA04ZmYwlfWboUvAWxG/PXNE/zmGq1CeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OPp/AeMO0QPzfAUmhITLUAn9QAY4cjXgOYI2DRUVmAaoZMmd8S+SU487VAJqmqS+9dMNi5W+DaxbmAhwxPjeW65kc1H9etaykYEjOtDApzQQMpQ3GER30mPCJYrL6Bct2itg6EgXaZAG+iGqTG/N9NTVOx2upWntCp7heBV7VVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7CCWNA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7CCWNA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C3A1F000E9;
	Tue, 30 Jun 2026 04:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793334;
	bh=lh6372vFgxu7VIvGcmVrx6dwPAuYXoglqzSmxp3WgiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7CCWNA0vKMU4vcgnKVU4Wgj/OrhS5HgEgUcEqPaNFidGlykbUNREX2h6LlkkfA2q
	 tTOOe4WutIE6M1Fb+lSTfKEik94M+LLz4IoscTERvpbbIp4+Q3qX82QTy4CYQdYKA0
	 1+2x4dOYoMQ80Z2dfzHX8Bbheke59IfMA/bTg7y+IpozCcQn7AHvZYaFbqKLhgWyr6
	 rI+wzxk8OwbphkfbQz/ZvLEjIEJTCeWQxnAbFYW4imV6KEfpsOqtc5tuib6VjcCyCk
	 ya+jjTaay+sWH1eGRphFzY5ceNzXRfRYup5TMkpR7GkTDsnSSGCUIn1NZZiEtbQ941
	 8rvaKqKeS7V8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/18] mm/damon/vaddr: remove attrs param from
 __damon_va_check_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630040812.149729-17-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
 <20260630040812.149729-17-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 04:22:14 +0000
Message-Id: <20260630042214.A6C3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Thread-unsafe static state in access check functions leads to memo=
ry access rate corruption across processes.
- [High] Incorrect PTE advancement for large folios in DAMON operations cau=
ses skipped memory.
--

commit 126a430836c56a402d2fefdf82a9e58aed70a6d7
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr: remove attrs param from __damon_va_check_access()

The function is not using attrs parameter. Remove it.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 2eaced0765e26..2058db9c01d52 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -493,8 +493,7 @@ static bool damon_va_young(struct mm_struct *mm, unsi=
gned long addr,
>   * r	the region to be checked
>   */
>  static void __damon_va_check_access(struct mm_struct *mm,
> -				struct damon_region *r, bool same_target,
> -				struct damon_attrs *attrs)
> +				struct damon_region *r, bool same_target)
>  {
>  	static unsigned long last_addr;
>  	static unsigned long last_folio_sz =3D PAGE_SIZE;
>  	static bool last_accessed;

[Severity: High]
This isn't a bug introduced by this patch, but does using static variables
here cause a cross-thread data race?

If multiple DAMON contexts (running in separate kdamond threads) monitor
virtual addresses simultaneously, a thread processing one process's virtual
address might read values just written by another thread.

Could this lead to incorrect reuse of the last_accessed result and corrupt
access rate statistics across different processes? A similar pattern appears
to exist in mm/damon/paddr.c:__damon_pa_check_access() as well.

[ ... ]

Additionally, while reviewing this file, I noticed another pre-existing
issue in damos_va_stat_pmd_entry() and damos_va_migrate_pmd_entry():

mm/damon/vaddr.c:damos_va_stat_pmd_entry() {
        ...
        nr =3D folio_nr_pages(folio);
        s->last_applied =3D folio;
        ...
}

[Severity: High]
This is a pre-existing issue, but does advancing the PTE by
folio_nr_pages() overshoot the loop bounds when the start address falls
in the middle of a large folio?

Because the address is not necessarily aligned to the start of the large
folio, advancing by the entire folio size might overshoot the end of the
folio and inadvertently skip subsequent PTEs that belong to unrelated
memory. Should the advancement step account for the subpage offset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630040812.1497=
29-1-sj@kernel.org?part=3D16
