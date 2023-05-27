Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2A194
	for <damon@lists.linux.dev>; Sat, 27 May 2023 02:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEACC433D2;
	Sat, 27 May 2023 02:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685154915;
	bh=OARHjl7VtSdPoG7u5ehRQS9jDdQ7zVa4zuVU0zJzJLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=vOJFzCGpW1ATUZ2z1oyj//r7R4XFpU8o1SPSilDqjJ7VozGVRyp4R3WcFd6SsTbkB
	 xBpXx4R39XzOQb+k4e6Jl+2Uz3RlG7k3h/+Ia6A5x8RNO08cHQJYnTglse+KnFLQK+
	 QFQ04FZueDQG1csGHgzR3YgzUZe1QGLLSRdNsMXwcbcvPkgLxCBjFCsP/gCWzcqVrL
	 +XHEQSmxSY4HVr6SlEZ/sZGqRkTA5IB+J6nIpm5pimHl+UWGJL+ifkiRloYXw/S1NC
	 mD/m8jLetJO5gTcbNfA/j4K5iTlpho7c6rofQlMOWEgW4jRcanWYWoo8QX3N3ab7F2
	 SuQjymaWreArg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/damon/core: fix divide error in damon_nr_accesses_to_accesses_bp()
Date: Fri, 26 May 2023 19:34:59 -0700
Message-Id: <20230527023459.8567-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230527023149.8441-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

On Fri, 26 May 2023 19:31:49 -0700 SeongJae Park <sj@kernel.org> wrote:

[...]
> Could you please resolve those by wrapping the commit messages and adding
> 'Closes:' tag?  'Closes:' tag might be able to replace the 'Link:' tag I
> supposed above.  I have no strong opinions there but having both may harm

s/supposed/suggested/


Thanks,
SJ

[...]
