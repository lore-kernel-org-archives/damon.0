Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F1022128F
	for <damon@lists.linux.dev>; Fri, 20 Jun 2025 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401005; cv=none; b=oSddXycv+85k6JW1YoSmADFQ+SiMgMvPYBKPG6PO2NZ9I5Mzs975XnmeFJmoGTyFyyGzh9W3LMIyIfBDyDcSHi927lmyUXLcns1bm86AVgj9QMDOgNr6POcSj/VuL4e801qvUK2z5IWGvXsCu+3LmiT1QT3mkCkXMNonaNCOCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401005; c=relaxed/simple;
	bh=ndDVKrpY8hPr55MamAh+uliDP+m6d/vRSWkwjOVyyJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcggu9wyGcrk5euMEJq04KUguIWbXxbSS9yiUdMnp4Ms5FY8ZhPE4NrQlfy82xvewGiElta+Bc3Ag4+xl9AZRM8nj33jrSvKhnXSDXeugMYmemfaAtLohK5nSGzWH0TXDwsgy0k/pmWghfGAvbV9qXl5xQw+7tVeC6xIDg4k9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-cc-6854ffe17f4d
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH] samples/damon: add parameters for node0 memory usage
Date: Fri, 20 Jun 2025 15:29:46 +0900
Message-ID: <20250620062951.1572-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250619164636.58743-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsXC9ZZnke7D/yEZBv+ncVvMWb+GzeLJ/9+s
	Fpd3zWGzuLfmP6vF4a9vmBxYPTat6mTz2PRpErvHiRm/WTxebJ7J6PF5k1wAaxSXTUpqTmZZ
	apG+XQJXxvrdbxkLpnFVLJvVzdTAOJ2ji5GTQ0LARGLqvwcsMPb1rmvMIDabgIbEwUMnwWwR
	AUWJc48vsnYxcnEwC6xmlNg8uZ0NJCEs4Clx68VERhCbRUBV4kjzBrA4r4C5xN6u5UwQQzUl
	Gi7dA7M5BYwlnrU0g9lCAjwSrzbsZ4SoF5Q4OfMJ2BHMAvISzVtnM4MskxCYwSZx9OE+qOsk
	JQ6uuMEygZF/FpKeWUh6FjAyrWIUyswry03MzDHRy6jMy6zQS87P3cQIDM5ltX+idzB+uhB8
	iFGAg1GJh3fHl+AMIdbEsuLK3EOMEhzMSiK8i0/4ZQjxpiRWVqUW5ccXleakFh9ilOZgURLn
	NfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgVF9+/OSp3CvHF0sydq/bG1K9I5eTve7mHcHqk3tz
	vA8cuVpzW5zTi33exGbFtydevIjfWvVKh1ufO64otqZmzp2Q27ue+e1lya1jFHINffvtacix
	2GU2d6/9OXJR8tF9pjUaW9bX13GrGUX7Bcx7yRz1bsHOircPb2/KKO8U3/3kgNaVp5eTNyux
	FGckGmoxFxUnAgC+LTaISgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsXCNUNWR/fB/5AMg//LrS3mrF/DZvHk/29W
	i8/PXjNbHJ57ktXi8q45bBb31vxntTj89Q2TA7vHplWdbB6bPk1i9zgx4zeLx4vNMxk9vt32
	8Fj84gOTx+dNcgHsUVw2Kak5mWWpRfp2CVwZ63e/ZSyYxlWxbFY3UwPjdI4uRk4OCQETietd
	15hBbDYBDYmDh06C2SICihLnHl9k7WLk4mAWWM0osXlyOxtIQljAU+LWi4mMIDaLgKrEkeYN
	YHFeAXOJvV3LmSCGako0XLoHZnMKGEs8a2kGs4UEeCRebdjPCFEvKHFy5hMWEJtZQF6ieets
	5gmMPLOQpGYhSS1gZFrFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGHzLav9M3MH45bL7IUYB
	DkYlHt4dX4IzhFgTy4orcw8xSnAwK4nwLj7hlyHEm5JYWZValB9fVJqTWnyIUZqDRUmc1ys8
	NUFIID2xJDU7NbUgtQgmy8TBKdXAeL9Csst5XbyQztygMz33ryv/P6rOefOqgF/WpxWN/Z++
	n6p1kHN5Lias8ZWX0yq1/80rg8c37EzYTt79tv2V3nS1IwuStfxmXtec97zyyev10VrlF1IF
	M0y43k5+u1zont8CJ6mubaKlhTG+955dmuBQwn1kj8nacp656o8fbCg9o+vCfPPNJiWW4oxE
	Qy3mouJEACWiEao6AgAA
X-CFilter-Loop: Reflected

Hi Andrew, please check the patch below. I missed CC'ing you on the previous
email.

On Thu, 19 Jun 2025 09:46:36 -0700 SeongJae Park <sj@kernel.org> wrote:
> On Thu, 19 Jun 2025 14:03:12 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> 
> > This patch changes the hard-coded quota goal metric values into sysfs
> > knobs: `node0_mem_used_bp` and `node0_mem_free_bp`. These knobs
> > represent the used and free memory ratio of node0 in basis points
> > (bp, where 1 bp = 0.01%). As mentioned in [1], this patch is developed
> > under the assumption that node0 is always the fast-tier in a two-tiers
> > memory setup.
> > 
> > [1] https://lore.kernel.org/linux-mm/20250420194030.75838-8-sj@kernel.org/
> 
> Thank you for this patch.  Please note that this is just a sample code, and
> hence there will be no strict user space compatibility support.
> 

Thanks for reviewing. As you said, this mtier sample module needs further 
development for final version, like automatically detecting memory tiers and
adding some useful knobs. May I continue working on the mtier module? 

> > 
> > Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ
> 
> [...]
