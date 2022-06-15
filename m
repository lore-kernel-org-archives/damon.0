Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19B7A
	for <damon@lists.linux.dev>; Wed, 15 Jun 2022 10:51:19 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VGScbZb_1655286616;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VGScbZb_1655286616)
          by smtp.aliyun-inc.com;
          Wed, 15 Jun 2022 17:50:17 +0800
Reply-To: xhao@linux.alibaba.com
To: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev
From: Xin Hao <xhao@linux.alibaba.com>
Subject: about DAMON lru_sort
Message-ID: <fe3e0a37-130d-0cda-2104-90a476193262@linux.alibaba.com>
Date: Wed, 15 Jun 2022 17:50:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi sj,

     I have seen the DAMON + LRU codes detailedly， i really think it is 
a good idea, but i have a few question,  why we can not to monitor whole 
per node zone automatically,  i think it is hard to pass a physical 
address when you do not  sure which physical address range to choose.

     for example,  i do not care which physical address range need to be 
minitored, i just want know the whole memory which includes how much 
inactive pages and

to better reclaim them.

     I just put forward my idea in a superficial way and look forward to 
your reply，thanks.

-- 
Best Regards!
Xin Hao

