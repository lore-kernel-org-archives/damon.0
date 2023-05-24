Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B819919523
	for <damon@lists.linux.dev>; Wed, 24 May 2023 19:11:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60FBF1042;
	Wed, 24 May 2023 12:12:27 -0700 (PDT)
Received: from [10.57.74.16] (unknown [10.57.74.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 517853F762;
	Wed, 24 May 2023 12:11:40 -0700 (PDT)
Message-ID: <b818b1f6-f822-477c-6674-6860c84ffdc7@arm.com>
Date: Wed, 24 May 2023 20:11:38 +0100
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
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 damon@lists.linux.dev
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-5-ryan.roberts@arm.com>
 <20230524190618.GR4967@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230524190618.GR4967@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/05/2023 20:06, Mike Rapoport wrote:
> On Thu, May 18, 2023 at 12:07:26PM +0100, Ryan Roberts wrote:
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
>>
>> Call sites will be converted to use the accessor in future commits.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/pgtable.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index c5a51481bbb9..1161beab2492 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -204,6 +204,13 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>  #endif
>>  
>> +#ifndef ptep_deref
>> +static inline pte_t ptep_deref(pte_t *ptep)
>> +{
>> +	return *(pte_t *)ptep;
> 
> Why do you need the casting here?

I don't - good spot. Will fix for v3.

This is some residue from one of the approaches I took to finding all the call
sites, where I globally did s/pte_t */pte_handle_t/ and typedef'ed pte_handle_t
as a void*. Then the compiler would error on any attempted dereferences, but I
had to explicitly cast in the places that could legitimately dereference.

Thanks for the reviews.

> 
>> +}
>> +#endif
>> +
>>  #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>>  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>>  					    unsigned long address,
>> -- 
>> 2.25.1
>>
>>
> 

