Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB52CAB
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 17:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93A8C433EF;
	Wed, 28 Dec 2022 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672249584;
	bh=AH1OxYrcO8YjdjIacmty0G2IXYk7bOFU+c/cWyigp68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqZG7/OnrcFi2AJsYadz7bEwhPAT2GAXRKYJoNUgWh05hTFfN3OVa/zmvrIe2wW4q
	 miFx9/n+thFJ2qxR4arbQQMLQuqV7NLNAWvzU9myVWu+sF+4gIlNZYIrFFPS0JH7nH
	 YsRv6LkG8joT4ULTKAP8veSddWJ7P8/6nMEuQm4ohfgpyjg+rFUQBTI83cbgANURO1
	 WdMEUaZZWJV7gWCR3CyT4TtX//eyFYWX4V4Q4lt5WOtSP+Ydu0YvFETulEQsu76e6d
	 beUk54YvJ4AvtCNDjxFPC4UU7GaLLRBvW4x5PRT05QFfaG2PMMUgvOmT/MZ+XCUMxL
	 SIqluDWcRma3A==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	vishal.moola@gmail.com,
	willy@infradead.org,
	david@redhat.com
Subject: Re: [PATCH -next v3 1/7] mm: page_idle: convert page idle to use folios
Date: Wed, 28 Dec 2022 17:46:21 +0000
Message-Id: <20221228174621.34868-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228113413.10329-2-wangkefeng.wang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kefeng,


Thank you for your effort on this work, but I forgot mentioning below trivial
typos in the previous spin.  I should mentioned those earlier, sorry.

On Wed, 28 Dec 2022 19:34:07 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Firtly, make page_idle_get_page() return a folio, also rename it to

s/Firtly/Firstly/

> page_idle_get_folio(), then, use it to covert page_idle_bitmap_read()

s/covert/convert/

> and page_idle_bitmap_write() functions.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Other than the trivial typos,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ
