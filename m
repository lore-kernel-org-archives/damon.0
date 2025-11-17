Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773D2773E4;
	Mon, 17 Nov 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394267; cv=none; b=hEmiMcLtPObwsa6LVH8Bx67gNGhW8QN9UL7UlIzi49RqOYZPPnV4VhIac9ITymJe4om644LCSgNWVwiGbRUbu9OyEv3qub69s08KvDq5HTIPlDPC/wV+e7WBjvWvrPGH6ffBKrsgZbcMWNngZIuBzeEXJ/s6Q69tBecsiZON3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394267; c=relaxed/simple;
	bh=zyqbmtL+YeLotbFYG+4uyqKs8X8IO2JthwssMUoxfRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYGze0TlsxHR7Z1Z7pTu7tFCsStlN54NNNvzYECESfnlfT+eVNFVZTUIpyOEWvMMFESmlogr6vMDrxOtjAekZIODS4Ql9kodyHd4MRa1OMey8OffA9ISjgO564c7tp1mtVeF+37/dTb+iU9z4sQthen0wYWez+zmnfr8NbGbk5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0kC8qC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0kC8qC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD04C19421;
	Mon, 17 Nov 2025 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763394266;
	bh=zyqbmtL+YeLotbFYG+4uyqKs8X8IO2JthwssMUoxfRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0kC8qC575+JbYZZeX1l1b++Wl1yn9NtKkKJwPR4cmM0XSPkWGF4wdtHBhjvxc8T2
	 PukIApM/S5PCV8jJAKvJLpEb22en10Vm7vIQhYj//lvGOFlDgvad6uciazjN7+sZOR
	 +7wTCHcuHljOW2+IrUq17SeKwRCA48lO6r4FU9adKWnLg6hBPK/iKMiJzqGuz3x1az
	 EGRkpYvRo1WoqGqBtVK4QI3NduLBdeGWibUx5YJXB9J5sFnIMdDqs8Cqds6H3fDwTO
	 AB5sLiOqpwTm/Q10IHXsYzBNgmC6ZknSr0hOlVYw4iKVHamAOj3JFN4x2OHK1BEU9W
	 DTJm6F9HpIX6w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Hugh Dickins <hughd@google.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/9] mm/damon/vaddr: cleanup using pmd_trans_huge_lock()
Date: Mon, 17 Nov 2025 07:44:14 -0800
Message-ID: <20251117154415.11041-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112154114.66053-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Nov 2025 07:41:06 -0800 SeongJae Park <sj@kernel.org> wrote:

> Three pmd walk functions in vaddr.c are using pmd_trans_huge() and
> pmd_lock() to handle THPs.  Simplify the code by replacing the two
> function calls with a single pmd_trans_huge_lock() call.
> 
> Note that this cleanup is not only reducing the lines of code, but also
> simplifies code execution flows for migration entries case, as kindly
> explained [1] by Hugh, who suggested this cleanup.
> 
> [1] https://lore.kernel.org/296c2b3f-6748-158f-b85d-2952165c0588@google.com
> 
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/vaddr.c | 48 ++++++++++++------------------------------------
>  1 file changed, 12 insertions(+), 36 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 7e834467b2d8..0ad1ce120aa1 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -307,24 +307,14 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		unsigned long next, struct mm_walk *walk)
>  {
>  	pte_t *pte;
> -	pmd_t pmde;
>  	spinlock_t *ptl;
>  
> -	if (pmd_trans_huge(pmdp_get(pmd))) {
> -		ptl = pmd_lock(walk->mm, pmd);
> -		pmde = pmdp_get(pmd);
> -
> -		if (!pmd_present(pmde)) {
> -			spin_unlock(ptl);
> -			return 0;
> -		}
> -
> -		if (pmd_trans_huge(pmde)) {
> +	ptl = pmd_trans_huge_lock(pmd, walk->vma);
> +	if (ptl) {
> +		if (pmd_present(pmdp_get(pmd)))
>  			damon_pmdp_mkold(pmd, walk->vma, addr);
> -			spin_unlock(ptl);
> -			return 0;
> -		}
>  		spin_unlock(ptl);
> +		return 0;
>  	}
>  
>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> @@ -446,21 +436,12 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	struct damon_young_walk_private *priv = walk->private;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (pmd_trans_huge(pmdp_get(pmd))) {
> -		pmd_t pmde;
> -
> -		ptl = pmd_lock(walk->mm, pmd);
> -		pmde = pmdp_get(pmd);
> +	ptl = pmd_trans_huge_lock(pmd, walk->vma);
> +	if (ptl) {
> +		pmd_t pmde = pmdp_get(pmd);

Kernel test robot reported [1] this is making m68k build fails.  Andrew, could
you please add below attaching patch as a fix?

[1] https://lore.kernel.org/202511172257.CjElDcRX-lkp@intel.com


Thanks,
SJ

[...]

---- >8 ----
From 0908bba1aec11997107af757a34136a14be619b7 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 17 Nov 2025 07:36:43 -0800
Subject: [PATCH] mm/damon/vaddr: provide lvalue to pmd_present()

On m68k, vaddr.c build fails since pmd_present() requires lvalue while
vaddr.c is passing pmdp_get().  Fix it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511172257.CjElDcRX-lkp@intel.com/
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index ef57e95eb422..2750c88e7225 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -311,7 +311,9 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	ptl = pmd_trans_huge_lock(pmd, walk->vma);
 	if (ptl) {
-		if (pmd_present(pmdp_get(pmd)))
+		pmd_t pmde = pmdp_get(pmd);
+
+		if (pmd_present(pmde))
 			damon_pmdp_mkold(pmd, walk->vma, addr);
 		spin_unlock(ptl);
 		return 0;
-- 
2.47.3

