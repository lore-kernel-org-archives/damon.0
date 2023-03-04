Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ECB28F7
	for <damon@lists.linux.dev>; Sat,  4 Mar 2023 19:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D67BC433EF;
	Sat,  4 Mar 2023 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677958800;
	bh=6TeDbR5GXJJF54b96kNnySeQoyETESDXw9WrPqnw/VI=;
	h=From:To:Cc:Subject:Date:From;
	b=Fw/AwxpST4BRnmybFAJfo3Nj/+vYbZKVoaSa9sAipEycxpJGLaFSszOvb/ysWG2jJ
	 VXBIITE+AAcbftEmWT0cfga+EKGTg4i8xf6/YJv3zsJvQFq8bqeUP9zdUnL+BiokZj
	 yfNWULFx3tTWr5pHWx7nocG0143d9WM5WFZlKnHGfAO0oC1CSNRdFpFdPo0n7fkr9Q
	 2mi4zYhPjP+8E/yjG8B+S/L54IPPOJuLOsi8fLXJp/mY0qXBl4aa75IsJyskcq3OIb
	 C0BdMqOtsdBgMpxjFZI8AmHXkDxlSTtS7PfBR5CD6GyuFwsdwP/Hid9xU1G99hXRtT
	 0+oV4gHxOIVSg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon/paddr: Fix folio-use-after-put bugs
Date: Sat,  4 Mar 2023 19:39:47 +0000
Message-Id: <20230304193949.296391-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two folio accesses after folio_put() in mm/damon/paddr.c file.
Fix those.

SeongJae Park (2):
  mm/damon/paddr: fix folio_size() call after folio_put() in
    damon_pa_young()
  mm/damon/paddr: fix folio_nr_pages() after folio_put() in
    damon_pa_mark_accessed_or_deactivate()

 mm/damon/paddr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.25.1

