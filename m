Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160A92114
	for <damon@lists.linux.dev>; Fri, 19 May 2023 08:53:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0451D1FB;
	Fri, 19 May 2023 01:54:31 -0700 (PDT)
Received: from [10.57.73.191] (unknown [10.57.73.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBC533F73F;
	Fri, 19 May 2023 01:53:43 -0700 (PDT)
Message-ID: <2ee0f754-6959-4fa8-0020-06f2d7fc76e4@arm.com>
Date: Fri, 19 May 2023 09:53:42 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] mm: damon must atomically clear young on ptes and
 pmds
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 damon@lists.linux.dev
References: <20230518171323.83828-1-sj@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230518171323.83828-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/05/2023 18:13, SeongJae Park wrote:
> Hi Ryan,
> 
> 
> Nit.  For consistency of DAMON commits subjects, I'd prefer something like
> "mm/damon/ops-common: atomically test and clear young on ptes and pmds".
> 
> On Thu, 18 May 2023 12:07:24 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> It is racy to non-atomically read a pte, then clear the young bit, then
>> write it back as this could discard dirty information. Further, it is
>> bad practice to directly set a pte entry within a table. Instead
>> clearing young must go through the arch-provided helper,
>> ptep_test_and_clear_young() to ensure it is modified atomically and to
>> give the arch code visibility and allow it to check (and potentially
>> modify) the operation.
>>
>> Fixes: 46c3a0accdc4 ("mm/damon/vaddr: separate commonly usable functions")
> 
> Nit.  The commit is only for refactoring.  The original code camde from commit
> 3f49584b262c ("mm/damon: implement primitives for the virtual memory address
> spaces").
> 
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
> 
> Other than above nits,
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks for the reviews! I'll fix the nits you raised for v3.

> 
> 
> Thanks,
> SJ
> 
