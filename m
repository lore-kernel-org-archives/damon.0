Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421892F2C
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 08:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DA2C433C1;
	Wed, 14 Sep 2022 08:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663142783;
	bh=tz2wl0ODbAbHBp+5FRVVBI6erZjKNxf6vRG2VcY5R3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lg5tnyTFNbTp0GbDkGpDVmhjFxfbC4HMDOu+m3OMhY87RAzNHtU46/l1V7nrRSPrJ
	 Wv4Sf0bj1s3HDCf/zPNRaPZO4GP8dHWeNQpKdGesWveX1tf32vOMxYj4BAzkMucYO5
	 gwLaCS/FqMGN92S2Uzim4bbS7OJ3uDVEOxw/fzJe/804UXxNZ2rZ72I5O3LYHWs0Z/
	 hHed1xzltTlM0ALgiH0ZVIZP7w+GsUzhplqgCXgz46ABmNE4+jD1PUUX5tGqFT1zhy
	 4PEZ+xU4VDAgiPd5LgRpZCAQdy8H2zRURx9jsRBtEFGOvfp/bBlWZ2VsWNwSGlmlsG
	 SKhOT/HbJ/Isg==
From: SeongJae Park <sj@kernel.org>
To: haoxin <xhao@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: simplify scheme create in lru_sort.c
Date: Wed, 14 Sep 2022 08:06:20 +0000
Message-Id: <20220914080620.58974-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <936d9ace-45b5-6579-b1c6-872055cce979@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xin,

On Wed, 14 Sep 2022 08:35:01 +0800 haoxin <xhao@linux.alibaba.com> wrote:

> 
> 在 2022/9/13 下午11:43, SeongJae Park 写道:
> > I'd like to apply your patch and then rebase my cleanups on it, but it might be
> > not a one second work.  Could I ask you to wait until my cleanups are done?  I
> > will post the patches within this week.
> Ok,  thanks.


Thank you for kind understanding!  I posted my cleanups yesterday and those are
now merged in the mm-unstable.

Appreciate again.


Thanks,
SJ
