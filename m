Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7BF1F5EA
	for <damon@lists.linux.dev>; Sun, 28 Sep 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759064010; cv=none; b=oTusVKtPY6ZBJOpYnAm4MuH6S8h1UohZS7MHFsFNEfZBRobU+sNCRAtH5RL4ygWcMVPbPsCSygSu0B0J6nxzCvDybGRLNLY3TLOTn+SUQgXbMGb93LxUI1dmlDqPTZPU4vBkTJguA/erBWWDpK/FqHUiMObEzGji84oYz4mNqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759064010; c=relaxed/simple;
	bh=WRMuH8FjcGi3m2sUC+ywTerdReat98QUnEtjEjKvkr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCKx0fpiJzzUEYrqQnha8uXhNW/aJGJIKxW/3KZWzahNMJGSRPB5zQpbG/dSswr4GniuSsKIMwnbYW6SfJNhdqlWDDZPQ/5rP0M0uRn9qZBrFGHOr4jLcoKLqUPBUH8a89hRJh4K72XQ0rN4LJWWoDRThme/+gFbrupb7ulrV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7006150C;
	Sun, 28 Sep 2025 05:53:12 -0700 (PDT)
Received: from [10.163.64.48] (unknown [10.163.64.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 120893F694;
	Sun, 28 Sep 2025 05:53:09 -0700 (PDT)
Message-ID: <3c3f9032-18ac-4229-b010-b8b95a11d2a4@arm.com>
Date: Sun, 28 Sep 2025 18:23:06 +0530
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix some typos in mm module
To: "jianyun.gao" <jianyungao89@gmail.com>, linux-mm@kvack.org
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 "open list:DATA ACCESS MONITOR" <damon@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KMSAN" <kasan-dev@googlegroups.com>
References: <20250927080635.1502997-1-jianyungao89@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250927080635.1502997-1-jianyungao89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/09/25 1:36 pm, jianyun.gao wrote:
> Below are some typos in the code comments:
>
>    intevals ==> intervals
>    addesses ==> addresses
>    unavaliable ==> unavailable
>    facor ==> factor
>    droping ==> dropping
>    exlusive ==> exclusive
>    decription ==> description
>    confict ==> conflict
>    desriptions ==> descriptions
>    otherwize ==> otherwise
>    vlaue ==> value
>    cheching ==> checking
>    exisitng ==> existing
>    modifed ==> modified
>
> Just fix it.
>
> Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>

