Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034C46B4
	for <damon@lists.linux.dev>; Tue, 27 Sep 2022 16:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93E1C433D6;
	Tue, 27 Sep 2022 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664297215;
	bh=eytrRagVaWjBKmjz1wxgiF5QIrdp0pjGvQlDcuAKjdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQL7R4ZLmncYv3pMXg8Faf1wR6E9yY/gW2VMpsdvJB6qE4IoJAzKeUm7VeP7iihpf
	 DzKPPSVjm5X5TPoLno+JtSb0D3tkQIx9XbnzmL35QhUKJdATlDpfGkM0JjOCU/3H7H
	 fK/JcqaL4wQQ0ZOwMENK0uuZ12LLLcHZCVy+wJPKQY96vJdePgV14R1pb7a+gVkgNh
	 ojZEsgljpY5TY+ATdN7NnlcHnzqPBlsJbE61Pm1aR0mPYjC4TOg1EOqxmdwLt6lFds
	 K3N1CsVZHCm2uCt+Wmm4xgvTr2QLpNd7UlD/K43/sWXp3XDMs1XtM8TUnNqbG6YS35
	 uVbVpwaZIzYyA==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon: move sz_damon_region to damon_sz_region
Date: Tue, 27 Sep 2022 16:46:53 +0000
Message-Id: <20220927164653.88919-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927001946.85375-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 Sep 2022 08:19:45 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Here, i rename sz_damon_region() to damon_sz_region(), and move it to
> "include/linux/damon.h", because in many places, we can to use this func.

Thank you for your works, Xin!

> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

For the series,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
