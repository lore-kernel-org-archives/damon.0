Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E704332FE
	for <damon@lists.linux.dev>; Fri,  2 Jun 2023 17:14:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2F771063;
	Fri,  2 Jun 2023 10:15:13 -0700 (PDT)
Received: from [10.57.73.214] (unknown [10.57.73.214])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98FA3F67D;
	Fri,  2 Jun 2023 10:14:26 -0700 (PDT)
Message-ID: <640f81aa-035e-9f42-c848-096e4c9e014c@arm.com>
Date: Fri, 2 Jun 2023 18:14:25 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/4] mm/damon/ops-common: atomically test and clear
 young on ptes and pmds
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev
References: <20230602092949.545577-1-ryan.roberts@arm.com>
 <20230602092949.545577-3-ryan.roberts@arm.com>
 <CAOUHufb5R_+eMxM28WWxXubPzUO4+c_1UHoXVAcWsKEyG1ndAQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufb5R_+eMxM28WWxXubPzUO4+c_1UHoXVAcWsKEyG1ndAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/06/2023 17:35, Yu Zhao wrote:
> On Fri, Jun 2, 2023 at 3:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> It is racy to non-atomically read a pte, then clear the young bit, then
>> write it back as this could discard dirty information. Further, it is
>> bad practice to directly set a pte entry within a table. Instead
>> clearing young must go through the arch-provided helper,
>> ptep_test_and_clear_young() to ensure it is modified atomically and to
>> give the arch code visibility and allow it to check (and potentially
>> modify) the operation.
>>
>> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces").
> 
> Just to double check: was "Cc: stable@vger.kernel.org" overlooked or
> deemed unnecessary?

It was overlooked - incompetance strikes again! I was intending to cc the whole
series. What's the best way to fix this? Can I just add stable in cc on reply to
the cover letter or will I have to resend the lot?

> 
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: SeongJae Park <sj@kernel.org>
>> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

