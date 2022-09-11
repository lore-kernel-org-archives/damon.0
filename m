Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C337F
	for <damon@lists.linux.dev>; Sun, 11 Sep 2022 11:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F24C433D6;
	Sun, 11 Sep 2022 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662897443;
	bh=mGFSKvyr3J8oywtPSjgu8i64jOtXdSIc9VRry4m1+dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Le+32p1D6J8gwxQyKiNSm6+En8DaCH38zHSsByO5Vfd+igNTUanZFqy+yuZLUwKc4
	 j/G/oiovInlKYsI2Vr2mu/YbeBFssFt3/2cVDjwDCrN4hfbVvT5lw/7dE6SVZRV5O9
	 iJ60Cfe7+NvBF3jlTez9Pw7NfCp2xzIqhmoaUcRq7vF5REFf2OQQ286Yx1SZpbpse1
	 2AayTjKZJo2VofVXuvH4gmywi8ghq0uXH1C+YIWe0kLDvPjEsSjNnw0s16eCX0qTw7
	 mn6r6Ydhyf5YzuVv3p4hIYSqzW4JQcH6U45PCpT7scxJgtVKGvzN2T4qmqHRSl/MPG
	 MP24UuHLPcwEw==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/damon: simplify scheme create in damon_lru_sort_apply_parameters
Date: Sun, 11 Sep 2022 11:57:18 +0000
Message-Id: <20220911115718.51465-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911005917.835-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

On Sun, 11 Sep 2022 08:59:17 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_lru_sort_apply_parameters(), we can use damon_set_schemes() to
> replace the way of creating the first 'scheme' in original code, this
> makes the code look cleaner.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
