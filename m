Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977219D8AC;
	Fri,  1 Aug 2025 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754091585; cv=none; b=XWxSo79HrOsNQcAnfpXHt1JEbBLMX4S9OfEA8MB9EOMSCZei4obEwN4H/EElKU4gnjShbgiMw2uIcSPtdhEIe0/5EK7PSjuo6RK+rX3dBuJU6TyJRuIhL6DZajPbDDOMkG0vfBLiGKBjdvwGQuvuhyWRmyT0RBO7oDdedj0epcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754091585; c=relaxed/simple;
	bh=5tJRCSbuSBYIOjiD+lXubjl8LyV9TAUxnOkonO+FxG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=quwsfBFZ60kefgiFo6o7Ugbm7EGPqggo1TftygdMM3Cjx5tBe06LTBoX07Vn5ntZ6l8W2rqOweqrLt+Rw+Uzjn24jdQVZ52W0J2m0K4ho1ZV1j69ZYDqMCwkuGFMmfYvwPy1p8SUlkRvviwE0QQCZ3YK1Dy4DLkAYoIvzDTtmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR+dMqyy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR+dMqyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E02EC4CEE7;
	Fri,  1 Aug 2025 23:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754091584;
	bh=5tJRCSbuSBYIOjiD+lXubjl8LyV9TAUxnOkonO+FxG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SR+dMqyynB4Kf1Du44mgvAR58fTQ1TD0vFD/4VlOME/qAgvk0Aj9aYqefvY4VA4DV
	 IAY1zgJnoEOcMzoKWmDyMsTOyaou6ItJXJG7xP/3iobGCfmJqjFrhIiaGvxfqqYe5+
	 aAJ0UnM4TzQ/Jd3Th3KTXVRXY2nLNfBADBkf1KKwJSvotGYv9mWn0Pgy9ZpFXXF/D4
	 oXWgsMVC4AokCvAhItulYq+ThaOrZvH3mqgL9Ys46OeaqowPGDVwn9BCyIHfWLVtlX
	 noLxXHWVkqyBXsbfgOMdHNYfwcJvJEO9kM0ZXUNICESFGV6+2n+AkQIrDgs4X1J05u
	 KH2p05N4aNojg==
From: SeongJae Park <sj@kernel.org>
To: pyyjason@gmail.com
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] mm/damon: Add damos_stat support for vaddr
Date: Fri,  1 Aug 2025 16:39:42 -0700
Message-Id: <20250801233942.1614-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1754088635.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  1 Aug 2025 22:59:49 +0000 pyyjason@gmail.com wrote:

> From: Yueyang Pan <pyyjason@gmail.com>
> 
> Previously damos_stat only supoort paddr. This patch set adds support 
> for damos_stat for vaddr. Also all different types of filters are 
> supported. 

This confused[1] a person.  Technically speaking, DAMOS_STAT action is already
supported on vaddr.  The lack of support is ops level DAMOS filters combined
with DAMOS_STAT action, and this patchset is adding the support.  Could you
please rephrase the subject and the above paragraph?  For example,

    mm/damon/vaddr: support stat-purpose DAMOS filters

    Extend DAMOS_STAT handling of the DAMON operations sets for virtual address
    spaces for ops-level DAMOS filters.

> 
> Functionality Test
> ==================
> I wrote a small test program which allocates 10GB of DRAM, use 
> madvise(MADV_HUGEPAGE) to convert the base pages to 2MB huge pages
> Then my program does the following things in order:
> 1. Write sequentially to the whole 10GB region
> 2. Read the first 5GB region sequentially for 10 times
> 3. Sleep 5s
> 4. Read the second 5GB region sequentially for 10 times
> 
> With a proper damon setting, we are expected to see df-passed to be 10GB
> and hot region move around with the read
> 
> $ # Start damon record
> $sudo ./damo/damo start "./my_test/test" --monitoring_intervals 100ms\
> 1s 2s

Seems you missed my comments[2] on your v2 cover letter.  Could you please take
a look?

> 
> $ # damon report
> $sudo ./damo/damo report access --snapshot_damos_filter allow \
> hugepage_size 2MiB 2MiB

Ditto.  Please check my comments[2] on your v2 cover letter.

[...]
> $ # damon report again
> $sudo ./damo/damo report access --snapshot_damos_filter allow \

Again, please check my comments[2] on your v2 cover letter.

[...]
> 
> Revision History
> ================
> Changes from v2 [2]:
> - Fix some naming and format issues raised by SJ.

Thank you for continuing this great work!

> 
> Changes from v1 [1]:
> - Follow David's advise to combine *pmd_entry() and *pte_entry() into
>   one. Also remove manually setting walk->action
> - Use vma_normal_page and vma_normal_page_pmd instead of damon_get_folio
>   to remove redundant folio_get and folio_put
> - Follow SJ's advise to only move damon_pa_scheme_has_filter to
>   ops-common
> - Change the command used in cover-letter for more natural illustration
> 
> [1] https://lore.kernel.org/all/cover.1753794408.git.pyyjason@gmail.com/
> [2] https://lore.kernel.org/all/cover.1753895066.git.pyyjason@gmail.com/
[...]

Thanks,
SJ

[1] https://lore.kernel.org/20250731175827.16060-1-sj@kernel.org
[2] https://lore.kernel.org/20250730200239.60984-1-sj@kernel.org
