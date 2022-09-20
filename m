Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE001115
	for <damon@lists.linux.dev>; Tue, 20 Sep 2022 16:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3ABC433C1;
	Tue, 20 Sep 2022 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663691587;
	bh=SyW+GjcCjRvE/yEXks2zPGJu/Rt4pnX5r+N3a1uyxRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhErWCSXOBGZYglnFQomPh1MstM47hkNjGtSFgdan3Md7RI2FRukF/duTNdl0C68A
	 x5UiXF8ItPbVLg0jQHak3yfVzS4E99Ebn9mfmAzIZnII5mCA/VbK7DHD3YIcME+YWA
	 RDTHsOhFZewi3rpaIHKYL658obI0MyrNue5EYyENGO+CSaXHIiCImFATLALPrIzp0J
	 ise+R6QUykAYt/mFnaxfNlCJFIKEGbRRswnNePCbElcVV9olZu69MU/GWV1QmN9cxZ
	 X/KyWzw4lots2TpacCtsCwBBEdRsmY3lXLgqXnaIFnAxutgs4NDtBVHpYwhl0vlp8S
	 j8QIvUl3P20+A==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/sysfs: return 'err' value when call kstrtoul() failed
Date: Tue, 20 Sep 2022 16:33:04 +0000
Message-Id: <20220920163304.52672-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920025158.70293-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

On Tue, 20 Sep 2022 10:51:58 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> We had better return the 'err' value when calling kstrtoul() failed, so
> the user will know why it really fails, there do little change, let it
> return the 'err' value when failed.
> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Looks good to me overall, but...

> Changes from v1
> https://lore.kernel.org/linux-mm/20220919170305.61335-1-sj@kernel.org/T/
> - keep the 'err' variable, and return the 'err' value when failed.

Patch changelog shouldn't be here as a part of the commit message,

> ---

But here.

Other than that,

Reviewed-by: SeongJae Park <sj@kernel.org>

I will revise and post it on behalf of Xin, for reducing unnecessary Andrew's
burden.


Thanks,
SJ

[...]
