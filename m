Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B3C2586
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 17:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A71C433EF;
	Wed, 28 Dec 2022 17:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672249892;
	bh=JPdXkfHrXS1wcBZhgmB9zPkLNeEKOqO7MhRkizrbbxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FaPccfJq7XN4doE1Pmc9J8/oyC1OYJFcdCmud5K/NVnq9EPzhmdkOKKxiLlOcO6NV
	 W4Wy0NULSy0owKTBk/rwAoSOfH6joaiWYWA6t5ebUn0vimRHnUEG4inLK8ifGkH4X4
	 cC6THdQgrTltrmxfXGw1zpAkhqqUbwrVmQ1XlZXamL6WVHWnNbw3Sew6ZjKEvw1zEX
	 ELl9O64jNWW3xxcSq2pfcrGzewF7LrsgpH5nDpy92pz0Hz4mBQVX6Pw0uQlNkSI9NV
	 JjyaUpGYrb2bg2EOPfh5PPJ48ARqB86qErHpWAJKpQoWZBvZJ4lXoY2yde6gDUf91J
	 NDOiUd8nLaPIA==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	vishal.moola@gmail.com,
	willy@infradead.org,
	david@redhat.com
Subject: Re: [PATCH -next v3 7/7] mm/damon/vaddr: convert hugetlb related function to use folios
Date: Wed, 28 Dec 2022 17:51:29 +0000
Message-Id: <20221228175129.149334-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228113413.10329-8-wangkefeng.wang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kefeng,


Yet another typo on the subject that I should mention earlier but forgot.
Sorry for this late comment.

s/function/functions/

On Wed, 28 Dec 2022 19:34:13 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Convert damon_hugetlb_mkold() and damon_young_hugetlb_entry() to
> use folios.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Other than the trivial nit,


Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ
 
[...]
