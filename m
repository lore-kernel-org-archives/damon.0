Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887C7C
	for <damon@lists.linux.dev>; Sun,  2 Oct 2022 19:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1F5C433D6;
	Sun,  2 Oct 2022 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664739418;
	bh=LvdA4nKSrotgHMTvX23UojetKOPJvfcUlZAliPGdX2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlN7SIDmB0GB/uWlkZAiu9j476c0931Rsv/SuSk7inzEV73Ng9VlOUtpP8qTNpX8P
	 tDCHVzoK/mO5maTHGT/b2zc92i1M/ZhY44yyppzd8ZFJ30mibuD179M+dcNL4RncU5
	 1koxUFC1Zje5/2LAKI4OirMSnAn5fl5C9Gex2vVkIgTRDyT5Y/HhY/OfC5PGrEK2Z5
	 zJf1IyQRAzC+No7Frxq2mvCd/yzuLxybxUu5bZkcK+cXHEsg0cw3omKieUGdzOXUSF
	 cd+pUtl35DdZW/awvo19spfDJaQf2ScLND+3VrhFAv1f37qOZ+FHAA1gg+zFtd+nBa
	 D42DhR7ymlqcQ==
From: SeongJae Park <sj@kernel.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: sj@kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev
Subject: Re: DAMON KUNIT test failure in latest mm-everything
Date: Sun,  2 Oct 2022 19:36:56 +0000
Message-Id: <20221002193656.8300-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Yzk8rfGNTTiU3tH0@hyeyoo>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hyeonggon,

On Sun, 2 Oct 2022 16:24:29 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> On Sun, Oct 02, 2022 at 01:24:23PM +0900, Hyeonggon Yoo wrote:
> > Hi guys, yesterday I just built and booted latest mm-everything,
> > and I got following report from KUNIT test.
> > 
> > Environment:
> > - x86_64, gcc 11.2.0
> > - mm-everything (tag: mm-everything-2022-10-01-01-55)
> > - config attached
> > 
> > Report (stacktrace decoded):
> 
> FYI, below is the bad commit from git bisection ;)
> 
> Thanks!
> 
> 065530b966a42d63f214ba40427dc8d00345f573 is the first bad commit
> commit 065530b966a42d63f214ba40427dc8d00345f573
> Author: SeongJae Park <sj@kernel.org>
> Date:   Fri Sep 9 20:28:57 2022 +0000
> 
> mm/damon/core-test: test damon_set_regions
> 
> Preceding commit fixes a bug in 'damon_set_regions()', which allows holes
> in the new monitoring target ranges.  This commit adds a kunit test case
> for the problem to avoid any regression.

Thank you so much for this kind report!  I just sent a patch[1] for this.  It
should fix this issue.  BTW, please note that the real issue was there even
before the kunit commit, but the kunit commit was the first commit that
triggers the issue.

[1] https://lore.kernel.org/damon/20221002193130.8227-1-sj@kernel.org/


Thanks,
SJ
[...]
