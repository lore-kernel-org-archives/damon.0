Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1294683
	for <damon@lists.linux.dev>; Thu, 18 Aug 2022 16:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37F9C433D6;
	Thu, 18 Aug 2022 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660841244;
	bh=TOzmBUEyJkFq8BX4F3WOSMODGQe0Ba5ENH0sx85QamI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLH25lEpgr2dMgoKRLVa5sV7uD7QbcSjlsoML0BE3YJgHOw4bNv18wV4xwemwNYk9
	 6AJSWHFQ3vI+SyxlslrKJMcJZvFMtVZTC/PToXpElifvn3YClsfz2AoPwJGPTBN3+Q
	 Y01N1HFicGjAzSz2/d0KuYOtCW88ctTocyT+GOMUapTOtnTdjAJs/hPv56bFWXeYe0
	 o1MJU2aAX0xWqoM50OayLwwNOACLQr1oTMuKIT9PdbQhW+5tbGpWjpeYWdTUEa64Gp
	 F/f53FsfZZxzfwALuucn9/9j3vkb227bGsx4kUb+w44cVfy0naZIkS8mlZAiTyUqME
	 ZZFxmfPs/e4jA==
From: SeongJae Park <sj@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	mike.kravetz@oracle.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon: replace pmd_huge() with pmd_trans_huge() for THP
Date: Thu, 18 Aug 2022 16:47:22 +0000
Message-Id: <20220818164722.51448-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a9e010ca5d299e18d740c7c52290ecb6a014dde6.1660805030.git.baolin.wang@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Baolin,

On Thu, 18 Aug 2022 15:37:44 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> The pmd_huge() is usually used to indicate if a pmd level hugetlb,
> however a pmd mapped huge page can only be THP in damon_mkold_pmd_entry()
> or damon_young_pmd_entry(), so replacing pmd_huge() with pmd_trans_huge()
> in this case to make code more readable according to the discussion [1].

Thanks to Baolin and Muchun for the discussion and this patch!

> 
> [1] https://lore.kernel.org/all/098c1480-416d-bca9-cedb-ca495df69b64@linux.alibaba.com/
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
