Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB11632C8;
	Sat, 27 Sep 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758993658; cv=none; b=Pdi7oNoQNjI9xB0v1o7DDw82f2hVpJOTtNu8UMLvsCwIn5oWRlfACGk8ew9ehXb8SNAKdXfUxGS4+cZRcUZS6fPLkE1YGT/nIcqQQ+1gMHucR2dKO+EWiHCieYoE41CJGVeWtjbJ3RCAR3vvBsFbDqjI7ECBcspgfziTGhGXTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758993658; c=relaxed/simple;
	bh=wS3DRm04+H3K/wyL5VDDsA9Fi2Z1LU9EV49a582r2IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fokHuGU9msKIVWLEs5Wve3fGh3MFmWKGsWhXsnmXrfMeqKYYcOsVM7xL3kec2j6BkYfAJTuWRcXphqy1HOJvsuuz8vUNm/e6OTQJNf7YQSAhuA2+13j6qkNZLOwKyTcmQ/a2lrlHonMzE50rMAJSb1sphOqbkyChUUmrE4GtBm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNWK/UBb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNWK/UBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D47C4CEE7;
	Sat, 27 Sep 2025 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758993657;
	bh=wS3DRm04+H3K/wyL5VDDsA9Fi2Z1LU9EV49a582r2IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNWK/UBbP6w9c8vIsjQlBmz8eWNW21TxeqJvX4kN5rrCtmMJaksWy3ght2ItZ8tEX
	 eLLrZrPQap4md+TiIU6cJ2iW76MlOzOVAXQ1iybr1DDvjYwmVyJlDNUifDNclmZdbQ
	 Zh96sIVhNCwh9W2wvZmvfnqmrFaTKI0fryK8ErnU2C/AvYQmdPhO1Ds2pnYFznb1g/
	 5OUHXz59ZS4kAKaosPqZpWWiJmaPqh0vs4ae9/xra34D0HyCVDiI/o6JxyieHgI11+
	 32XFj5LvPmcQRcc8GH4Ns+TE1COhMc6IOuiW7d5lmk2aVRLxQ/O1LzrRWdHRwFEvvv
	 KsxzyxZdqOuTw==
From: SeongJae Park <sj@kernel.org>
To: "jianyun.gao" <jianyungao89@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
	linux-kernel@vger.kernel.org (open list),
	kasan-dev@googlegroups.com (open list:KMSAN)
Subject: Re: [PATCH] mm: Fix some typos in mm module
Date: Sat, 27 Sep 2025 10:20:55 -0700
Message-Id: <20250927172055.54527-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250927080635.1502997-1-jianyungao89@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Sep 2025 16:06:34 +0800 "jianyun.gao" <jianyungao89@gmail.com> wrote:

> Below are some typos in the code comments:
> 
>   intevals ==> intervals
>   addesses ==> addresses
>   unavaliable ==> unavailable
>   facor ==> factor
>   droping ==> dropping
>   exlusive ==> exclusive
>   decription ==> description
>   confict ==> conflict
>   desriptions ==> descriptions
>   otherwize ==> otherwise
>   vlaue ==> value
>   cheching ==> checking
>   exisitng ==> existing
>   modifed ==> modified
> 
> Just fix it.

Thank you for fixing those!

> 
> Signed-off-by: jianyun.gao <jianyungao89@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
