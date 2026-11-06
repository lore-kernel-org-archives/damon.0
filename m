Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934346;
	b=Dwn9/L9O1mtAkRyxoDo3I5xugg0Nu4u50dH8SFg/TwxP56Y5n39LXaW+zrkfRWKh3FfD
	 shmN0RRlkVwew356GtNaoh0mFRZAkehsJdzWkx7CkVXuNUJOU/SHDBH4taIH6Necyg7ys
	 SGWSheARQ6AnQKZoLbGKx4T60ZzUywpMvqdOTrjqv89RLk4byqFxycvnj62oU+gkxwndJ
	 +5kCqQlBoi2hZvghF5jenJPlLd7g/WLwul9xaVWl7nHBjzT738VXyCJq468VWKPZrZsvo
	 hD//eYvM3Z/Oo/II8bHqczo7Ymbegu86iGj9d/DeawLfujLfmUi/mUhqs5MTZOzUUvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934346;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7Aof237vDO4qMTTpfPlwofHadKxllvqKaM/oePbLGkw=;
	b=jOcmEkbbIdOZO5NGs06MPLBTPnBMCHq1UiYa4JKNe4nu1WGkvvkAnPGpCj+Tr67MJlyc
	 AY/I+EIvjgCR5LHAOuCLDHMGp+Ca6T4EtxonmWVB5Wvh/gZkilqJOebf9kMNDfyDG5nNZ
	 7chdcFSIr23CnwDR9z7KPDhanV9J5+tWxSn9WUdgDYJWHQMuxcxLULe2eCLgciiL4OaBv
	 U8Mye2YTS8m7xtiR5H4S/J6NoJ+GBs8R1RcVfBy8mQZhVRflOG9ZHCy0iugWwgGQVxvfU
	 yPxQDdkFU7zw33tj1h4giTirMWv4SDMXIltLu9G246eWd+KNIuvpq6Qda6HKu/ckN7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AH2kkJao;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580F606A31B
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 03:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1580F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AH2kkJao
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793934342; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7Aof237vDO4qMTTpfPlwofHadKxllvqKaM/oePbLGkw=;
	b=AH2kkJaotGhIDo4RYG9oDBUXGVlCAWbS3rpUEMd2mM8eWEDOFt+UbF2bfDE4EG4e1FDGhkA1dqLkYDZzxPHQBiVyxkvrN2MltvBiRxSZaA8YJvs51UGsWnHvOcQMhJ9UuUG4nd8wltji2YKrIpNJPF/u/MR7lUAV1e7/yJDC4sQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=88;SR=0;TI=SMTPD_---0XEA9EV0_1793934336;
Received: from 30.74.144.130(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEA9EV0_1793934336 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 11:05:39 +0800
Message-ID: <4bc884a1-a04d-4ccd-8934-2095beb08251@linux.alibaba.com>
Date: Fri, 6 Nov 2026 11:05:36 +0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] mm/migrate: convert VMA flag tests to use
 vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>,
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
 David Rientjes <rientjes@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, John Johansen
 <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 5:30 AM, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> migration logic.
> 
> We retain the READ_ONCE() of vma->vm_flags in remove_migration_pte(), as
> there is no vma_flags_t equivalent, and arch_make_huge_pte() continues to
> take legacy flags for the time being.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
