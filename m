Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4486D611C
	for <damon@lists.linux.dev>; Fri, 19 May 2023 09:12:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3935E1FB;
	Fri, 19 May 2023 02:13:08 -0700 (PDT)
Received: from [10.57.73.191] (unknown [10.57.73.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9EC43F73F;
	Fri, 19 May 2023 02:12:21 -0700 (PDT)
Message-ID: <692e9e7e-ee00-368b-6a31-60a895f7011c@arm.com>
Date: Fri, 19 May 2023 10:12:20 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] mm: Add new ptep_deref() helper to fully
 encapsulate pte_t
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 damon@lists.linux.dev
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-5-ryan.roberts@arm.com>
 <CAOUHufZaiTCxk4M4w5GaA-+5FoMnHZt+fzoU=cYCA1Ldk7CVEQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufZaiTCxk4M4w5GaA-+5FoMnHZt+fzoU=cYCA1Ldk7CVEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/05/2023 20:28, Yu Zhao wrote:
> On Thu, May 18, 2023 at 5:07 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> There are many call sites that directly dereference a pte_t pointer.
>> This makes it very difficult to properly encapsulate a page table in the
>> arch code without having to allocate shadow page tables. ptep_deref()
>> aims to solve this by replacing all direct dereferences with a call to
>> this function.
>>
>> The default implementation continues to just dereference the pointer
>> (*ptep), so generated code should be exactly the same. However, it is
>> possible for the architecture to override the default with their own
>> implementation, that can (e.g.) hide certain bits from the core code, or
>> determine young/dirty status by mixing in state from another source.
>>
>> While ptep_get() and ptep_get_lockless() already exist, these are
>> implemented as atomic accesses (e.g. READ_ONCE() in the default case).
>> So rather than using ptep_get() and risking performance regressions,
>> introduce an new variant.
> 
> We should reuse ptep_get():
> 1. I don't think READ_ONCE() can cause measurable regressions in this case.
> 2. It's technically wrong without it.

Can you clarify what you mean by technically wrong? Are you saying that the
current code that does direct dereferencing is buggy?

I previously convinced myself that the potential for the compiler generating
multiple loads was safe because the code in question is under the PTL so there
are no concurrent stores. And we shouldn't see any tearing for the same reason.

That said, if there is concensus that we can just use ptep_get() (==
READ_ONCE()) everywhere, then I agree that would be cleaner. Does anyone object?

