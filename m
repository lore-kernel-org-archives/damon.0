Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A12773D5;
	Wed, 27 Aug 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318069; cv=none; b=rtbeI4ruT5PeIn2w6aLkeFPgI9RycGhYaas49BfoTYLhvc4JxP8OcNC7ivdkvRJHYYmG+vPRz8qvimteyNWzxbAxzIJjPCpX9LvyflrnyHb3ScglmZmXfc3iEITNOAdeCXnolHOobsfm4TfqK0pLfL6kVGGNB1+c7YqQkvrnqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318069; c=relaxed/simple;
	bh=u0yRpz9nPUw7n0Wvbb3I6ZaPCD/6ktT6MO+LuMdPTX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUds7/zSKiFFkvUXqJVYJHYj3DkIO6n0BqAAg/cKMbrI910G+WW5NzJWCXJMkXepsFRJrtm0ACcZTHp+XgKs5jeWuhWBxs2+Vquytuh/lK1aZiytmeOOzWWLEpZBaFss75qjxTrAAVyqV6N7lZ9PWyqzzo+lDKNtCxKnafqoh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCs1vENy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCs1vENy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58D2C4CEEB;
	Wed, 27 Aug 2025 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756318067;
	bh=u0yRpz9nPUw7n0Wvbb3I6ZaPCD/6ktT6MO+LuMdPTX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MCs1vENyD+rxiJfUXqpEtZd1RAFN/vrf56+/KcrMyqFrwT4Mv6QoI2TNL6LHx+U17
	 +I1v0LPZj//CZDW4TOs9Gzm5hFZFD57vCtXy1R5CIdPjqfR7mFq+RdM3dHqUkUJvUI
	 OcskECestTxoUe1P3i+EYoTOjd/95xKVP5uLM5Ht+v5kns1Jr90cpCt3UMwN5bihcf
	 vYLDA43Gy6L0H5KxjsyqA/0oWuo2uBhVn95swjN3B+JZW72aimIsgDfVxi4jiaQuMl
	 EinZLRr3+Q47NGCVGujNw1sSO3InYaYZlO/MzjqIXmPjCRLtNY3HkHUH49hvz3dp6j
	 2124axhtXs3sw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	kernel-team@meta.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 03/11] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Wed, 27 Aug 2025 11:07:43 -0700
Message-Id: <20250827180743.47876-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <890b1575-abab-4b3c-8953-110e1dd3f9ed@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 27 Aug 2025 19:37:38 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Hi SJ,
> 
> 在 2025/8/27 10:42, SeongJae Park 写道:
> > On Wed, 27 Aug 2025 10:21:41 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> >
> >> 在 2025/8/26 22:21, SeongJae Park 写道:
> >>> On Tue, 26 Aug 2025 12:51:17 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> >>>
> >>>> Hi SJ,
> >>>>
> >>>> 在 2025/8/26 11:21, SeongJae Park 写道:
[...]
> >> Please consider approving this fix.
> > I'm yet in travel, and I'd like to take more time on thinking about the proper
> > fix.  Quanmin, could you share more details about your test setups, both for
> > the compiling success case and failing case?
> 
> Apologies for disturbing you during your travels. Please allow me to explain:

No worry, I'm the one who would like to apologize, for delayed response :)
I'm back from the travel, btw.

> 
> When CONFIG_PHYS_ADDR_T_64BIT is enabled on "i386" [1], the phys_addr_t type
> becomes 64-bit, requiring the use of the do_div function. We are in agreement
> on this point.
> 
> On arm32, if LPAE (which we intend to support in this series) is enabled,
> CONFIG_PHYS_ADDR_T_64BIT will also be enabled. In this case, pa / addr_unit
> will involve 64-bit division and similarly require the do_div function.
> Obviously, such link errors should normally occur under these circumstances.
> Unfortunately, the expected anomalies did not manifest in my previous tests.
> This may be related to some incorrect adjustments I had made to my local build
> environment quite some time ago — though I cannot be entirely certain. That
> said, I have since cleaned up the old configurations and ensured the current
> environment is clean and normal. For now, we have confirmed the actual problem
> and its root cause, shall we focus on fixing it?

Thank you for sharing the details.  I wanted to better understand where the
issue happens and not, to clearly understand the root cause and make a proper
fix based on that.  I think we can now focusing on fixing it.

> 
> In summary, after introducing addr_unit, we expect that any 32-bit architecture
> should support monitoring of 64-bit phys_addr_t. Therefore, we can consider the
> following adjustment:
> 
> #if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
> 
> Or at least adjust it to:
> 
> #if defined(__i386__) || (defined(__arm__) && defined(CONFIG_PHYS_ADDR_T_64BIT))
> 
> I have thoroughly re-validated the feature functionality today and confirmed the
> correctness of the aforementioned modifications. Therefore, could I kindly ask
> you to consider the aforementioned modifications when you have some free time?

Thank you for the suggestion and testing, Quanmin!

I was thinking making the change for only i386 is right since I was mistakenly
thinking the issue happens only on i386.  Now it is clear I was wrong and we
have at least two cases.  And I agree your suggestion will fix both cases.

But I'm bit concerned i386 and arm might not all the case, so wannt make the
fix more generalized.  My understanding of the problem, which is enlightened
thanks to you, is that not every config supports dividing 64 bit with 32 bit.
And div_u64() is suggested in general for dividing 64 bit with 32 bit.  So,
what about making the if condition more general but specific to the root cause,
like below?

static unsigned long damon_pa_core_addr(
               phys_addr_t pa, unsigned long addr_unit)
{
       /*
        * Use div_u64() for avoiding linking errors related with __udivdi3,
        * __aeabi_uldivmod, or similar problems.  This should also improve the
        * performance optimization (read div_u64() comment for the detail).
        */
       if (sizeof(pa) == 8 && sizeof(addr_unit) == 4)
               return div_u64(pa, addr_unit);
       return pa / addr_unit;
}

Because the sizeof() result can be known at compile time, I think it shouldn't
cause the linking time error, and I confirmed that by passing the i386 test
case that kernel test robot shared.

Could I ask your opinion, Quanmin?  If you think that works, I could post v3 of
this patch series with the above fix.


Thanks,
SJ

[...]
