Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC7C26CE05;
	Tue, 21 Apr 2026 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776743791; cv=none; b=BKvuUV5NADnHNFQEvpl+aEG10NKtovF14D3OFc+rPGEpPhnxWlictWHnyc7WNuOx5B5w7gSx2Q7H0Xmt9AupL6AJU7zGq4ZgK29dEhi7f3jfE2rnRUS+pUVBOfqrhd9hC0ubxlu3tYIzvw9vnzebQQpuUC5h0TGfqinvmpgzVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776743791; c=relaxed/simple;
	bh=AhqzqmCA4tx3rY6a7rv8WzDeP5oJmLfeTUm+EWQccPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9XhRb148gKO7oDbNbsnoR3FAnywUJFc6RtXhw/eauJzIJ6bnadEjALSpMfS5TEgtPxjpvaYFdF78Q4VxFfSm1jWrLSlqCEEyKkOCMkeLIKd4wGnP/Ml6leMcRL/Ei5djW2tncGC+vB5g596GilVPD0G3KoMVPQOQaIgRUtEkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLdRLh/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLdRLh/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A85C2BCB3;
	Tue, 21 Apr 2026 03:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776743790;
	bh=AhqzqmCA4tx3rY6a7rv8WzDeP5oJmLfeTUm+EWQccPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLdRLh/PbmOu+fnOxQqqxD9BYXr3mFvmG7MNCfPArKkT3qY761v3Jke4S0PuLu1J+
	 DLiLj/fcfmoTlIyzl5P0MAZwxM42GBcEcxYrynLGHJx8Z4K/c/RJC0HOdzXKE2fgIU
	 og5MF2KhyxQg+9aAX+SVk6y7Ww2LEgN61o876DZm1vA0gbdhrFXO4hS+IB3UiA5g2B
	 s2rdRBSF89sWYMEL75qTkvkAbON6Vt4aFQEU46wLiXIBi9WN9yLv1aGaFwuNpqwiG6
	 9DVDme0kaWiU0n/HGPWUFffIKxzz6GHR39zmAB75+qeYYgRG3PMEkuF/sXlC8OenHY
	 v7JSm4a9+jT2g==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 156/181] mm/damon/paddr.c:195:7: warning: variable 'matched' is used uninitialized whenever 'if' condition is false
Date: Mon, 20 Apr 2026 20:56:20 -0700
Message-ID: <20260421035620.138367-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202604210331.wdB3yt0y-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Apr 2026 03:16:29 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   ecd4906478687820c088904becbcf3c80ded7d81
> commit: 8c863600a03e3066ce88bf8db48953176befa4c4 [156/181] mm/damon/paddr: do data_attr filtering
> config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20260421/202604210331.wdB3yt0y-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260421/202604210331.wdB3yt0y-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604210331.wdB3yt0y-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/damon/paddr.c:195:7: warning: variable 'matched' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>      195 |                 if (f->type == DAMON_FILTER_TYPE_ANON) {
>          |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    mm/damon/paddr.c:203:7: note: uninitialized use occurs here
>      203 |                 if (matched)
>          |                     ^~~~~~~
>    mm/damon/paddr.c:195:3: note: remove the 'if' if its condition is always true
>      195 |                 if (f->type == DAMON_FILTER_TYPE_ANON) {
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    mm/damon/paddr.c:193:15: note: initialize the variable 'matched' to silence this warning
>      193 |                 bool matched;
>          |                             ^
>          |                              = 0
>    1 warning generated.

Thank you for this report!  I just pushed below as a fix to damon/next.

'''
Author: SeongJae Park <sj@kernel.org>
Date:   Mon Apr 20 20:52:35 2026 -0700

    mm/damon/paddr: initialize 'matched' in damon_pa_tests_pass()

    Reported-by: kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202604210331.wdB3yt0y-lkp@intel.com/
    Signed-off-by: SeongJae Park <sj@kernel.org>

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4788abce08a50..8d49c3e944cfe 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -190,14 +190,12 @@ static bool damon_pa_tests_pass(phys_addr_t pa, struct damon_counter *c)
        bool default_pass = true;

        damon_for_each_test(t, c) {
-               bool matched;
+               bool matched = false;

                if (t->type == DAMON_TEST_TYPE_ANON) {
                        struct folio *folio = damon_get_folio(PHYS_PFN(pa));

-                       if (!folio)
-                               matched = false;
-                       else
+                       if (folio)
                                matched = folio_test_anon(folio);
                }
                if (matched)
'''


Thanks,
SJ

[...]
