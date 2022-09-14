Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4815AC
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 00:35:12 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPjh8er_1663115702;
Received: from 192.168.1.6(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPjh8er_1663115702)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 08:35:03 +0800
Message-ID: <936d9ace-45b5-6579-b1c6-872055cce979@linux.alibaba.com>
Date: Wed, 14 Sep 2022 08:35:01 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH] mm/damon: simplify scheme create in lru_sort.c
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20220913154321.45954-1-sj@kernel.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220913154321.45954-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2022/9/13 下午11:43, SeongJae Park 写道:
> I'd like to apply your patch and then rebase my cleanups on it, but it might be
> not a one second work.  Could I ask you to wait until my cleanups are done?  I
> will post the patches within this week.
Ok,  thanks.
