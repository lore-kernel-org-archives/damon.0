Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037129A2
	for <damon@lists.linux.dev>; Tue, 14 Feb 2023 06:49:56 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vbeknu._1676357391;
Received: from 30.97.48.79(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vbeknu._1676357391)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 14:49:52 +0800
Message-ID: <a712d178-e524-fea7-a459-dd884956fc6b@linux.alibaba.com>
Date: Tue, 14 Feb 2023 14:49:51 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 0/3] Some cleanups for page isolation
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, sj@kernel.org,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeelb@google.com, muchun.song@linux.dev, damon@lists.linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1676342827.git.baolin.wang@linux.alibaba.com>
 <Y+sTFqwMNAjDvxw3@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Y+sTFqwMNAjDvxw3@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2023 12:50 PM, Matthew Wilcox wrote:
> On Tue, Feb 14, 2023 at 11:18:05AM +0800, Baolin Wang wrote:
>> The page isolation functions did not return a boolean to indicate
>> success or not, instead it will return a negative error when failed
>> to isolate a page. So it's better to check the negative error explicitly
>> for isolation to make the code more clear per Linus's suggestion in [1].
> 
> Only one caller of isolate_lru_page() or folio_isolate_lru() actually
> uses the errno.  And the errno can only be 0 or -EBUSY.  It'd be
> better to change the three functions to return bool and fix
> add_page_for_migration() to set the errno to -EBUSY itself.

Sounds reasonable to me, and I can change them to return bool in next 
version. Thanks.
