Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF57B
	for <damon@lists.linux.dev>; Thu, 18 Aug 2022 02:42:02 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1660790520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdJ+Vr7hPHtj5OVHgPI42sVqcU6ySHTrxw+o43yK3qc=;
	b=YFhYP03xMRd4qrEdF/hwyTE3DQlMeh266DP4j6S83vMgNmMNSDkLC8FgjkrjJ/4rTIc+ct
	p+pnfdvAoTQBhMXdCorPGUtgec/BO/47bmASu/JjzPVrVcUnfm4vfCF3Q3SUjAip8CR5uO
	GlafXazSUxdrbLS34UvualWhN/WOAl0=
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/damon: Validate if the pmd entry is present before
 accessing
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2838b6737bc259cf575ff11fd1c4b7fdb340fa73.1660717122.git.baolin.wang@linux.alibaba.com>
Date: Thu, 18 Aug 2022 10:41:10 +0800
Cc: sj@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 damon@lists.linux.dev,
 Linux MM <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org,
 Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5173E308-2403-4667-9162-865CF7F11838@linux.dev>
References: <2838b6737bc259cf575ff11fd1c4b7fdb340fa73.1660717122.git.baolin.wang@linux.alibaba.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev



> On Aug 17, 2022, at 14:21, Baolin Wang <baolin.wang@linux.alibaba.com> =
wrote:
>=20
> The pmd_huge() is used to validate if the pmd entry is mapped by a =
huge
> page, also including the case of non-present (migration or hwpoisoned)
> pmd entry on arm64 or x86 architectures. Thus we should validate if it
> is present before making the pmd entry old or getting young state,
> otherwise we can not get the correct corresponding page.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> mm/damon/vaddr.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 3c7b9d6..1d16c6c 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -304,6 +304,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, =
unsigned long addr,
>=20
> 	if (pmd_huge(*pmd)) {
> 		ptl =3D pmd_lock(walk->mm, pmd);
> +		if (!pmd_present(*pmd)) {

Unluckily, we should use pte_present here. See commit c9d398fa23788. We =
can use
huge_ptep_get() to get a hugetlb pte, so it=E2=80=99s better to put the =
check after
pmd_huge.

Cc Mike to make sure I am not missing something.

Muchun,
Thanks.

> +			spin_unlock(ptl);
> +			return 0;
> +		}
> +
> 		if (pmd_huge(*pmd)) {
> 			damon_pmdp_mkold(pmd, walk->mm, addr);
> 			spin_unlock(ptl);
> @@ -431,6 +436,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, =
unsigned long addr,
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 	if (pmd_huge(*pmd)) {
> 		ptl =3D pmd_lock(walk->mm, pmd);
> +		if (!pmd_present(*pmd)) {
> +			spin_unlock(ptl);
> +			return 0;
> +		}
> +
> 		if (!pmd_huge(*pmd)) {
> 			spin_unlock(ptl);
> 			goto regular_page;
> --=20
> 1.8.3.1
>=20
>=20

