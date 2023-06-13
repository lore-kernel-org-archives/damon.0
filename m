Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495CC23A5
	for <damon@lists.linux.dev>; Tue, 13 Jun 2023 08:53:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BED11FB;
	Tue, 13 Jun 2023 01:53:47 -0700 (PDT)
Received: from [10.57.74.148] (unknown [10.57.74.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130BE3F71E;
	Tue, 13 Jun 2023 01:52:56 -0700 (PDT)
Message-ID: <d38dc237-6093-d4c5-993e-e8ffdd6cb6fa@arm.com>
Date: Tue, 13 Jun 2023 09:52:55 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 0/3] Encapsulate PTE contents from non-arch code
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mike Rapoport <rppt@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Alex Williamson <alex.williamson@redhat.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeelb@google.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-kernel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>, damon@lists.linux.dev
References: <20230612151545.3317766-1-ryan.roberts@arm.com>
 <3ECE40AA-536E-4A2C-82BA-FE74AA6FB689@linux.dev>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3ECE40AA-536E-4A2C-82BA-FE74AA6FB689@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/2023 03:16, Muchun Song wrote:
> 
> 
>> On Jun 12, 2023, at 23:15, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Hi All,
>>
>> (Including wider audience this time since changes touch a fair few subsystems)
>>
>> This is the second half of v3 of a series to improve the encapsulation of pte
>> entries by disallowing non-arch code from directly dereferencing pte_t pointers.
>> Based on earlier feedback, I split the series in 2; the first part, fixes for
>> existing bugs, was already posted at [3] and merged into mm-stable. This second
>> part contains the conversion from direct dereferences to instead use
>> ptep_get()/ptep_get_lockless().
>>
>> See the v1 cover letter at [1] for rationale for this work.
>>
>> Based on feedback at v2, I've removed the new ptep_deref() helper I originally
>> added, and am now using the existing ptep_get() and ptep_get_lockless() helpers.
> 
> When I first saw the name of ptep_get()/ptep_get_lockless(), I thought
> the pte seems like to be protected by the refcount mechanism (Why I have
> this though? Because Qi Zheng has proposed a approach to free pte page tables
> by using the refcount mechanism [1]). And your proposed name of ptep_deref()
> is intuitive for me, so I have another thought, should we rename ptep_get()
> to ptep_deref()? Just a thought from me, I'd like to hear if others object.

I see your point, but I think any renaming exercise should be discussed and
applied in the context of a separate patch series, given that ptep_get() and
ptep_get_lockless() already exist in the code base. This would be a much bigger
job, since it would need to cover all the arch code too.

> 
> Thanks.
> 
> [1] https://lore.kernel.org/lkml/20211110105428.32458-7-zhengqi.arch@bytedance.com/

