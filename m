Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7515B8
	for <damon@lists.linux.dev>; Tue, 14 Feb 2023 04:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p+bChmlvh7LMvh5Y4Z+EEbtWSwcTxFruTWwVWYj6SM4=; b=O+ebOqEE74wqxSJzcbyIu0QYBH
	2vs06XLi0DzhSjrQev+ypdu/zOwEZb1yiIf52NSNtpTyglV1CUwwA55PZpbc72Zq6+zBCbln2yqby
	o0KHZRljjzrHdF2APS6WX1Zx+o1SjUVF2sxp0QP6rbM8dxPQZx+4y3fZKLKdMRwJwlS3D0lO/iom9
	prqRmdjvfYBndWVhyF3y/VJYavF7mmkJrPm65WdATw5dnfsmHdGFvaKGTsxmwJPz2jmbriTlkFqlU
	FhLgxhAHo8Yc/2LX6WTwtMMtJZqL05vMdpYqVhapD+LKCLgpO8K55UXfvaHDQTn2wsUIVh3Vl9901
	8fdmdI8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRnGx-006OMR-1R; Tue, 14 Feb 2023 04:50:31 +0000
Date: Tue, 14 Feb 2023 04:50:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, sj@kernel.org,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeelb@google.com, muchun.song@linux.dev, damon@lists.linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Some cleanups for page isolation
Message-ID: <Y+sTFqwMNAjDvxw3@casper.infradead.org>
References: <cover.1676342827.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676342827.git.baolin.wang@linux.alibaba.com>

On Tue, Feb 14, 2023 at 11:18:05AM +0800, Baolin Wang wrote:
> The page isolation functions did not return a boolean to indicate
> success or not, instead it will return a negative error when failed
> to isolate a page. So it's better to check the negative error explicitly
> for isolation to make the code more clear per Linus's suggestion in [1].

Only one caller of isolate_lru_page() or folio_isolate_lru() actually
uses the errno.  And the errno can only be 0 or -EBUSY.  It'd be
better to change the three functions to return bool and fix
add_page_for_migration() to set the errno to -EBUSY itself.
